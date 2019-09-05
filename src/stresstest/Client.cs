using System;
using System.Net.Http;

namespace stresstest
{
    class Client
    {
        private HttpClient httpClient;

        public Client(string loadBalancerIpAddress)
        {
            httpClient = new HttpClient();
            httpClient.BaseAddress = new Uri($"http://{loadBalancerIpAddress}/");
        }
        internal async void SendRequests()
        {
            while (true)
            {
                try
                {
                    HttpResponseMessage response = await httpClient.GetAsync("");    
                    if (response.IsSuccessStatusCode)
                    {
                        Console.WriteLine($"Received response {response.Content.ReadAsStringAsync().Result}");
                    }
                    else
                    {
                        Console.WriteLine($"{(int)response.StatusCode}, {response.ReasonPhrase}");
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine($"Error sending request to Load Balancer: {e.Message}");
                }
            }
        }
    }
}
