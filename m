Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1643B6F5
	for <linux-arch@vger.kernel.org>; Fri,  4 Sep 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560674; cv=none; b=Ib9Vn5iuJtemqFwLV7vMV62PBDFJh9Ubijf99Zwsd21kzrqsshJ2PPfdL4PyvpKKsuacx5KrANcgxjKgLNNHM+epD13HwIrWTmYgR90H0FoSBrf9mUtNV3paupSuEt+sBiJk8MsypJltFkVlWHWjjUYU6al9ouBgrfuDqf6+nQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560674; c=relaxed/simple;
	bh=3yfBn1WOKGcBed81Nlc6oSVXKJPNrdGjHRd+VzAbRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5tVVFiFeb+5xa9F1UY9LAxbg0ITuEihpHJF7TcxUUFjghPN+YO3zWhn8BxVmEuGIlIGG6lEAIRi4B3WGAIBEPiT7bIgDSQFXBFcrNfZQXGstClqk3/WVm1+esNJcMcJtGDDEfCLGRuFRi/jj+dH76vpohHL4H5TeEgfIUjhToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtirbCBi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtirbCBi"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1278723a12.3
        for <linux-arch@vger.kernel.org>; Fri, 04 Sep 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788560667; x=1789165467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=GtirbCBix0Ds6pelGWNduaI5DqrO9m0/xSFbJNyrN9QCtgIsiNPefSN4X2cSwdrfZu
         2BLpbI46XUeKsayPIK7n4lChRbGMeJQwXY7K71IaltGDBYjOwouT6oz1oMM3123GBoki
         3R3wWbaLE5odTJnRTi2nGlvWqriMZlUy0U1BE72i11I3nAZ8tkTo2yDbX+r8Rlivj+P7
         jyV7nAwI2X2Phziysdoo9Zz5kLaGhdugR4qmvUECBNqTjwfzTJo5M4vWjvNAEnKad78a
         NKbm0+SgHQ666xirrfRITglTHd4nZTRHMUMrdJqgF1QhNdpeZ2aksEJV/Y9FI0Y35Xax
         X22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560667; x=1789165467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=XmQf40ig1IW1+4u0PloIuUBmVv4bZiSwm+tP+3ZkIKp391C3YMyT4ERSmDQAdx6dwi
         4MSElAOWMJFd0mIh4NMY+xwtxPKe6YLYqcrQjxakl4IncrH/lxMN9BzcJp7Gv5sDLFTj
         83m4aJwv3iM+YwP8dJTue6/Hz6wGUXFOhUr5djPQeeQcckx/WJsKeni/xVA5PDxEnQY1
         CTWbYzsxyj1UkV8nJGz5uQq/aj8uycipr655fSoUhLGmxZPMXdPfYwmtvMgBHlXWWG4v
         6zTGD2Nt2lZLEYStdnYzAR/K4aHZh6RW2VWSS8lEjnAr/O3zU1cTut5DQQiYDKcKb4Mr
         KQuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTrR9e7r04CQIZDK7YYAYjk5K+uy3CaUgfIkbP6E+0bMG+pBgo1gyz2/23k2Kecfiu2HYhaxc5RTdW@vger.kernel.org
X-Gm-Message-State: AFuF++lAm5IaHg4XmsyWF4pYuDi+BWbdDDJH/7A/us28CirSAtN/7u6d
	ueeCBW6PZzwvTHHbWTZBUBNRJlIhGJRmoWe5jAXXZzDRIZGXCEs/0mZ1FlWDEpxPIw==
X-Gm-Gg: AYBFou2s6SCHCl0zkPNf/CeCq02S0MlIrUtdvRcHUJYHmOv82xG+XvVG5jJC54U3Y0W
	jU43seldHSAHfbS/qJ4dqEptthfgmj5+YPvuJschHkk3mp+5syU6M1P37bjehqnT9DKx9i6JzYP
	w7MWNF9sRBZCAL7Zn6inMOuv48wg/jye+4pSnxypBKawZxEKb+Ak9YGH1yrXdKVfMmraEwgHsbh
	kO+m1LtzqgGMk1ur2wn5AElfPAnq76/giJgKKcwtJqERib0Yh5PQ2VWjkES9QSCfMxWe/YTGvG1
	6VpwQePUM5CjLEMXN9qarGMLgIZEpRMp3zQWQ3lrb2OetZ9TWPXuw7F2s+bRJ6xTX7X5m9rtlhI
	R1u0gIgqA+z8DYeE9Gl2X8v7bH41LfuRvhoI8c/acqopThVUd9ukTMKHq1fRbipcHVTRRgLe2W5
	iTmDr/rFcRhrCkc2P5wmpYguIQHcO/wOiJdJGZYzU3HH6Ugm5U45Cf9JhItWhNvSJUl6MfpR+Va
	BKppiewwEhlmwJO04GZY/J48mEZnA==
X-Received: by 2002:a05:6a00:2e99:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-8616b26f6bfmr12056954b3a.15.1788560666130;
        Fri, 04 Sep 2026 15:24:26 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153a1c1basm1621740b3a.52.2026.09.04.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:24:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 22:24:21 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Odell <loganodell@google.com>, arnd@arndb.de,
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com,
	maz@kernel.org, oupton@kernel.org, seanjc@google.com,
	bhelgaas@google.com, alex@shazbot.org, kevin.tian@intel.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
Message-ID: <aptFFYqcSiBdMLE8@google.com>
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904160009.GV4157646@nvidia.com>

On 2026-09-04 01:00 PM, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 07:34:49PM -0700, Logan Odell wrote:
> > We're including maintainers from all subsystems that currently is or
> > will be expected to participate in live update to ensure alignment on
> > the path forward for compatibility.
> > 
> > Currently, Live Update Orchestrator (LUO) and its file handlers rely on
> > monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
> > validate ABI compatibility across kexec live updates. Any modification
> > to serialized structures requires bumping the version string, which
> > strictly breaks compatibility between adjacent kernels even when changes
> > are additive, backwards-compatible, or optional.
> 
> That was the intention, I aruged strongly that upstream does not want
> to maintain a CSP matrix of endless kernel version combinations. That
> is far too much work to push on maintainers. Upstream would do much
> less, maybe only same-version, depending.

We received basically the opposite stance from Sean regarding the KVM
LUO ABI:

  https://lore.kernel.org/kvm/aoSCCTTBn9D5hqzk@google.com/

So we're trying to use this series to get some alignment across LUO
ABIs.

> > This RFC series transitions LUO and subsystem file handlers to use
> > granular feature bitmasks instead of compatibility strings. We replace
> > the compatibility string with a header structure that includes some
> > reserved space to define the features that are included after the
> > feature.
> 
> The compatability string is only a small part of it, you also need a
> serializing ABI that can handle some random mixmash of these
> features. Ie the various TLV schemes that were all proposed. What is
> the plan here?

The proposal here (which is inspired by the KVM UAPI) is to ensure every
LUO ABI struct has 2 properties:

 1. A field to encode options/features (e.g. u64 flags).
 2. A way way to grow without breaking backward compatibility (e.g. so
    we can add new fields).

Each flag can mean whatever it needs to. e.g. It can indicate the
precence of one or more fields (i.e. new fields in the struct), or it
can mean a field now has a different meaning (i.e. union in the struct).

This would enable adding support for new features without breaking
backward compatibility. Downstream users would have to ensure their
kernel does not start using a new feature while it can still rollback to
a version that does not support the new feature.
