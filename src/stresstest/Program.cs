using System;
using System.Configuration;
using System.Threading;
using System.Threading.Tasks;

namespace stresstest
{
    class Program
    {
        private static CancellationTokenSource tokenSource = new CancellationTokenSource();

        static void Main(string[] args)
        {
            int numClients = int.Parse(ConfigurationManager.AppSettings["NumClients"]);
            string loadBalancerIpAddress = args[0];

            try
            {
                var driver = new ClientDriver(numClients, loadBalancerIpAddress);
                var token = tokenSource.Token;
                Task.Factory.StartNew(() => driver.Run(token));
                Task.Factory.StartNew(() => driver.WaitForEnter(tokenSource));
                driver.runCompleteEvent.WaitOne();
            }
            catch (Exception e)
            {
                Console.WriteLine($"Application failed with error: {e.Message}");
            }
        }
    }
}
