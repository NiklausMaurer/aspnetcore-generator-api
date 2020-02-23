# Build Stage
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /api

# Copy csproj and restore as distinct layers
COPY api.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "api.dll"]