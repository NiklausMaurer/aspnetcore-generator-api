# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env

WORKDIR /generator

# restore
COPY generator.sln ./
COPY api/api.csproj ./api/
COPY tests/tests.csproj ./tests/

RUN dotnet restore generator.sln

# copy src
COPY . ./

# test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

# publish
RUN dotnet publish api/api.csproj -o /publish


# Runtime stageg
FROM mcr.microsoft.com/dotnet/core/runtime:2.2
COPY --from=build-env /publish /publish

WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]