from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from httpx import AsyncClient, AsyncHTTPTransport
from xml.etree.ElementTree import fromstring

GUARDIAN_RSS_URL = 'https://feeds.bbci.co.uk/news/rss.xml?edition=uk'

app = FastAPI()
app.add_middleware(CORSMiddleware, allow_origins=['*'], allow_methods=['*'], allow_headers=['*'], allow_credentials=True)

@app.get('/api/v1/news')
async def get_news():
    async with AsyncClient(transport=AsyncHTTPTransport(retries=3), timeout=30) as client:
        response = await client.get(GUARDIAN_RSS_URL)
        response.raise_for_status()

        items     = fromstring(response.text).findall('.//item')
        news_list = []

        for item in items:
            title    = item.find('title').text
            desc     = item.find('description').text
            pub_date = item.find('pubDate').text

            image = item.find('.//media:thumbnail', namespaces={
                'media' : 'http://search.yahoo.com/mrss/',
            })

            if title is not None:
                news_list.append({
                    'title'       : title,
                    'description' : desc,
                    'pubDate'     : pub_date,
                    'imageUrl'    : image.attrib['url'] if image is not None else None,
                })

        return news_list
