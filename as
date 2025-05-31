import asyncio
import aiohttp

async def fetch_weather_async(session, city):
    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric"
    async with session.get(url) as response:
        return await response.json()

async def fetch_users_async(session):
    url = "https://jsonplaceholder.typicode.com/users"
    async with session.get(url) as response:
        return await response.json()

async def main_async():
    city = "London"
    async with aiohttp.ClientSession() as session:
        weather_task = asyncio.create_task(fetch_weather_async(session, city))
        users_task = asyncio.create_task(fetch_users_async(session))

        weather_data, users_data = await asyncio.gather(weather_task, users_task)

        # Обработка погоды
        if weather_data.get("main"):
            temp = weather_data["main"]["temp"]
            desc = weather_data["weather"][0]["description"]
            print(f"Асинхронно: Погода в {city}: {temp}°C, {desc}")
        else:
            print("Асинхронно: Не удалось получить данные о погоде.")

        # Обработка пользователей
        print("\nАсинхронно: Список пользователей:")
        for user in users_data:
            print(f"{user['id']}. {user['name']} - {user['email']}")

if __name__ == "__main__":
    asyncio.run(main_async())
