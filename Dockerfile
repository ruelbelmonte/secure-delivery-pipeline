FROM mcr.microsoft.com/dotnet/sdk:10.0@sha256:de4fe90a98845d75910b9769662465c84de1a934665c431279d1382b2bddc02b AS build
WORKDIR /src
COPY global.json Directory.Build.props ./
COPY src/WeatherApi/WeatherApi.csproj src/WeatherApi/packages.lock.json src/WeatherApi/
RUN dotnet restore src/WeatherApi/WeatherApi.csproj --locked-mode
COPY src/WeatherApi/ src/WeatherApi/
RUN dotnet publish src/WeatherApi/WeatherApi.csproj -c Release -o /app --no-restore

# Chiseled: no shell or package manager, runs as the non-root "app" user (UID 1654).
FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble-chiseled@sha256:84def277556c2843a44fdeefbd3145d0a2e32d8f736d0c1a7b0a96b2880b0187
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
EXPOSE 8080
ENTRYPOINT ["dotnet", "WeatherApi.dll"]
