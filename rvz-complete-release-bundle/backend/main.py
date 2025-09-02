from fastapi import FastAPI
app = FastAPI(title='RVZ Travel Backend Placeholder')
@app.get('/health')
def health(): return {'ok': True}
