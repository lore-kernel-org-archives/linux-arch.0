Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580247;
	b=XvuvbGYNpx2q8y7EWSBVO5y+fYvK6hhkqM0ZbO7yvjLWt8xkWEdGomdY9m89k3UoX72v
	 tX0ZqtpC2HMn2WX7Nd2F4NhjRYUFbO+P99YpOXSzjPU1Ot7s1mTlTohRYxDYj41PInDsD
	 QQzxITVusfw8LXB0KlRyWgtVA/mNl7bbECCfr6Cq49tQYthTlN+g69rZFPkdZ4XPidRad
	 JuHJJx3JM1vyn0gLqSKf2Tg5gYLwAiLyStj5XynR9mmn5hKPWngkxu/y3pqCvNCa7lyrN
	 ebQVtQxvefrI68b7bqZBijY3GqoYfXxidUljCFjrubWGgDCraZ2ah/J03jU2UmQ6hdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
	b=TtTWJB2MsTo06cIlo+v4H8eSIyaHQHZaxoU8LQA6t8gs5x4vL0XfCiCpxhcBVvMSPdy8
	 4W1sTvfBwBcsU1qHnPGD/9/4ebt1IrmCTJU6V3dm3i6sNUYALGa2LdLgcElnK/TA2L2G0
	 brqAB+2lr7r9wiROk/vKrpqCNXNnEu+/WZY46WXdqcVAY66DK9eswyy80+VQWuvpfTkOi
	 TeyLRNQDlbQOgOGvPzITL10d5tEXkr8XA7JCt4S6RPZstNkrTJxdoExPa3bQyr/srurUH
	 3//KuMTGwgAoN+RdWbzbCzOeGvEhUwBwKygJC+76YyeFnLfOKHPa+BUMZcjkHJ5BrXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K9FHrqLd;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A96606A31D
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A96606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K9FHrqLd
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1fef02989so19535e9.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792580245; x=1793185045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
        b=K9FHrqLdKhEKTusfXH7+g6zbV+wQLcZ++y7rAvQ2nG+6gY68Z9U0wraZDGIHwlZiqg
         CmU++vYIR4Pg78vEHbkfdPvhIh7NMBf0Q/WjP8v7rmWVUDHChPaLm+4FK5thfmMVgwJv
         ngOi0+0nMoy4H1VKj23048LMLW4VKeOaIu4dL4ow39wAsfI6JaesFn0VN9Ra2UtaeZKe
         POdMzzd3ZI2zNEoMLIRN9gbE0Wkq1QlNes6pnFNKRd/SeUFrsx4+ut6Yhw/NEV/JVRj7
         Li5DFR7/usK9MICPN7eK/jigisQnoaTX2kMvy83XYuwLHtfmSWr39nWUFzzKZ8gcxjJt
         jIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580245; x=1793185045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
        b=tEllXAxzESmQlDTbBqFEh1llaMgF93HXVA7KvJlcQJj7MqtYFsZySvtR8g4KJgK3d9
         b2C4AHHWl/X1FA+praQdnNAl9cjPOOG5jUo5FYWMI+cLU2ScnCXg9RC+Tj3LM/3G+evt
         Zwc6TUsaoeQzKRUfHHEtn0yXD1JyqGdnmvmlgRMUkLMw1OUPq0cxkOv8yTTtx4NUMrFM
         ydWef+kCKJtVOAd2vyr32QHEn/CGF+rnmUiAzJg36dyzmukrW+bxN76pfDOxpBnuVe/p
         2pthH8ajs7pPk5wW+/BTDx5Yw/KTZm/Yimp9OmW21Yferi193gxOJQrvjjV/6cELS+wG
         CWjg==
X-Forwarded-Encrypted: i=1; AKwUvBxshhkxjZ1KWBhaUQg6NMY4Dsys+huTSL1EI7tbTWjdnboYRJJb1Mv7jMaFJ0cM1v0l9tDeDaB6JI7C@vger.kernel.org
X-Gm-Message-State: AFq9FYK4sNt+mdwppUPRVNvb2Y2wvTR5s0+TVt5qjlJj3AN9QGIDYOVG
	yBJWRD2WLqrbJTz5fzHW5t9jcnrpZ2X/FU6+cdgHOnws+a52O5TFMRdHEyEB6ZxXnMv2kXYcyxN
	lOVEbEw==
