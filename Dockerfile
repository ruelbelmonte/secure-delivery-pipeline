FROM mcr.microsoft.com/dotnet/sdk:10.0@sha256:212fe4cb74627d5adf9817a4088906ae3edff1bd853bb27565d4b46731efe61e AS build
WORKDIR /src
COPY global.json Directory.Build.props ./
COPY src/WeatherApi/WeatherApi.csproj src/WeatherApi/packages.lock.json src/WeatherApi/
RUN dotnet restore src/WeatherApi/WeatherApi.csproj --locked-mode
COPY src/WeatherApi/ src/WeatherApi/
RUN dotnet publish src/WeatherApi/WeatherApi.csproj -c Release -o /app --no-restore

# Chiseled: no shell or package manager, runs as the non-root "app" user (UID 1654).
FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble-chiseled@sha256:f2557fb81b1cfcfdfcde9d3bf247ed60b2cd38f00a88153f61e34737fab8ade7
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
EXPOSE 8080
ENTRYPOINT ["dotnet", "WeatherApi.dll"]
