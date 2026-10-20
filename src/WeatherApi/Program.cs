var builder = WebApplication.CreateBuilder(args);
builder.Services.AddHealthChecks();

var app = builder.Build();

app.MapHealthChecks("/health");

string[] summaries = ["Freezing", "Cold", "Mild", "Warm", "Hot"];

app.MapGet("/weather", () =>
    Enumerable.Range(1, 5).Select(day => new WeatherForecast(
        DateOnly.FromDateTime(DateTime.UtcNow.AddDays(day)),
        Random.Shared.Next(-10, 35),
        summaries[Random.Shared.Next(summaries.Length)])));

app.Run();

public record WeatherForecast(DateOnly Date, int TemperatureC, string Summary);
