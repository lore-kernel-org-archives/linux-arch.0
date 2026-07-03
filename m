Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA766305E28
	for <linux-arch@vger.kernel.org>; Fri,  3 Jul 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098624; cv=none; b=JkdqjD8XKSgF6f77NZT2SpnGgMvjcpkIxWE2gwCdkGr7p0eS0odI0Qi6rISJBJjrOR/k5unHSWW9oOmnibjfdaXCC/Q0Aer9IF5lvKuBkunx31ncmizC7fbcPlkBBrcWpvd+Hw8ARlgGQuLYG+4THuutqnnuZMjmnmF9CwZQ1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098624; c=relaxed/simple;
	bh=JqbyUGSlLgU7xpTZ+Kst/HuDrhY2T70S9MikqXlpd+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKYZUkogewqMDQXs8GslxPm/qhCi5/N0nvAXMVLVlnea3+kBtyDpKwm1kfbHWWaH1/AsGY3L4Rd5V/tUsaVHk6dc2FZKHugvV7moRDAl80Lk85ROSK3QxNqcz9DFUxdJhIeI3RUlOqtA0OjPhkAKmjLYlTnyZzX6xxMsVQnkhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BJNelsAl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BJNelsAl"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-915ab38ac14so62844685a.0
        for <linux-arch@vger.kernel.org>; Fri, 03 Jul 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783098621; x=1783703421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=BJNelsAlO6FnCo9zXD9lU+4SoRJW3Tg0r1YDSlnhVtpce/fKXpv6TZQ96ggJUP0RW3
         OhY5I4MRnhMRmVVyF5tufLWyo6PRrBE2WMLMJ/fTAu/xd93sqmuhvsCKXrIHPo0AmOMZ
         Fwvb4f4cZNrgoYyiQ9FrQoQKs5K1CQtzKoV7BZd1wh/H0/vDSidipaNbRED6rpYuaodD
         fLFSsYGJGrSr9QGerD2znfRfvnicK811K+ffhJuhXjbO4/wWWAGx5M0+zI8ucdQqk4Uf
         9bpxIv39X++mU0XhhvBHWDFMQlFmqDCzRtt6RDDyj+lTFDDkk9rCxOPK09J6QQfYMFDA
         qsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098621; x=1783703421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=o5Ln5OXnBQw1uG8Qri32aujFr2UlH8oVxQYwQqZDU/giNuxOuqWas/q346nHWMTqRp
         C1aqAlto97t7vARc4NyhvdnWTQX8EMxN31MalbCYxMe/BPiufj/5n6LcrrrVVZbM/EMd
         SK8tGFPaLK0jGtAlxVfuaP1f/We7PrVJiGJly4XYVFtpQmNY3/2TAbUp24JEPv8tpPdn
         N5seeUFXiLlId0J7lny0FDsKisU2zmGyQGxMWf++QDme9WXs+EZO8kary/amnFU7eE4k
         kPdKYuMbyUBGDy+pwCWT21ApZSBj1/As1wSBG0OQkjDWrE+1lldOb8Usz+o3YYUXPTBA
         x/oQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QU7k8G8rrcNtuDueuXle10jMfQwsMndPxPAjlbgphi073oClD1k2fsUDiHtkbMK31+HLjuJpRh82c@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3rrTy3EoDBNOeGpBaGQ1CwQpg5t8gfTicIbXxxGHawBYEZnn
	I0LBISKfOUR+v4W5ZnRvIvLYLMOMBwxc3iCTXnwIDSvfxyIItTfBkJzQnBusLHjjaTM=
X-Gm-Gg: AfdE7cn54RaSKjgu5fbRLUnYDWgn0QC0hi8a3ub9MF/8DdkChvOF9tD2rt859A+pO6w
	SxrZGFh3i6cPrxLdPxITZD4+cesbaETwOca4aWuNE7uV9RwpdyDYQrzZSrvpLZGhOmJT7p3+tBH
	prG2fGp5zr28r8hCMSgdHYJQIhQJJQkYvV5UyaVMlhHf6/OHJis6qE2PbBLNHYcWUo5E3a1JRPT
	BjJNsM6Z7fK94IQ8Ua2ydtB3B2k2CSVBk6xACzocCbyfxEi96/q1+m0XdFnthuI3lJz/iJJVCRO
	BaRNRK30gvYtieDXHNPJ2ixjMMXpdlTDvR7/U8qgV53QF2mUc4gDwwAYjvAcDGEKopDjg943xLy
	JcVvBkMBFWH5h0fKLClHhaDJvs1O9aGRWuZWgVhaEgU8B7BA5h2QNEiN9JUrRn4VFMB9f+UTjjK
	fkGPsZ6+w12CfAzP8HHgyvsw16iWyKGPHwORMCuJbFSR0U49QtV+Tp9PpQN2Ao8mkrz/A=
X-Received: by 2002:a05:620a:46a5:b0:915:5379:b511 with SMTP id af79cd13be357-92e9a48e177mr44923985a.43.1783098620659;
        Fri, 03 Jul 2026 10:10:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm200315285a.35.2026.07.03.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:10:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhP8-00000008GuS-3eyQ;
	Fri, 03 Jul 2026 14:10:18 -0300
Date: Fri, 3 Jul 2026 14:10:18 -0300
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
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260703171018.GA1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>

On Fri, Jul 03, 2026 at 12:05:18AM +0800, Yu Zhang wrote:

> @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>  
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligned.
> + */
> +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> +				       union hv_iommu_flush_va *va)
> +{
> +	unsigned long start_pfn = HVPFN_DOWN(start);
> +	unsigned long last_pfn = HVPFN_UP(end + 1) - 1;

Pedantically end can be ULONG_MAX, you shouldn't be adding to it since
it will overflow.

> +	unsigned long mask_shift, aligned_pfn;
> +
> +	if (start_pfn == last_pfn) {
> +		mask_shift = 0;
> +	} else {
> +		/*
> +		 * Find the highest bit position where start_pfn and last_pfn
> +		 * differ.  A range aligned to one above that bit is the
> +		 * smallest power-of-two region that covers both endpoints.
> +		 */
> +		mask_shift = __fls(start_pfn ^ last_pfn) + 1;
> +	}
> +
> +	aligned_pfn = ALIGN_DOWN(start_pfn, 1UL << mask_shift);

I think the whole thing is simpler if it stays using bytes until the end:

	sz_lg2 = __fls(gather->start ^ gather->end);
	if (sz_lg2 < HV_PAGE_SHIFT)
		cmd.sz_lg2 = HV_PAGE_SHIFT;

	page_number = (gather->start & ~(1UL << sz_lg2)) >> HV_PAGE_SHIFT;
	page_mask_shift = sz_lg2 - HV_PAGE_SIFT;

No overflows that way either

Jason
