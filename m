Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4D41F34E
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537840; cv=none; b=WGF/Tnw9qknN3x0FkwC0XmBbFYVbuo/SgkXLuwHph+6aaUjEOTnavx4wgljjiFum7c+3pdcnnx13XEAveseiiHmgJLsYSLURXSdwxUTwKrVOihGNBjW+2QCf54z3zPVnqB8FxHwC4T3E4s7maXrYYP5LfFzoggWJCab8QvaJOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537840; c=relaxed/simple;
	bh=oPx8rA1LxifIFXbFQU3CUDbGAZuvNtfeA5eTxK6h5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX594rVIYX3a7/F//EOydbqq9P37UgczRMCv4O1MNsOtIYKGznFduLrcL899S/PjF/L6o0Cr8Rr7Sn3OcDEBOy7nIJylqQFWXL32xzBzGbHBXbleoI5ClsSAL8D3H4bjxCKtiornZ5jsLs6Z+eH1PYspuQKhbO15Ztwu2TYfG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K1DObIFJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K1DObIFJ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-934a3d14924so91538085a.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786537835; x=1787142635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=K1DObIFJ02M62a8WH5OMJo0XF8ybEoV5IKOKtoneADLfcGcd6D13fy71m1wkEHHor2
         TPme1C5Gi2840NobPWnm62GXfVqvTuoIJpbQG6LQabrmCciRAXa8JcuDN2FEBfb0i4RI
         xIXCpHjhYiZhX9MRUesBGq7FdMC7env1mhQylwZ9AwtesKzAzUS3wQ3OqvdJI4d7XEmb
         0jghcwKcPa1OOLlHbuiZ3yTkW737qSSlrmuAB6Lsf8/B4Nn9TeVJZ3e99eayK6NAGkNB
         wv0JCbD6UAKa3rdSQH4C0Hd+jmFBTG86tQbpwlUoPCLGJtpLfaJbWUJ9bBUeiCYXG8He
         sSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537835; x=1787142635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=HzYrz8WM6E+2gR8Wke95PSC+vCL5O2FCCxuBU3DSHnFiiF/4wxUMTcZZQaE3yGa91k
         u7/Sj9STQbiLSY9J5cZxsapuTFm8jCn0rbtF8S0WGenewaZxiba0NLwpTIQz8Bx4i2v4
         AbmsX/RU5EHR4QfOfH9wh3Xvh7UhQKQtY3xz+Lj50Jb5OqDJG6tpTj4lCVcihXFAJ65N
         L4sLxinTCOadlPHZAfmcmbr1sic1yV9yl+WcnkGwSOE2vjkXX58Fc3UVEjaFXdwwxkwm
         yDThnkJDlXHsE3TqtIQjWRO00iqvjgffdZVljYcxPfWbeM9TxsJ4iNbdOfDqFSD3CCOb
         zynw==
X-Forwarded-Encrypted: i=1; AHgh+RqYiDgB8MU2iTCq9NmwdyJvtAl19A5jIxmDdUv1qDuAJc9hOKMX2ATNJWLByC4ph/PMd6T1VNunHk3/@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeouYVpn3KGzlR/XeHiPd0sGvFtsxzg6NgdeEYRaNnp+vZh/M
	MSeOcWmOr3kkPwln2d/Sr5B/CRnbx3KV6xxK+wsK08yDCQkMeatkAicS3Z6DgsK96we1oh0nwpW
	ZYwcB
X-Gm-Gg: AR+sD11n7U86LIq1FR6gjJUHk5yWQ5NMUm/vlTC7bgKXvqPtDWEKw5B3lGQvC+tmWNM
	RXISmTPs9WAZWuC/J5ROKDPfvt4li5hLjVHR2Iz5OS88hJZ7qSueifUPWusE44X6p91cxvYczKL
	q2eiz1Vg1+GE7iB41DqNctQ+BkflH82yz47Oh7om0n7+n2QXxWGQYPzmrQT6gEfF0qRzLj5mAPl
	KXj4VQgea28L0uribJoxTnQESm4Jjl2zkdrKdeQNhyPYl1G0gOj0SxtLnv9E7z19z/RJTmNTdvU
	Rkke2VWdgl9uM1EddgCYf/OlCk+naSSMqXFBGTeVMsxgpETcaw1C87wYf2hQG49l3ozlL2J8+gS
	rnITWnIX5LV+9Oub2tLn9iuhhS6+8B0KkVHfqDk/xeGhwWAC6kb2SNCcHWrc/iYh84Q6I8kXtb1
	6DMJ5fJAxFHdeotqWQq4JTcv0qDOJcKxuojm/B1qETionna+fR
X-Received: by 2002:a05:620a:4013:b0:930:e2ea:2881 with SMTP id af79cd13be357-936b3d940c1mr359405785a.36.1786537834756;
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f1388fsm117247585a.24.2026.08.12.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu86L-000000030Ox-0KWD;
	Wed, 12 Aug 2026 09:30:33 -0300
Date: Wed, 12 Aug 2026 09:30:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <20260812123033.GB662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
 <20260811162124.GK544626@ziepe.ca>
 <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>

On Wed, Aug 12, 2026 at 04:58:28PM +0800, Yu Zhang wrote:
> Thank you, Jason!
> Do you mean something like below?
> 
> -#define X86_IOMMU_MSI_RANGE_START        0xfee00000
> -#define X86_IOMMU_MSI_RANGE_END          0xfeefffff
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_x86_msi_region(void)
> +{
> +       return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
> +                                      IOMMU_RESV_MSI, GFP_KERNEL);
> +}

Yeah something like that.

Jason
