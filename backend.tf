terraform { 
    backend "s3" {
        bucket = "bucketname"
        key = "key"
        region = "eu-west-1"
    }
}