X-Gm-Gg: AYBFou28M4jHue9HVFF4LqfqpzzUvX+fekmjB6rynGBryACe+w3yXog+mUNwer2/Pii
	FuCNaEx5mX7pqP3/cI4EWR7ZA1o6SBZQGOuosPWsYmcnu2iCEj7rErQkOJZOWjs2Ij4tYutf/0A
	pXrrAZSuOe/8B37jIz36Hn2SWg6rBORdEUMgj18ROhfE3EPk3uTcbCsJVfvs2UaE0ko1SZCf6Nt
	nkeKLGDekMV0T/cBIcoKC7is81SjNhU+CppEymKSk05BKM63WFP++7dlczC6MSJxxufofd5dYIE
	NFYbw5hjxrBWPbgQGsaQpEaluvXNnc2WzafhDSNupCkjYQW4m5Ci1UwLc4DrDuJX7evt5o7+dMM
	nESMGcUKVRj+dPF7siQxAJ5CvlZN7eSwa3czxj8W8gAA7TCJqpw/4BsQpyvUQ8Xlryy1w3OzVTj
	Eupmhb8mPUr45a6okPdDzwURlqQnLIS7mXCGqghU8315aA360EuXxsjxiZcuEuOgCVTDP+TTLUC
	I2QKuLfUP+EDgtqClKhYLf1gJe0IonQP1V9O9PEwywArzW/T0qy2zDVBSJTyHLH2Q38p0/rGzTO
	2jgmP7kIlHstibGBxvd38QImxAygnMB51dlKLqZUwObG
X-Received: by 2002:a05:600c:a3a5:b0:4a1:a48c:17eb with SMTP id 5b1f17b1804b1-4a1f59a5836mr1496985e9.11.1792580244647;
        Wed, 21 Oct 2026 03:57:24 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm104658535e9.5.2026.10.21.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:57:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:57:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <atiakDqtuED2cTM5@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>

On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move or
> attach devices to another VM address space provisioned by an external
> owner, such as a type 1 hypervisor.
> 
> This is not a paging domain and is not sysfs-selectable as a default
> domain type. It requires external owner context, such as a vIOMMU.
> 

Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host never
inserts any mapping?

Thanks,
Mostafa

> PV IOMMU drivers are expected to use it when moving a device to a guest
> VM with an already-created S2 IOPT.
> 
> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  include/linux/iommu.h | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9a..d0bd3ef00379 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -220,6 +220,8 @@ static const char *iommu_domain_type_str(unsigned int t)
>  		return "Translated";
>  	case IOMMU_DOMAIN_PLATFORM:
>  		return "Platform";
> +	case IOMMU_DOMAIN_EXTERNAL:
> +		return "External";
>  	default:
>  		return "Unknown";
>  	}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ac43b8b93f14..ede77b90f0fd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -188,6 +188,7 @@ enum iommu_domain_cookie_type {
>  
>  #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space nested
>  					      on a stage-2 translation        */
> +#define __IOMMU_DOMAIN_EXTERNAL	(1U << 7)  /* Externally managed translation */
>  
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -207,6 +208,13 @@ enum iommu_domain_cookie_type {
>   *				  represented by mm_struct's.
>   *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
>   *				  dma_api stuff. Do not use in new drivers.
> + *	IOMMU_DOMAIN_EXTERNAL	- Externally managed domain for moving/attaching
> + *				  devices to another VM address space
> + *				  provisioned by the external owner, such as
> + *				  a type 1 hypervisor. This is not a
> + *				  sysfs-selectable default domain type; it
> + *				  requires external owner context such as a
> + *				  vIOMMU.
>   */
>  #define IOMMU_DOMAIN_BLOCKED	(0U)
>  #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -219,6 +227,7 @@ enum iommu_domain_cookie_type {
>  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
>  #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>  #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
> +#define IOMMU_DOMAIN_EXTERNAL	(__IOMMU_DOMAIN_EXTERNAL)
>  
>  struct iommu_domain {
>  	unsigned type;
> -- 
> 2.43.0
> 
> 
