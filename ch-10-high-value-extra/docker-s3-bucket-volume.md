# Using Amazon S3 Bucket as a Docker Volume (via s3fs-fuse)

This guide demonstrates how to mount an **Amazon S3 bucket** as a local filesystem using `s3fs-fuse`, and then use it as a **Docker bind mount volume**.

> ⚠️ Note: `s3fs` is suitable for light workloads, backups, or static content. It is **not recommended for high IOPS or database workloads** due to S3’s object storage semantics.

---

## Architecture Overview

```
Docker Container
        │
        ▼
Bind Mount (/var/www/html)
        │
        ▼
Local Mount Point (/mnt/mys3bucket)
        │
        ▼
s3fs-fuse
        │
        ▼
Amazon S3 Bucket
```

---

## Prerequisites

* Linux system (Ubuntu/Debian-based)
* Docker installed
* AWS Account
* IAM user with S3 permissions

---

# Step 1 – Install `s3fs-fuse`

```bash
sudo apt update
sudo apt-get install -y s3fs
```

Verify installation:

```bash
s3fs --version
```

---

# Step 2 – Create an S3 Bucket

Create a bucket from the AWS Console or CLI.

## Example Bucket Policy (Public Read Access)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::DOC-EXAMPLE-BUCKET/*"
    }
  ]
}
```

> ⚠️ Replace `DOC-EXAMPLE-BUCKET` with your actual bucket name.

### Security Recommendation

For production environments:

* Avoid public read unless absolutely necessary.
* Prefer private buckets with IAM-based access control.

---

# Step 3 – Create IAM User for S3 Access

Create an IAM user with programmatic access and attach policy:

* `AmazonS3FullAccess` (not recommended for production)

OR

* Custom least-privilege policy limited to your specific bucket.

---

## Store AWS Credentials for s3fs

Create credential file:

```bash
echo "aws-access-key:aws-secret-key" > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

Example:

```bash
echo "AKIAXXXXX:abcd1234secret" > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

---

# Step 4 – Mount S3 Bucket Locally

Create mount directory:

```bash
sudo mkdir -p /mnt/mys3bucket
```

Mount bucket:

```bash
s3fs your-s3-bucket-name /mnt/mys3bucket \
-o allow_other \
-o url=https://s3.amazonaws.com
```

Replace:

```
your-s3-bucket-name
```

Verify mount:

```bash
df -h
```

You should see your S3 bucket mounted at `/mnt/mys3bucket`.

---

## Optional: Persistent Mount (fstab)

To auto-mount on reboot:

Add to `/etc/fstab`:

```bash
s3fs#your-s3-bucket-name /mnt/mys3bucket fuse _netdev,allow_other,url=https://s3.amazonaws.com 0 0
```

---

# Step 5 – Use S3 Mount as Docker Volume

Run Docker container using bind mount:

```bash
docker run -d \
--name boxone \
-v /mnt/mys3bucket:/var/www/html \
lovelearnlinux/webserver:v1
```

Now:

* Files written to `/var/www/html` inside container
* Are stored in S3 bucket

---

# Verification

Inside container:

```bash
docker exec -it boxone bash
cd /var/www/html
touch testfile.txt
```

Check S3 bucket — file should appear.

---


# Summary

| Component   | Purpose                    |
| ----------- | -------------------------- |
| S3          | Object storage backend     |
| s3fs        | Mount S3 as filesystem     |
| Local mount | Bind mount target          |
| Docker      | Consumes mounted directory |

