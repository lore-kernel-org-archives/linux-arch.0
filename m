Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812099;
	b=rjnVFIw0E1B96rfky5UpEF5YOsNDcg9tB1Ikvv/p+MBj9jV6flYzmWhE+Fu7HRh3vPbI
	 tCN4GoDclYtFuqsZUYXN/kB2qFIRgXmHc8Nm7D7pHcwrZvA40xEpZGEIXcSPggiNboDc+
	 KcE/CKXv+2kytbGh92AZSAYK7/8QtoE+mFhZk6jwC4rjvOLHK3vuk6cIFLtOOvdUAwPmO
	 VrsuBLMaILFu0jxVPi4nMCxuasTBrZzENpFDz+/93G9JKbKAbBSbFYyuK8HRLklIUYVPD
	 lB8PogPG6jkdtf91Ii9x/7DkqpEnBxvm4Cv4YsEyR3IISwFQH4q8nqik62mtMxzvPOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
	b=1R6s/xBssRQe+C1rl4UmRPFV5080kz1Vb34vklvrLtGInviOTN1oGpUYmAls5ypqSMjx
	 moSnSowNZ13NEYHC98h2f1INwS1IznHsRoapJqkRRHZkLXcd+UAaaeNyT6w/pZOMh7GLv
	 arsg7DoBy8kfVGS/0zb4ADglRPlAEU+PoR1zXNSn4DORaZPXYRFp6f48dOLBNWBCYwZbv
	 czEt4ydwBldlViuTdUNGe8kIeAE2NACiezS4tBDXOMZv0ZHIbgzK4lUSB3sim7up0YW3M
	 UOBeKfsqNtZi3HGg2Sv74BqMjcT8PE2jRTlbb5K9VVaAIh1edB2GqSlkXHiQ6o9d6iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eGRuSzim;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC80606A32F
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 17:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC80606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eGRuSzim
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f3c8958d5so103587885a.2
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793812097; x=1794416897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
        b=eGRuSzimVkRdthVIwZ8j4V5/X1jU2H86/SOE6oD6/Q7NP4cLiSqGfJgp7mTdA8poXQ
         Ts8BLSn06r486J2kiI3LSH2Su7b7ls9A7Xd9I4I/5dgh7f99Vftn1ES0gg+KDm5HAu3m
         8qhGzCV9GbR6gt+jqkZJdyvBGGVnepD7TLWBpWnWovNEPiKSh9jtwTPXzFEUmU2s5ynn
         bgHm8kXq77T/HGgjG6aK4vEYlDsp29ORryNE8bv5wmogxGrWwLnqHfJKYZ61HgXLfO+U
         bsKNswZ80FHq12CBn1lO1iQEpBkx8eF0adXetWs1C2BDIRRqw4Rb/pLyja83jYGYb5wc
         117Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793812097; x=1794416897;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
        b=uTLCXkaj6ny0LwG5HVTLWGP9bZwTE752ezQwKOVF0VsyHLqUrR/BQ+BoycM6W+9LDh
         WT774R+9QraubzRgEWbVskiVumuPyX6VGD26AjUG3VvAmaBrm7v7l3Q2gzOnu4h8TjAJ
         g95b2UOR89xRpM+bXyF6RIW30OqIQyvDxv3yAwiYGC2v7qEHg6HV4Ybxl4CnoqZyvQjp
         mRq1OPOAg+CcneAje6SSCb2lhKlTgNcsq1V0co0vwaMPs99mT9Y+DgBlRGxZGOx6ofIQ
         xghskfNzVpAwIy8FIWibnno8Vr2qWJRyUgZ0pB3NElZhjL42cGQl4RRNXppjkTTqS9vq
         pLkw==
X-Forwarded-Encrypted: i=1; AKwUvBxSQGl7l+fe48Z27TPRRcg1YuHnKM5wczTo9zYvI/kjANi7TjSRAbsaOtnPtB592Z5rebeRIhcr2xy+@vger.kernel.org
X-Gm-Message-State: APuU4Z8ud8FnvHKimTnycB9P4H0g5uyjO0gu/pT08GjnsjpvvzIjR+Nt
	571Wev+mwsDXhwrsdU7Q3P29LAcNtoUmDsir2QliKyKqzpVYXck3osyo95nq2gi95o4=
