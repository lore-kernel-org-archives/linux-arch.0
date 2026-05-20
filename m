Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAED2D3ECF
	for <linux-arch@vger.kernel.org>; Wed, 20 May 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284291; cv=none; b=XcEkFonZP+lyE9x13u7FJD301VWknlxAou7C4k2ldrYfoYmDC+yAbzXG8P2dAkpmfSiraRQjvSEIZ1l54hcDK1PPcM0a41f1SBuZIvQ0P8ekiWvto+d1tc6cJCJrgovgfCP7nmr9W4yj0zEV+uSVdUH0Lckns4gWN9ZOfS3HZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284291; c=relaxed/simple;
	bh=FcTKYryF3HlZcFivdjcw94sl1hUA9PtC2/zgtt2ZZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY6CKOuDe5vaMBdJV3VAI71X51J5fLWzfwBUI+qNKMUVS8iglzHMsVVVESm83ES6PbM0BVwIZXVuDArGZMCQ7o0D+nT5wTcLyjxU5dgIGkVbbWmcGHDNI6Dg8akrJ6i+r8xxV/adBJFWHgSSe8BbmuX3k3sWvyQLqHazAdfdDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cBzOeB90; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cBzOeB90"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-910f734b477so542117385a.0
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284289; x=1779889089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=cBzOeB90De6JH9YZRFW4WdvPomMlPt+GLQnVKxGLpjoAW9+MZqNKeid4oFTWgQ11k5
         9vt4MvanJfFqfc0J7YsM82g3CPSDDBbEnEX/6L4fV2XTMUc/puxSVOI3bzTcEtcMcmqH
         v1/iG/yQlqyVlfl1XeHsKgPDYOHSvnqy+xHQQoMXiwf5ZX+i2IIcD65QmN+GCDdUKQV3
         fjhyMGr6UFZTz/iqinGH2Jn/MnFb3n6FkD6lL7MOfEwck6DTMJs8OY/kL4L8PQmd4spr
         Vs22mr5Ruv2OSsSaw5v+x+zjF/dQdPNixEh1rHLzVwhHyHwWg9uaI+epPBP23XLfwJiE
         z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284289; x=1779889089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=Yt4XrGfI3RZVu/LpTM2PCIWp0d8O4Jp/n4QdeTEvdIpd+JipV0VU31jKtMjbWe5AWj
         2dcIyhPwcqcQ+8vnBqQzJMStWK7P3x2t1y/pl3ZylxCdO5lS40DuZ57qNXn4coeQo/wb
         3ljC3aEaNyZRpn+37Zpe1Jm/RQ3NNTm5nFLp4Oy3wXDjWHhfkWEc3hMoCnf2FVt2z+Zi
         swIFrqZBWgn7M06cmqIjwwCYZcIzylWL0LNLQMLYMkCYCjwzts0Z1xxaYfBK67VzsrXQ
         zUEP+i9ObVYJfzvFFEyBKzbKbEn+jqxD9ZWH9TKAAdqPW58SNbqc8lGcRliPvu9KLEXb
         6eIw==
X-Forwarded-Encrypted: i=1; AFNElJ/gzVs5oqFg7z/el1RQiXoY3hGfiLzotwTZVqO5aN8ljEyUmL/eCjhNmkNCMhe3N/482z64iCJmUuV7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YCfmSpRxSoyJRCwzFkdhsnUaLK/oVwwthgK13ZK65hAy87Je
	iQ5hw4McbInw2JbPTxUGehpOEiAQU/Tq04jGa4cckrINcSxxXq7Ut13g1FUeGGr1/WI=
X-Gm-Gg: Acq92OFNoghkPtGLBEI8K+ij/Hg3elsa/oWkMpt1vMEW3UxghEW4S6de+FcAVUly67U
	K0dT/qCJoaGUT0/vSe8xnsNi+6lVNOj7vDbEgnzY/D24SJsIduNNpIcuIv1ry5feeREPcQLfOV3
	nEwjwLm17mNlDzl7dQUptpslJ/sypBpR6TAAqW6gvI8cb+kRPgwdrPzpw0ZlgrZTDtG2KGOFDGC
	2N3yMo7e0cVpI9ibnhatURzdjEnNBKxxhpLYgMqA0TYgKY2ml9hdPmUts1bYfHP3GlLri8Eh+Oq
	SNOdB1tbQU3/HY8KrFo6La1wlG7k7eZackkjXdGvN4bhyqQRkm+YH3SPvqzwCrYU5JxTKZaZfIO
	TN04GFu2DpF7si0WxC1RPcrvZaylN0Rp65DXW7n8Iu9gT5LudTEvouHd2PMhtbOhn0gHBSu3fl7
	TTA3uxvEA3jKiYqTZaZcU1o40p907p4UAVJPEJoBwD1RXTvnVA5+3mYo3LibO8dzOXHEXIJJhHY
	MSLY7lHNY9pP5+3
X-Received: by 2002:a05:620a:2950:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-911ce524059mr3564626085a.24.1779284288689;
        Wed, 20 May 2026 06:38:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm2144919485a.26.2026.05.20.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:38:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPh7f-0000000HAxk-0y0i;
	Wed, 20 May 2026 10:38:07 -0300
Date: Wed, 20 May 2026 10:38:07 -0300
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
Subject: Re: [PATCH v1 1/4] iommu: Move Hyper-V IOMMU driver to its own
 subdirectory
Message-ID: <20260520133807.GS7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
 <20260515221918.GJ7702@ziepe.ca>
 <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>

On Wed, May 20, 2026 at 02:37:03PM +0800, Yu Zhang wrote:
> On Fri, May 15, 2026 at 07:19:18PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> > > From: Easwar Hariharan <eahariha@linux.microsoft.com>
> > > 
> > > The Hyper-V IOMMU driver currently only supports IRQ remapping.
> > > As it will be adding DMA remapping support, prepare a directory
> > > to contain all the different feature files.
> > 
> > Any possibility we could put the irq remapping thing under the irq
> > directory?
> > 
> > The other drivers have it here because they are co-mingled with their
> > iommu HW, will hyperv have the same issue?
> > 
> 
> Good question. I don't think Hyper-V have the same co-mingling issue.
> 
> But from a code organization perspective, I think drivers/iommu/hyperv/
> is still the most natural place:
> 
> - The IRQ remapping framework itself (drivers/iommu/irq_remapping.c
>   and its internal header irq_remapping.h) lives under drivers/iommu/,
>   and all three backends (intel/, amd/, hyperv/) sit there today.
>   hyperv/irq_remapping.c includes that internal header directly.

IMHO it is a fair question if that even belongs under iommu.

I think it was dumped into here because of the co-mingled drivers..

Jason
