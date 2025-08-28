
import os
import asyncio
from azure.identity.aio import DefaultAzureCredential
from azure.mgmt.resource.resources.aio import ResourceManagementClient

async def main():
    """
    Main function to authenticate and list resource groups.
    """
    print("Authenticating to Azure...")
    # Authenticate using environment variables:
    # AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID
    credential = DefaultAzureCredential()
    subscription_id = os.environ.get("AZURE_SUBSCRIPTION_ID")

    if not subscription_id:
        print("Error: AZURE_SUBSCRIPTION_ID environment variable is not set.")
        return

    resource_client = ResourceManagementClient(credential, subscription_id)

    print("Fetching resource groups...")
    try:
        async for rg in resource_client.resource_groups.list():
            print(f"- {rg.name}")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        await credential.close()
        await resource_client.close()

if __name__ == "__main__":
    asyncio.run(main())
