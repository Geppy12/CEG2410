# S3 Static Website Hosting

## The Endpoint

After configuring static website hosting in Amazon S3, AWS provided a **Bucket Website Endpoint URL** that allows the website to be accessed publicly on the internet.

Example Endpoint:

```
http://bryce-static-site.s3-website-us-east-1.amazonaws.com
```

This endpoint serves the website directly from the S3 bucket without needing a traditional web server such as Apache or Nginx.

---

## The Policy

The following JSON **Bucket Policy** was applied to allow public access to the files stored in the S3 bucket.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::bryce-static-site/*"
    }
  ]
}
```

### Explanation

**Effect**

```
"Effect": "Allow"
```

This tells AWS that the action defined in the policy is allowed.

---

**Principal**

```
"Principal": "*"
```

The asterisk means **any user on the internet** can access the objects inside the bucket.

---

**Action**

```
"Action": "s3:GetObject"
```

This allows users to **retrieve files from the bucket**, such as HTML pages, CSS files, or images.

---

**Resource**

```
"Resource": "arn:aws:s3:::bryce-static-site/*"
```

This specifies that the permission applies to **all files inside the bucket**.

---

## Static Website Hosting Configuration

In the bucket **Properties** section, Static Website Hosting was enabled with the following configuration:

* Index document: `index.html`
* Error document: `error.html`

These files define the homepage of the website and the error page if a file cannot be found.

---

## Content Upload

The following files were uploaded to the root of the S3 bucket:

* `index.html`
* `error.html`

These files allow the S3 bucket to serve a simple static website.

---

## Comparison

### Advantage of S3 Hosting

One advantage of hosting a website using Amazon S3 is that it is **serverless**. This means there is no need to manage or maintain a web server. AWS automatically handles the storage, scalability, and availability.

### Disadvantage of S3 Hosting

A disadvantage is that S3 can only host **static websites**. It cannot run dynamic server-side applications such as PHP, Node.js, or databases like a traditional Apache server running on an EC2 instance.

---

## Screenshot

Below is a screenshot showing the static website loading from the S3 Website Endpoint.

```
Insert screenshot of the S3 website endpoint loading in a browser here.
```
