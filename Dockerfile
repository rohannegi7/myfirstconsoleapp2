# Use the official .NET SDK image as a base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Build the .NET application
RUN dotnet publish -c Release -o out

# Use the official ASP.NET runtime image as the base image for the final/runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory to /app
WORKDIR /app

# Copy the published output from the build stage into the runtime image
COPY --from=build /app/out .

# Start the application
ENTRYPOINT ["dotnet", "MyFirstConsoleApp.dll"]
