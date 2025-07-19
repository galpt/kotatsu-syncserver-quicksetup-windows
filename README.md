# Kotatsu Sync Server - Windows Quick Setup

This is a Windows-optimized setup for running the Kotatsu Synchronization Server locally. Everything is included and ready to go - just run the batch files!

## What is Kotatsu?

Kotatsu is a free and open source manga reader for Android platform. This sync server allows you to synchronize your favorites, history, and categories across multiple devices.

## Prerequisites

- Docker Desktop for Windows
- Docker Compose (included with Docker Desktop)

## Super Easy Setup (Windows)

1. **Download and extract this folder** to your desired location

2. **Start the server** - Just double-click `start.bat`
   
   ⚠️ **Note**: The first startup will take several minutes as Docker builds the Kotatsu sync server from source code. This is normal!

3. **Check if it's working** - Double-click `logs.bat` to see the status
   Wait until you see messages indicating both MySQL and the sync server are ready.

4. **Stop the server** - Double-click `stop.bat` when you're done

5. **Access your sync server**
   Your Kotatsu sync server will be available at: `http://localhost:8081`

## Configuration

### Default Settings

- **Sync Server URL**: `http://localhost:8081`
- **MySQL Database**: `kotatsu_sync`
- **MySQL User**: `kotatsu_user`
- **MySQL Password**: `kotatsu_password`
- **New Registration**: Enabled (set to `true`)

### Security Settings

⚠️ **Important**: Before using in production, change these default values:

1. **JWT Secret**: Edit `docker-compose.yml` and change `JWT_SECRET`
2. **Database Passwords**: Change MySQL passwords in the environment variables
3. **Disable Registration**: After creating your accounts, set `ALLOW_NEW_REGISTER=false`

### Configuring Kotatsu App

1. Open Kotatsu app on your Android device
2. Go to **Options** → **Settings** → **Services**
3. Select **Synchronization**
4. Set **Server address** to: `http://YOUR_COMPUTER_IP:8081`
   - Replace `YOUR_COMPUTER_IP` with your computer's local IP address
   - You can find your IP with: `ipconfig` (look for IPv4 Address)
5. Enter your email and create a password
6. Choose what to sync (favorites, history, or both)

## Management Commands (Windows)

### Start the server
Double-click `start.bat`

### Stop the server
Double-click `stop.bat`

### View logs
Double-click `logs.bat`

### Advanced users (Command line)
If you prefer using the command line:
```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Rebuild after updates
docker-compose build --no-cache
docker-compose up -d
```

## Updating to Latest Kotatsu Sync Server Version

To get the latest version of the Kotatsu sync server:

1. **Stop the current server** - Double-click `stop.bat`

2. **Download the latest source code**:
   - Go to https://github.com/KotatsuApp/kotatsu-syncserver
   - Click the green "Code" button → "Download ZIP"
   - Extract the downloaded ZIP file

3. **Replace the source code**:
   - Delete the existing `kotatsu-syncserver-master` folder in your setup directory
   - Copy the newly extracted folder to your setup directory
   - Rename it to `kotatsu-syncserver-master` (if it has a different name)

4. **Rebuild and start** - Double-click `start.bat`
   - Docker will automatically rebuild the image with the new source code
   - This will take a few minutes as it builds from scratch

**Note**: Your data (favorites, history) will be preserved as it's stored in the MySQL database, not in the application code.

## Data Persistence

Your data is stored in a Docker volume named `mysql_data`. This means your data will persist even if you stop and restart the containers.

To completely remove all data:
```bash
docker-compose down -v
```

## Troubleshooting

### Services won't start
1. Make sure Docker Desktop is running
2. Check if ports 8081 and 3306 are available
3. View logs: `docker-compose logs`

### Can't connect from Kotatsu app
1. Make sure your phone and computer are on the same network
2. Check Windows Firewall settings
3. Use your computer's IP address, not `localhost`
4. Verify the server is running: `docker-compose ps`

### Database connection issues
1. Wait for MySQL to fully initialize (can take 1-2 minutes)
2. Check MySQL logs: `docker-compose logs mysql`
3. Restart services: `docker-compose restart`

## File Structure

```
kotatsu-sync-server-quick-setup/
├── start.bat                    # Start the server (double-click)
├── stop.bat                     # Stop the server (double-click)
├── logs.bat                     # View server logs (double-click)
├── docker-compose.yml           # Docker Compose configuration
├── database.sql                 # MySQL database schema
├── README.md                    # This file
├── .env.example                 # Environment variables template
└── kotatsu-syncserver-master/   # Kotatsu sync server source code
    ├── Dockerfile               # Docker build instructions
    ├── src/                     # Application source code
    └── ... (other source files)
```

## Security Notes

- This setup is intended for local/home network use
- Default passwords should be changed for production use
- Consider using HTTPS in production environments
- Regularly backup your data

## Support

For issues with the Kotatsu app itself, visit:
- [Kotatsu GitHub Repository](https://github.com/KotatsuApp/Kotatsu)
- [Kotatsu Sync Server Repository](https://github.com/KotatsuApp/kotatsu-syncserver)

For Docker-related issues, check the logs and ensure Docker Desktop is properly configured.