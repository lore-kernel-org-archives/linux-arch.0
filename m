Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C830C167
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869406; cv=none; b=glhIYoPDFGZGGT5aSC0duFzp/vD7VaM7kEdgAP21EnLQMmpAd1ZB/bprkvwgYZUD6KSXoXM4nUrKmS4/TnQc2Yy8gs6LGxDGAYUuouC/MEK3Ypve5H/bh+Hz5zgKgLchcE2GU7SARVH8otZJVNEkDhZo7nsHZ7bM6N5zypi0VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869406; c=relaxed/simple;
	bh=gMaEvicj1lkTTKjknQzylRPd7tw3CbzIlWyBBZkqlhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLvhb847Z7VWF22ZA8KBDo8/mWiP0gfJvxDEdfCqdsitXMDurLNtGcceslgAjlSGbC1FCNyU+/DNlDoFbpAToJU//HRWcu/NWguhXAOdW97Si/zeWzCxqlp2tvp3VK09ukwNWoDRDsSaFNh6fY2VvZpi3gs5R82b4RDfg3VbAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k9ar4Jio; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k9ar4Jio"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb4a7d704so1739771cf.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778869403; x=1779474203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQNJjeOCe7S+U51t5FVhB76I4sx7yhCYVtg8gepAxec=;
        b=k9ar4JioCr7PMwm3IFL/V1gS4qbnNYXjESygqFknkEVOcMtvBp/ZLENxK/R++emVRS
         Ezlr+J3zGCYZXg50ek9wta6Z6s/ldjH3ggZVY7lqfdXIrjCmccOJgblHHMKaVLVgVgCO
         +pX6bFf2RIXeTU5g51Ph/PYUyTKt3Uq24hiX0kSTM2eZ6lwCTTv/GpRe+iJgEqNXqEhc
         QPdVrO0M5CW162/CFbdXxDuzMAekPO2u6Yy1n27LXZLRm7NQxIRv8sfhQCmsg/xlRmW2
         r05yl1IH8n17wu+9EyyqOEzId4pnPcvi9IXVSzivi9ikr+mLdfhVYupevfbB1XoGYyH6
         Rzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869403; x=1779474203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQNJjeOCe7S+U51t5FVhB76I4sx7yhCYVtg8gepAxec=;
        b=PIx3oFSuP+EIcSg1uaNuSrG0M9G/Vc/qwizJk08MR1PqkWjOeN5lEBNmhrJcB7M3vq
         d6gTt7anAWi+4ydUUVcvJAqUmvZ158f+edN55cwui2oyqO2xhds4FVpjL1U6a4roPSug
         bx9jIyAbsFx3Qrwm8rZNamHfiTX+fI0ccA0jXLnKmUsrAmmtvZeHsjziPAOZKufrLa/O
         1lVFAyvUsGZxWZuG6KgBFqEwm81MGUKZMTme7n/YeLuJw7jQuYsASrSeOY+lSBj2BtNH
         ueY3Sfd1y4TKckbJ4EY2fCTyEqvbK18V3NaiI/xPIo/DEnB09k26EOj/IVg4fb3W2ocU
         BmzA==
X-Forwarded-Encrypted: i=1; AFNElJ9tBG+E6sGQG5dJjqLX9C9waD7B2wSB8jsBh+WRZNIq+IsZGXwxFcTOPlQo6eg2vZlz76IBILD2f+tq@vger.kernel.org
X-Gm-Message-State: AOJu0Yys22JkIWN+QAjb0DVCsO8v/BUTR+l/0ibB9i5RM9iRxLh5kgX7
	tNvwK6bfNqgOC063s+JdRGM9C3vaAcxxis4J8Xa8Vxdc1dWCrRuIEmhG7hn2rFNyyTQ=
X-Gm-Gg: Acq92OFdJoAwL0PYnMZRSX5vlWFjrl2cjaAVRWk7ZC74G6HuJmWi/ZEzwmFci3OxSZq
	cI8W8r+ljPbyUobvs9ws2ZXzxedPqP+mQ+FarQsUplISW9PXpKnjgP6aBHeLuRztUpWSj2rdeef
	9F2s4fckdxTIE5ajPCLwXiep+GbZEBp9anPqqh5PVon9Oo5wnHHiuBupJR9TueQEStKXvvZ98F9
	Fdcz1J0jv3kBlbbGQz5SRurOHHetXzsaS7OFOvTranmZ68hTLmpGKWWkplvLruLmy9HLbk/tUIM
	2OUFI89GH7jQ8fTBdP6ceAOZDZcN9RQmDC9a5Jv56A7FURgPMhMbdLyS0ZiFNIr6ZS6qy8KTnqW
	V/qY6eE9OaYm7o8+t7EnO5LVWbGZjZAgnOc8ApZ5WC7e7CNvrLLVrs1QtCHy1UpfQ+1rvyQC7ZI
	j6mlHSeZIoGwjMflc8rCwKAweWY1H+fZsiHTLKxsN0/N4LX/x1ff5RtDqh8YS3tje4X3fM3Wpqt
	l7OXA==
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr72758491cf.23.1778869403362;
        Fri, 15 May 2026 11:23:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645801211sm50772901cf.20.2026.05.15.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:23:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNxBy-00000007tTG-1fso;
	Fri, 15 May 2026 15:23:22 -0300
Date: Fri, 15 May 2026 15:23:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260515182322.GI7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512020259.1678627-10-mrathor@linux.microsoft.com>

On Mon, May 11, 2026 at 07:02:57PM -0700, Mukesh R wrote:
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct hv_domain *hvdom;
> +	int rc;
> +
> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm()) {
> +		pr_err("Hyper-V: l1vh iommu does not support host devices\n");
> +		return NULL;
> +	}
> +
> +	hvdom = kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
> +	if (hvdom == NULL)
> +		return NULL;
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree = RB_ROOT_CACHED;
> +
> +	/* Called under iommu group mutex, so single threaded */
> +	if (++unique_id == HV_DEVICE_DOMAIN_ID_S2_NULL)   /* ie, UINTMAX */
> +		goto out_err;
> +
> +	hvdom->domid_num = unique_id;
> +	hvdom->partid = hv_get_current_partid();
> +	hvdom->iommu_dom.geometry = default_geometry;
> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
> +
> +	/* For guests, by default we do direct attaches, so no domain in hyp */
> +	if (hv_dom_owner_is_vmm(hvdom) && !hv_no_attdev)
> +		hvdom->attached_dom = true;

What are you thinking sending something like this?!?!?

The function is called *alloc domain PAGING*, it does not, and can not
allocate weird "special" domains that are not PAGING domains. I just
spent a long time removing all this kind of crazyness from drivers.

There is alot of other things I don't like in this patch, but this is
too much.

You have to drop this "direct attach" idea from the first iteration,
Linux can't do it without alot more work, you should start with the
basic paging domain mode.

Jason
