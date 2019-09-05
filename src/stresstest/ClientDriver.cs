using System;
using System.Threading;
using System.Threading.Tasks;

namespace stresstest
{
    class ClientDriver
    {
        public ManualResetEvent runCompleteEvent = new ManualResetEvent(false);
        private int numClients;
        private string loadBalancerIpAddress;

        public ClientDriver(int numClients, string loadBalancerIpAddress)
        {
            this.numClients = numClients;
            this.loadBalancerIpAddress = loadBalancerIpAddress;
        }

        public void Run(CancellationToken token)
        {
            var rnd = new Random();

            for (int clientNum = 0; clientNum < this.numClients; clientNum++)
            {
                var client = new Client(this.loadBalancerIpAddress);
                Task.Factory.StartNew(() => client.SendRequests());
            }

            while (!token.IsCancellationRequested)
            {
                // Run until the user stops the clients by pressing Enter
            }

            this.runCompleteEvent.Set();
        }

        public void WaitForEnter(CancellationTokenSource tokenSource)
        {
            Console.WriteLine("Press Enter to stop clients");
            Console.ReadLine();
            tokenSource.Cancel();
        }
    }
}