X-Gm-Gg: AYBFou2Mo59Ie/CraOO7Nds+K4YR8rSZig3Oek2tBSBxQrDxvpCPUmkhWbr3YDO5pee
	7HatjaNknAXAln3ep5wm99tt/DEUKD8XHG2MXpXVXv2iPWvGuE0FYoRLMP+gF7cXixe1bYyLOoD
	T66P64YyiaYrM+mwdDDScWAB0kaT2Cw5i16eJuFFNs9pc5lA7qLTI7vqDv8L5HZ7Fjjk6eQR8Gp
	n31h0n1uVWqKRCrue7CsjuFnhluNBaqnVdXSU72nMqkSccmn3pDP+T3HyLKtX1+zMcQw8itZmQ6
	aJReKLK5bhqXUI0XeN5eLyKNpWAna3h1jnd1+FpYmZ42hUXomD4hv1bbJ+UDMhvuqR3qB7bbZgT
	XlWpLrMb2durVhy9uQnN7O+/MFE3brDzJaJ6RjQjhuqPB0kdOb9Al4yxpSEUdx5CMVUeE9JOK9n
	joLyQfv8XXcyGWJlpDcMjXn1sNPu6DAR2r7OBCQKi6ScgbpU2Z0BGokXJ5i03Z0v+F6ySddKSS+
	YJqdHbaoPraU7SptX8GCvlej5M0dzMRys7y57miIknG3FvQX4IcI3FMNVeh8aHqGaT1G5sE463h
	VP1Uj/V7Ml3uhNbyxczhbaFUKp+zcSTJk7r3E1ONV7otZX2Xg4mvJqsHGLTdk7y0gokkrFYU+hC
	Loq3hVya9Ew==
X-Received: by 2002:a05:620a:4014:b0:944:dbd:831b with SMTP id af79cd13be357-944216dbfc3mr2925762185a.51.1793812097533;
        Wed, 04 Nov 2026 09:08:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm247450485a.23.2026.11.04.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:08:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOeTA-0000000GghE-1hbL;
	Wed, 04 Nov 2026 13:08:16 -0400
Date: Wed, 4 Nov 2026 13:08:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261104170816.GS3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausIn5Txiy1uRjkY@google.com>

On Wed, Nov 04, 2026 at 10:27:43AM +0000, Mostafa Saleh wrote:
> On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:
> > Hi Mostafa,
> > 
> > On Wed, 21 Oct 2026 10:57:20 +0000
> > Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > > > or attach devices to another VM address space provisioned by an
> > > > external owner, such as a type 1 hypervisor.
> > > > 
> > > > This is not a paging domain and is not sysfs-selectable as a default
> > > > domain type. It requires external owner context, such as a vIOMMU.
> > > >   
> > > 
> > > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> > > never inserts any mapping?
> > Right, the host does not own or install any mappings.
> > 
> > The external domain type is nevertheless useful for two reasons:
> > 
> > 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
> > and detach hypercalls 
> > 2. It allows an externally managed device to leverage the normal IOMMUFD
> > device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
> > No new ioctls.
> > 
> > It also makes the lifetime and ownership clear for IOMMUFD and
> > hypervisor, the device can be returned back to host iommufd owned
> > domains once detached.
> > 
> > In pKVM case, my understanding is that you have a emulated root SMMU
> > which does not do hypercalls obviously. Then the external attach
> > is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
> > proxies those hypercalls."
> > 
> > Therefore, if we were to park the device in blocking domain while doing
> > external attach (as you suggested), this requires a new PV only uAPI
> > that must support pkvm, MSHV, and Xen. So it does not fit in the flow
> > supported by PV IOMMU root driver.
> 
> I am not sure I understand this, how can the domain type change the
> uAPI? can you please point to what breaks in the code if a blocking
> domain was used?

Yeah me too.. The plan for the CC side with TDX/RMM is to not have a
S2 domain in the viommu side at all. It should not be uapi brealing in
the sense that nothing using mshv viommu exists today.

In mshv case the iommu drivers are telling the hypervisor what to do,
so they have to effectively see a change in translation. But maybe
this can be managed internally to the driver by annotating the
blocking domain attachment?

Jason
