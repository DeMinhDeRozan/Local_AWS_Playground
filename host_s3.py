import boto3

s3_client = boto3.client(
    's3',
    endpoint_url='http://localhost:4566',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='ap-southeast-2'
)

bucket_name = 'my-bucket-1'
file_key = 'index.html'

try:
    print(f" Loading '{file_key}' from bucket '{bucket_name}'...")
    response = s3_client.get_object(Bucket=bucket_name, Key=file_key)
    
    content = response['Body'].read().decode('utf-8')
    print("\n---READ CONTENT")
    print(content[:300] + "..." if len(content) > 300 else content)
    print("--------------------------------------\n")

    url = s3_client.generate_presigned_url(
        'get_object',
        Params={'Bucket': bucket_name, 'Key': file_key},
        ExpiresIn=3600 
    )
    
    print(f"Successfully")
    print(f"Presigned URL: {url}")

except Exception as e:
    print(f" File not found {e}")
