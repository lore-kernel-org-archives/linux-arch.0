Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E734385539
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884548; cv=none; b=O6JRLkxkY46+cpC+oeExCafB/WYcqSlxYsqvHhkr6cbaTgnwCbtWMYMPyc46Flod92dDldgwMSdxURFhwPu0bdh9IGECwL9zm7Grf8Hak/qPaB+fMgTYhnUAqA6tx0NdQd4ail9pX0Fg8KyURI2GifJqO+CyDxPI8Q1Tr9I6lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884548; c=relaxed/simple;
	bh=43M0QEo0eyyWPrbH4y4RCOZ7Hh/aYFkSTUf2UUibSrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shJEuUtW+WxVIBkefbAd9EWKFhGwV19yJytp0E1uyYWjnceu9lZwnqp9GDAlh5N2VQTJjkA35l9TdAh38zzbqOmyZNZH02RsjZipt30Rqw2jq3auxXt1BnIejNKk3nlcEGGwiIRO8zgrl3udWxSPtq5oXUz/BqbqqxSsYCj7hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XsX7GuAu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XsX7GuAu"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b7105dfb35so4902896d6.3
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778884546; x=1779489346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=XsX7GuAusaCW2LmT6u8ew3/AzUb4Xjxt9X3vjamS4IL1RmGAU3MR67ypmronfRfXyW
         E9y5QRxboLE3xsIS0gaVfI4K3BugHkAT4V3ABCEecxlDiB8tZ2L6mCeSHIEyTMjh9DoB
         BDhQJ8n1dGTTMDwbS8pH5Fga+FyizW0/5r4gbRmPlKm5rmI12FMQKJGg+6owsc2Dyr8i
         7d79LfafVPeV9yJyPzmy73OCqQI70UuUFRGgRFYtCCmcandMKqZA7Svkot47DBtDpU1D
         Z08l7bL2P5uO59hLhWP1kcSDSkmRqvWVnC7RLV3yeWeThxRbNW68z2gmfu4Bz4ER7HCg
         Pr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884546; x=1779489346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=YbB8lSd36/0HfYd77RwfzxPH8LYh+ornGio3oq3YnFR/0I93YIUQpj4u3QhHDw8Q7E
         kHDuC8LL4UIy+vhnLzaLDkLL/kjNwodx1zRDgYQVQhREBXky7IUXumx8wingqlW564kD
         dGXaspux4P4mf95FOlqN5H7wNmRs/Iiv8JygA/gnXg25F+CuCD57Po0w0yXC3R3pfgEM
         egft0cwt6h9eD3dlZv71yDfJMsCNMRkmnRXp3ekCjc+ltoFI48WkX1jPxgI++AcRpTPq
         pDwanWjqsmg9s7vByXeXB5oTtwz03ys+yQ9EkQMNKMRX3oK+aeBDdj8qZ5J3T9IwkuDj
         icNg==
X-Forwarded-Encrypted: i=1; AFNElJ9wibctL0IsZQX32hm9/uEEHTYA4xIcOZwXM5JtwoFLLvvoY71sHCD6KrgViJqjtjQeFUgs7vLxS0CW@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIZYduDR3+E6467hU3sYJcmPjGnK5VMfD3dsLscEc/yGb04wg
	6f2LHxkNJhIKmSXLVhMOb3DawYsquYuy99Yp31gI0Fgl0AUrMDMf42xkLfgaPQuMRgw=
X-Gm-Gg: Acq92OEmQ3j/tKMyGPh3hRp0H6AxLN+PN5ZL4kKLUU+VAuHTKEzEOTKBbtLksIfVDPf
	A+HCV04rN2xSyUme00CERiSk4YkPkPgRVavhRlWuHKrhefmhwECmLLowy0QNH1Y7o2z5CpNGixn
	IbmzPCRz0XdyHOzNZkOaoONIxxLNtn/yoSF31nlAgUG0Lj8bzCjl7clIBY25wvmbeKnMDI5HRsh
	VF0sRra/Pk1hGspKcARu/eA+CFx6l2IaXFHbrF8J0clSZdjpx6jkInZ8VRbSzMx6bb5l+RquOyh
	GvZJzv/MaRBkFn/Gf5Z48y/NduWWfOJ+6N/1KA/MMW4RIBjf3uEqCI9SQiKVrwBKDtqLfPcpHXs
	F3zvVjdrfU9VXdwMXM0Xm+TVDbFAF+LwgoOxQejgoMBZrq/w11c7Q8YDmn37VC6cLEXvjSrwGKR
	lnefLRyAj13ziQA2YjOYWbSuBVsB7iETXlcYw2O/z7EgKbKf9wOAgURhg/obFE7E+g1qT4VJv5m
	ZnPwxmqQwIVFcBi
X-Received: by 2002:a05:620a:4406:b0:8ef:ed0b:c235 with SMTP id af79cd13be357-911d087dccamr952694285a.56.1778884546078;
        Fri, 15 May 2026 15:35:46 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baa3c045sm682967285a.13.2026.05.15.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:35:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO18D-00000008EMQ-0W2r;
	Fri, 15 May 2026 19:35:45 -0300
Date: Fri, 15 May 2026 19:35:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260515223545.GL7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +	unsigned long start_pfn = start >> PAGE_SHIFT;
> +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> +	unsigned long nr_pages = end_pfn - start_pfn;
> +	u16 count = 0;
> +
> +	while (nr_pages > 0) {
> +		unsigned long flush_pages;
> +		int order;
> +		unsigned long pfn_align;
> +		unsigned long size_align;
> +
> +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> +			break;
> +		}
> +
> +		if (start_pfn)
> +			pfn_align = __ffs(start_pfn);
> +		else
> +			pfn_align = BITS_PER_LONG - 1;
> +
> +		size_align = __fls(nr_pages);
> +		order = min(pfn_align, size_align);
> +		iova_list[count].page_mask_shift = order;
> +		iova_list[count].page_number = start_pfn;
> +
> +		flush_pages = 1UL << order;
> +		start_pfn += flush_pages;
> +		nr_pages -= flush_pages;
> +		count++;
> +	}

This seems like a really silly hypervisor interface. Why doesn't it
just accept a normal range? Splitting it into power of two aligned
ranges is very inefficient.

Jason
