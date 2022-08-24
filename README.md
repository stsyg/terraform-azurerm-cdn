# Deployment of Azure CDN

No Azure Front Door deployment. Just Azure CDN.

The following resources will be created:
- Azure CDN
- Azure CDN profile


Before deleting CDN Endpoint, the associated CNAME needs to be deleted. The following error will be presented if CNAME record still exist:

"Cannot delete custom domain "www.abc.com" because it is still directly or indirectly (using "cdnverify" prefix) CNAMEd to CDN endpoint "the38photo.azureedge.net". Please remove the DNS CNAME record and try again."

Note: do not forget to return CNAME record to the DNS before CDN Endpoint creation

To-Do:
- Move DNS record registration to Azure DNS