Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409553F44E2
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883565; cv=none; b=XfPOAizxJGXmzCsK4UCJGvilifkuFD+Cyv8Gl/OFrr/dJ1Njqzwng7HLw9qWL5o7yWpMGEdi+0WZGDtYfPUyowHgjWrBQ4FpC88UM+LqTi4ZihoqOWPqs9BZ5yLFyasc0L3KzfQqui4gSpIWkMMCEYRHtu7vbQL3KsZgqkLUcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883565; c=relaxed/simple;
	bh=8SzpbZgJBvBRL/hzxIjQ/9GeIwvuw2el3nJZdpXd+WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0OGDiz++OeaNlj2/EyiVRyWY4qwJRAG+K2L78tRPzdqKKE6NN/M7GAa4OHm78gOVcL1Aaw3Jh28ts8565pLtRIkvVCCV2BpFofpZ0DHq8GquSLzLP02x7BC+/EQDQpLFmi0/ZQWbTsTElpGoUKPi1/33NAkycLUsi9sIQtfjxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oi067Wi+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oi067Wi+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e63771d91so5304941cf.0
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778883560; x=1779488360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=Oi067Wi+P4Yx6RvbsIpM+7igYMAEy3+eLQdCmDQLjimAaOAccY2Sjla9OJTvYqZFMC
         QIGOPvYnE8V66UXsT8jkxGePlTpcpvUgxfCNxJ+qES+j2eM9z7u0UR9F6uGF3qbG/Vn+
         jPiNT32XjhaZjR7qzaCltoSdK9jnaVhJnlbuSV7MfgeffHHJdlgVAIPkeDE4oBIIFTua
         bNI1d1/TkqhsqbeoO1FrhRyH8eYYpqLn3xshhpXXFxxmkwW83Em/1RDTcwrsVMMBwGHl
         SJNT6uMMb/09pS6NZMOD6WEG+59G15EcD08Vk9oVfPAXdf89Ck71Gk1KvG3G7hafcWSf
         it9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883560; x=1779488360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=M1nDt3SRDj8GcHvWc7FNQfKme6PTukrI2hmS3xg1AUaKYwWl+zt1HqjTDptW3YdKCf
         jZcgGqY1xtRr1SO8DFoY5NixPuamfCuIdV/JuqUkxnoaGJn9FXkmlJ/QaU6osDmzOJbi
         L4h0yHO5uvi2i1HsEE6Ml+JGnMdjB1pbcAXoCPRHmY+Rco3F95cUPN4Q5TcukdL+6Y0j
         G+olPbHws+0a4AhgKDQo9BrNOzQ3os6qnUKYqAaWxCQ9+XbABjj4kt66ioJFLn57EJmQ
         JoM60GjtChPCUr7Ewd4oZJY8jHTzCBXFYDxepnIiWuPrUEAjwN+CyAnGQLIA3cLtzw59
         SukQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H0fX8FDVg1hIMrGD6scX8PIRgUVlbQR2Mabltar9VqPFSxe/Sq+jkXQGDq8mnDOlK8MK03D1AR3Gj@vger.kernel.org
X-Gm-Message-State: AOJu0YwUzKvQLN2HUqzej7xzVeJEcQwRDA1mLN9dFu9mWMYcQDJz43PM
	1ZFHx+pbGvt631BvJUbyuDDHrDzrqMkiszglM0cIzm2BHzVV3egxk5VBRHt5TEDKfl0=
X-Gm-Gg: Acq92OET50/EEfihY5XcvnvWQ31jW45EcrSrYgkjuj9tcmYF0Px6Yaj+XSzye4dO0WV
	tvrmGyRTNvKrF+MCgHzLIZ5BbUIU5kTxjiVXj10JtF32iDxJiEtN83wiq5MOzTY7fIuXYuDTSKt
	m7MoFSQG+8pCMGdAaj7oTEY3HFGWyluiFwG91oGY9761FQfVDyl4NrziYzKaWv3s2ezLACZT51k
	QSeqg1WZ0lgWPDKrWOjvyra+DP8BJrSSYSkN0X8rV7KFCr326y+DSC5EgVj4vnRLEmbAhaGAUCC
	mGyu3iVCj1xS3GyauHCtIwmW9g4EzNtPABeM0xrDw/1pQC9rV0LlBim9jBbvFUvBVnqcz4QrN4T
	Mmd9B9TDMjW8yKxlinXDqUqrktvSVpWs16VvDVUakd1Z+M7LIUDBU7hdRBZBvnIV0AyfNzH+ET0
	RZTzGjCVYt37vRpmdZfVxAE6EWmOHRM+nGC1D1H5Cq60AR6NMB56igwEzctdlDCYHpSDa11+ENf
	bwq9nGL7QDN3yRS
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr85536381cf.23.1778883559652;
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm58162851cf.18.2026.05.15.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO0sI-00000008D1f-2Swb;
	Fri, 15 May 2026 19:19:18 -0300
Date: Fri, 15 May 2026 19:19:18 -0300
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
Message-ID: <20260515221918.GJ7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> The Hyper-V IOMMU driver currently only supports IRQ remapping.
> As it will be adding DMA remapping support, prepare a directory
> to contain all the different feature files.

Any possibility we could put the irq remapping thing under the irq
directory?

The other drivers have it here because they are co-mingled with their
iommu HW, will hyperv have the same issue?

Jason
