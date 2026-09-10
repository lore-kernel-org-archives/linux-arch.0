Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F431A807
	for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001912; cv=none; b=RMk3zaKK+/aNnvM731f4tPEKtYk5UKjY6/qTm1uiWpIDjdz0Sw2suX6QKur7ebFbvYcINBdxAT1rBe/eqwfRsATHJYCRdt27x2cVkeLwkWA40p5T7liZjf8Mnc50IgbwQH7P8MZkimXfMAJnaaxNvEjd8B12dn91+3SHYAArjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001912; c=relaxed/simple;
	bh=EMDY7SWycMHhwbwPHJdS4oL+eSVJ8O6B3SZMgf9trmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WzYv4hYAaPnowc3Q52D+LzwmYq69BORqmln0dEa6YpvKEqB7zRVcB+1x87CYAnoVPSb7H7PudqVcfvEO65xLbLubTHwGQZuZvHGa9jCy1e5evZKjK5y9jz+67bxIKa9QEKs2SZs7yxdLJmDQ6G5sNHPYbby0M1Cs0HtY+qdd2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgDGYPhr; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgDGYPhr"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3b126c9fso65366095ad.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 17:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789001910; x=1789606710; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgzlS1uxnCbzGMH5pUkXS6DY1hZkFu32UCS9PdpFsuk=;
        b=KgDGYPhryWM9PWvG+8qz+UAdxY05U5uF1WkgiplOEcNGit5Bp2VJJsHJ0FfR4AOhOq
         CKtp3KJbXdi0NjoCmrGgii8kqW5SaKfJylLNvbQ9oceAf0UQ+khII14HRTvIrN59TVES
         VZ4AH31xqkNzYxuYIMr3mePl4rMKX8Sc7PISuezaA1/oWCcGPZbWwDz+I8sQuzzsx4dL
         6h3+pRbi0u8i8YBRttgRBcw2BgxDuf6mu3iPRRgTWTtZjfkmWG+vWXLkqXkaKdmwH3q4
         UlXrPN0K11HEdxCbinawiIIy/FPnTWOFH6g7ANnwBgYl3tRzB17D0GJXJSknIsQGJbLt
         Ff5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789001910; x=1789606710;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgzlS1uxnCbzGMH5pUkXS6DY1hZkFu32UCS9PdpFsuk=;
        b=O2EFaH0RqLnMyw8b7vbjA3v8DliGjSoVsE0OSX6DB42b/vvagWAzpRSW+BVNG/GC0Q
         cCnv0yG9lpuGac+bTC46cDq8Pfh9TVmSx4W1qRezeQqcLVIuYFVt5WoifGnkF7UFq4AX
         aRYDnSMSThsQSJr8jttd/4PCVtHhB/5j/8Oab7SrsXC8aytDWaBWHtxTcKG6BFRw7BoD
         /Xj/MOxFCNaSl5rVvidyRLpJdEDzitY0RTmsYa5uCxyYnxAHXKBqdVUH1+tILyOJ5C6a
         pGSELEZp3jEQ+/kPll7/Rn344IUD9guh9nT3kbBixms6AXIbq7EOjutxkXwwgbEp6wVH
         bV8A==
X-Forwarded-Encrypted: i=1; AKwUvBwdIbptauTtTKUQFjQN8YqIhLuzGWGSgtkgxvw/+tZq8RIpmuRj9AMLSRQ695V3nJzsDyFP6u0Tm4JP@vger.kernel.org
X-Gm-Message-State: AFuF++lVGqZ8Az1s8sMQUpRxJxE/FSrQrGU6rc0yOszAQRga0f95FB7M
	/frD4qQ1tpjgn40ttRmfWupPh3ezKdLMShJyPOJKRixTmNl3VOo2VGrd94M72emIxLimo+46/Gw
	6FRjnqA==
X-Received: from plsk18.prod.google.com ([2002:a17:902:ba92:b0:2d2:c22c:7b8a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf10:b0:2d9:3636:d01a
 with SMTP id d9443c01a7336-2db126669d3mr557854145ad.15.1789001909390; Wed, 09
 Sep 2026 17:58:29 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:58:28 -0700
In-Reply-To: <20260905012403.GX4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com> <aptFFYqcSiBdMLE8@google.com> <20260905012403.GX4157646@nvidia.com>
Message-ID: <aqIAtOoew-_6jw29@google.com>
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>, arnd@arndb.de, 
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com, 
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org, 
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 04, 2026, Jason Gunthorpe wrote:
> On Fri, Sep 04, 2026 at 10:24:21PM +0000, David Matlack wrote:
> 
> > The proposal here (which is inspired by the KVM UAPI) is to ensure every
> > LUO ABI struct has 2 properties:
> > 
> >  1. A field to encode options/features (e.g. u64 flags).
> >  2. A way way to grow without breaking backward compatibility (e.g. so
> >     we can add new fields).
> > 
> > Each flag can mean whatever it needs to. e.g. It can indicate the
> > precence of one or more fields (i.e. new fields in the struct), or it
> > can mean a field now has a different meaning (i.e. union in the struct).
> > 
> > This would enable adding support for new features without breaking
> > backward compatibility. Downstream users would have to ensure their
> > kernel does not start using a new feature while it can still rollback to
> > a version that does not support the new feature.
> 
> This was never the biggest problem. The main issue was the functional
> behaviors of the kernel that cannot be represented simply as data in a
> struct with some flag bits.
> 
> Like for instance kernel A supports memfd folio sizes far larger than
> kernel B because we fixed MAX_ORDER. You can't fix that just with
> simplistic flags.

Can you elaborate on why the folio sizes matter?  Honest question, because I don't
understand why the serialization format wouldn't express things as "N contiguous
pages starting at PFN X".  Then the implementation would rebuild its folios as
appropriate.

I could see things like HugeTLB not working if someone booted the kernel with
support for only 1GiB pages and then tried to feed it payload with sub-1GiB ranges.
But to me, those sorts of things fall into the "well yeah, don't do that" category.
