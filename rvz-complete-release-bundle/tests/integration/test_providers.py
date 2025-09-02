import os
import pytest
from backend.connectors import get_provider

@pytest.mark.skipif(not (os.getenv('AMADEUS_API_KEY') or os.getenv('BOOKING_API_KEY')), reason='No provider sandbox credentials')
def test_provider_stubs():
    providers = ['amadeus','booking','rentalcars','busprovider']
    for p in providers:
        prov = get_provider(p)
        resp = prov.confirm_booking({'client':'ci-test','details':{}})
        assert 'status' in resp
