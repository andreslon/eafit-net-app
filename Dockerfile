#---------------- Compile .NET Application ----------------
# Get Base Image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
# Set Build Configurations
ARG configuration=Release
# Copy Code to Container
COPY . .
# Run commands to compile
RUN dotnet publish "eafit.app/eafit.app.csproj" -c $configuration -o /build /p:UseAppHost=false

#---------------- Run .NET Application ----------------
# Get Base Image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
# Set Run Configurations
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
# Copy compiled code to run
COPY --from=build /build .
ENTRYPOINT ["dotnet", "eafit.app.dll"]