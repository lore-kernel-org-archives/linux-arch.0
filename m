Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BE2DBF75
	for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134299; cv=none; b=dscPYpBpec2wLloJEufPVjl0E6pebNIIFw4u3m99l5xWTk+sR6Sf/m0IxOowD68MjvnyDbZ0lK4j5vENPEn+KGvEcGgMGyRuAJhdHaqXWoyqXOFBInAqPhj6OnO1wAKMwXQW8WxMFVb+9LYYGTRGazLYIH8ES0eX3b/MPI4n6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134299; c=relaxed/simple;
	bh=z1IBBN+1WUfDf5cT8bAka5f8p45OV+l+sxZzQy3xMvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBXUhCHKlKbyMytlKYaU78oe7PC9CGDGEHOcg1uZCOil0q+ymOTPQhpKAdZEfZ+tgvYQyx07APXZ6864BqlYTIosjJmXwbU71zTIoUvOnltWvVvN+tKp9TFxQ5caHnpQA61l5QVWFN7McGK0f9gyz3cPbGdwocL2l5x69mkqgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJxXdm+a; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJxXdm+a"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so1140594a12.2
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134291; x=1789739091; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=;
        b=PJxXdm+a+euQUyQZMaj+1xNum8ZW6CpqOCX567sqtcKG76RNivO5/ngMhvgSK08Ljm
         J+tnQGPEU6Zqh+X9i8fCKegkiG+g24cFjyry4l1+Sg/rJkymCKLxCavFK+B5p5UVggpt
         bz1UiQfHa58So2MfZgi8VqAjc1NSH0Z9S2noWjY+bnpsv0Ixkax2xy9qYh4gicLzODB5
         rB6X326hXNCSZTSklfDlQnqEJ0XjbqiwewmXPw44IVEgkvOl75gxoVGey3TMqhJ26krr
         yXHlQNz4p3K64BQnpKrsNuAMNM2ISyge59NUZ/8FJbZeN1NT64bmlSilrEYfi1KK+umI
         Glig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134291; x=1789739091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=;
        b=PxQrLp+lEq11oiyxHh9JqwphWxBn8hAiALCNRSUF/KAhLDoVU8AWxO8XyRCRZKkMpQ
         mPruGRFt0yZFALeX1sqyLft/fnTMeFiSgD9i+VoXSZ99/2G1LVfmXrRHQlCT5LqHlYiu
         GsuP2+iielVi8errg3JcOLQgHkp6wf/YsRmE7/svI7zsAZfEJsY0mTVgZT0g0uE5+OF9
         XJ0Ny4XKwe0T0H0Dv9emxc1G8nzhTLP2n0cbwiAQli47XEncWxaSHEJcccpF6lQp0P6U
         NLZDS2Ufk5Ps8a7NQRhm9FV2hrCXUk0NdqiyxNh9RLtoHrVQUOpNqRv2sJiPVo+bDWt+
         dZvA==
X-Forwarded-Encrypted: i=1; AKwUvBw+3hAY0/kuXc8rmRHZRf+cqzGZXfHGTDmj00fU5+bYnqyg6amd2WYUTtR5P1a7/Juyjt5b7IOXZNgG@vger.kernel.org
X-Gm-Message-State: AFuF++nTmP3cTU2WFLbNZQsjTqmMpxtfh429oaDYaZCiay9+aFlEohMI
	Ll+ofHBeC0deaZtY+8nflhoRDu0epDljI3FcZnu9JI2aDDrVd8fcrW1HHXWYV5aW2k96QcZbDBa
	VixCwdQ==
X-Received: from pgjj10.prod.google.com ([2002:a63:230a:0:b0:cc4:5907:21e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b08d:b0:3c6:61b9:917c
 with SMTP id adf61e73a8af0-3daed1fd3cfmr8633653637.11.1789134291123; Fri, 11
 Sep 2026 06:44:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:44:50 -0700
In-Reply-To: <20260910225728.GB857650@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aptFFYqcSiBdMLE8@google.com> <20260905012403.GX4157646@nvidia.com>
 <aqIAtOoew-_6jw29@google.com> <20260910143448.GD3968357@nvidia.com>
 <aqLOWkuVKccR-I7W@google.com> <20260910171210.GF3968357@nvidia.com>
 <aqMgjXfTJ8u3n7Kj@google.com> <20260910221832.GH3968357@nvidia.com>
 <aqMyXE-fD-UN6w5L@google.com> <20260910225728.GB857650@nvidia.com>
Message-ID: <aqQF0gz3Q2weDyEd@google.com>
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

On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2026 at 03:42:36PM -0700, Sean Christopherson wrote:
> > On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> > > Sean's initial email was asking for strict never-break ABI compatability
> > > rules on top, and that is what I've been reacting to.
> > 
> > No, I was never asking for that.  I think we just have a different interpretation
> > of ABI, or rather are talking about different pieces of ABI.
> > 
> > I am still asking for never-break serialization format compatibility, i.e. the
> > more literal save/restore ABI.  I'm not asking for full backwards/forwards
> > compatibility across all kernels version, i.e. the higher level "kernel" ABI.
> > 
> > To phrase things differently: I am a-ok if kernels are inherently incompatible
> > because they fundamentally operate differently and/or support different features.
> > I am not ok if we end up with incompatible kernels because the save/restore
> > interfaces and payloads are poorly designed, lack abstraction, etc.  
> 
> I can more agree with this, it is mostly what I thought we'd end up
> doing anyhow with version numbers and growing the structs not
> replacing them.
> 
> So you still end up with a version label (string I guess?) because we
> can break it from time to time, 
   
Why bother with a label/string?  I don't understand what it buys us; I see only
pain.  Make the features discoverable and punt on all of the "is this pile of
insanity my company has created compatible with this other pile of insanity?" to
layers above the kernel.

IMO, trying to capture compatibility in a version string is doomed to fail.  To
be useful, the version would have to be extremely sensitive to changes, otherwise
userspace will have to do its own compatibility analysis/checks anyways.  And at
that point, a verson string will be too restrictive, e.g. will mismatch due to
changes in features the deployment isn't using.

> just the version should have the feature mechanism layered under it? I'm fine
> with that
> 
> Jason
