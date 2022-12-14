FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
EXPOSE 80
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out
RUN dir out
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
RUN dir
ENTRYPOINT ["dotnet", "testing-project.dll"]
