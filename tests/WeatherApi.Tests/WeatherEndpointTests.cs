using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;

namespace WeatherApi.Tests;

public class WeatherEndpointTests(WebApplicationFactory<Program> factory) : IClassFixture<WebApplicationFactory<Program>>
{
    [Fact]
    public async Task Weather_ReturnsFiveFutureDays()
    {
        var forecasts = await factory.CreateClient()
            .GetFromJsonAsync<WeatherForecast[]>("/weather", TestContext.Current.CancellationToken);

        Assert.NotNull(forecasts);
        Assert.Equal(5, forecasts.Length);
        var today = DateOnly.FromDateTime(DateTime.UtcNow);
        Assert.All(forecasts, f =>
        {
            Assert.True(f.Date > today);
            Assert.InRange(f.TemperatureC, -10, 34);
            Assert.False(string.IsNullOrWhiteSpace(f.Summary));
        });
    }
}
