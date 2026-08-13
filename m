Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BF383320
	for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661192; cv=none; b=XsdNxhvgnA5SbUrW8txrwcXKk93VcVhLM8FIYBUmDp1SA/6L1ssUQbwGLXjwu3OKEzdVCSasOvccVm53yIMPOS/X2cqrsH22dGrziQMuJpIufWoaiTCg21NyShBIyk74s4i+dPMKc54hRgvYItJuPrdgLjv/ZO7r8q9bmNUmH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661192; c=relaxed/simple;
	bh=i/6Jol0HBp5RRTvGHc5apFk8jhMg7iNWk5RSz52dbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONHfCf0X68/7P7gEqWcVVYVc7YWzjISzouCOLXxh3Fr4hWCF1881BCYJbkwHolzpil1Vw1uQmdFsWZ1LKJ1gBU5hqJ6vl5AZhUEX/p9m2cOWVMFBJU0oxTr6/6ehsPDfLhA5VW82HTA6EaVd2Q3hGaemZQyx33zXgkrNP9pTN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dYPZBp8Y; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dYPZBp8Y"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e7632b193so28637485a.2
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2026 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786661189; x=1787265989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5MtttmxZUrUNaLZLU+CiS25EBYvth90JdQ9xwh2RPo=;
        b=dYPZBp8Yq6xkO5B2BPO2VRJQA3U0wRoN3GtSn/aTU+zoWKYUAVCKgbW/pSftyg2TO1
         WLuUBsqTQfUA2wd4nBsuvqIg4+kgZlGwiIhKKaFnuk1LCOszm1+fkjK1oThyGpxfpCee
         6SMEwLu1zHt0UutIH0oQ/LjAGCScjopwLAAdathkXMkYp6ww4XE3OnyXlgEYM92tFm0B
         /VJU99JJn3srfdY9JOP3m2L5w0Zn6mfDSW4yCnwgzdAuygTu8SGreGEH7sAWEvOUD90V
         L+8p77YlmRstiDyGroXfFyw7jnWSLLXqld1OT9SycA/6WRVQbj43R4WyPei3UfFgz1Oo
         1sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786661190; x=1787265990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5MtttmxZUrUNaLZLU+CiS25EBYvth90JdQ9xwh2RPo=;
        b=Y8K6AsM9e00A/NUJqiv7ztbV+W78NWIpDJupZ533DFbSO7OQ2ErByVQtlhflRdN2tc
         3n2jq/G928IeHqtIt4ch1Xhn/CJZA3YshAD6p/5fZnJpqcuGVMSRrQeDWeRuWdeEZFYD
         TKVYfluajwjhzGftTCp1uH+7s6ALyQeRIpnLJM5uYfe0PmQqb1cIO3ozIb+8aIiiXqy/
         jGULwd4YGzr4E3DSu3yHKHrAjSecai8X+OmbC0T8R9QUp/AzET95J7CVG1BL8M+kAKkW
         i2k3KapkDwFTu9FeGlTN411VKnlWgz8iL782otkZHEWLXyGWZ1JyHAfSWqBAVljRgYMK
         Iqiw==
X-Forwarded-Encrypted: i=1; AHgh+RotIrSpQ4iIMRRwuTocNQcWkOFOb6oK+hyp68sE79oFrAssSqkaxxxVtKcY8RPHuNI4On3HEmYXLo/v@vger.kernel.org
X-Gm-Message-State: AOJu0YzgePXJfptNfpr0XtzSA/tU0FBb61Y3YXzucpJtyEfMQpbiCIf6
	KRgg/P0tAypB7LuVby38pKPmobj9uLHMb9GqDG1t12gGcuNGlzmUI2kBwd63G4ksd2Q=
X-Gm-Gg: AR+sD117HibtsEaQ3OAHREwE3HDT//ipjnY5cccPa+taRXdJx55Af4j2n0vQdlFP864
	LK2XHxUJF9eqA8XqHfrIqMWD156k+ps+rZZQcNuKWd8RKV1nqHjj/sPAKjha22PkeDjI0uV/7IG
	apwo/6CmaQIwL+v6Rk6p2VSKnYZgdJMPmyTDPSvSssosqtaQGi3PMJiQ7aL55t9K9+xI579n2Ac
	6Vj8bjl0C5MlqxUmpcOl8ejpmJrIDHEUZhh6Dn4YJN7G6ZRxPsKfhK/2DD8TZsFkdm81olcNhp3
	2P+WU/Bq+jQIc+yE0aPFiucvcBhWOGjKsvdcqVmOSBia6/YC8vAEgZpUDwNyLUsOkud0SU6PA8T
	CEsOUx4MgabzjyR/zbQzJC8plMh9LyXf7vQa4L+vXmXaTjaUZn6s6on9wwm2t6LX0LRFMdgvPft
	zJAD9/iM+3vQB9a9j8zYKisfZb2L4NqCWcff8zGA==
X-Received: by 2002:a05:620a:408c:b0:933:ada:c3b2 with SMTP id af79cd13be357-936d2382749mr132987985a.34.1786661189637;
        Thu, 13 Aug 2026 15:46:29 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce245787sm96424985a.41.2026.08.13.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:46:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wueBv-000000042QP-14bA;
	Thu, 13 Aug 2026 19:46:27 -0300
Date: Thu, 13 Aug 2026 19:46:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813224627.GA933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813152913.00003d8a@linux.microsoft.com>

On Thu, Aug 13, 2026 at 03:29:13PM -0700, Jacob Pan wrote:

> > +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> > +					struct device *dev,
> > +					struct iommu_domain *old)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct hv_iommu_domain *hv_domain =
> > to_hv_iommu_domain(domain);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int ret;
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	if (vdev->hv_domain == hv_domain)
> > +		return 0;
> It may not be needed since the core code will check this. If you keep
> this as extra precaution, should this be moved up before ats? since ats
> must be disabled already if blocking domain is attached.

Why check it at all? Is there an issue with attaching the same thing
twice? Will it blip the DMA or something?

Jason
