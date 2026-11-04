Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788078;
	b=aLoO/eikISEXUcgBS30h9kT8yi/qmPqrqHi5KqCDFyeTI/fvexXRQzqM1T1bRRVA1t1G
	 Br17w771OtIcDkNf3PiJ5zzEjzqeQuizkpO/tl8gUL0w5mj7Bp+8kw35ealrFkFsgzndh
	 wwNgeXVKAtS1iCmRciaRSMGgHOhA40VlNoNK+wj4maQI5L1OlDJyDq6wDkC9oDO24uY5w
	 8FBOVoUNa8zWEv+wD5f/bkBpORdWNOFEG9LMVBOwVqaK+q5B6W92KfBvY9Xe/yG+PiPT7
	 gIH+BZko1VAiJKHBoXV3XMc8L1f/Giz13YDLxbpbdVBgrCutsmBdemyUQeZyK2DSSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
	b=0A/ykab2F8nqSmKPBSd7o+Ww6S6dQwB4SlC/9AmAlhMrKh57BMFSr59iPZ3rdgGFQ1b2
	 MRyrU+j80JNvbV3AKUiFqrXvzstKNif1kmQ8D13AxqmdkK/l7PUQMjkaL8LUf4kxLQdrk
	 2rI5L7JcUNQH709+vM6ocExwMnuL0uOb7oUEuY0NlqTsUP5P5TcSkPce/kzvkUcfgwfgz
	 goeCS7Qvf695Xx/ZiL0TokQShLHT49iihVRd6oneDspUWno3Hov5JxRvZwvYNqkNpy6SS
	 zrfBf5/mONoFkuaRitqOOw8rxO89A7eu4rk2m7m6DnBPkZyTh99jcjbEtP6uVAjwwyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ETY8VoT/";
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F965606A329
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 10:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F965606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ETY8VoT/
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so9722a12.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793788072; x=1794392872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
        b=ETY8VoT/f+gDU32SGXFwti5vr5fy0yPG6zRSjejzpQMJOVav1+tZqMyte9EyF+4IgH
         MRjXyR3rRsdcXoeKpcoHArC9/SxZlMktYBlTbH+p5n1AVBtDVR7dHfaIjeIDkHwAiBIu
         ecAm00KOZxHMW4azoXD3Rk83uDFOqv2kDZdYCIPC4ScTXNMup6y+qGzCbcsq+sE3NSdC
         l4bO+Ci9F2o4AJsy2FJkWpS/3buA0DTrbXiJolnxhXCLPEtLIHpVG3Okxp1grtyffcs1
         CYgX4q74LfeC9PpDxlC43DVAJD3zZNyhwtgmvqgB+CDSbNqSP6LAuvTg0dnVsoSaa1NP
         hlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788072; x=1794392872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
        b=pDTj45B/Hfd3f7Wlp6GAA8qS0YoMSwKD+/tI/JRZG+xhpgUnIr1p6l3Dy9xIt52V2k
         tXvNDMWyhhpFi0YqMHwKJckT57btEJ4iYkxQ9WSTMCPxGwwBi0zNdZvrDjtJ5FnL/v1z
         XBV22IZRbNo/ub4gjfqc2IPq8tgR1vpYwztYIbBJYp2blvgcjxPX9Q4Vxw+utdg9xTuo
         thKFZhZWEyDmNHtiwvO8qwAnP+LJKgjwKalq9yW5X3B1EG4qIl71bviBkz57+BviFeds
         ox2P652pXirsGTVyfXH72g4sYtcdOiiom7sYmzioVLpY4EvhiBiSwG2EAH+LgMvI1rHd
         Oa+A==
X-Forwarded-Encrypted: i=1; AKwUvBzAPgFxsi/0xv1Swaxf9MfzRgxXym73t5OhAxAc9SE8npZPm6SraIKEf6Wf7K+dzqMq7vG/S3wLvqaC@vger.kernel.org
X-Gm-Message-State: APuU4Z/Fc3gdz9M/1W09DmclVP9DNkPLgOHVd23M1oodNLjF0PgPLQ+t
	0qYznv9iAjrkhAkJQxAm/6rFgL4RLysnUa9CyociPS/jM3P2ey3LXYQUoVRX4t3qIg==
X-Gm-Gg: AYBFou2T6/ivCz2+lKvOxTl8EihOIe8UjTg78qaa1m/cnZ5pDn50HQNRqsMk8h0fRJr
	+Gk3E54y0aV0hbjs06v0npGQuUbaia4maa99a88T6crtO4YRSwLUnUBPNWTY3b5ySqioTJFC3H/
	pNtxju8tU6lYVC+TZm7F3OzcI8JXIUyt5tDF5pHOedNMmlPvZZptmKBSDniQGYZLxTom1tiHLFR
	TGb6TCb2l8IIx0bEm0kknQh/68PeJzWg05nPV3wzqXdg/L5KNoPW5gLT90+Y0CTmB7uvlxNg6EO
	lswoKhet5+Az34IcVpmCQ+FZzCYvf15EjPGlIxw1PklRhdXtYtCmvLX9qXpJn5wN/PLgEGAf94c
	FrGrq5u4mRIZLKs31hrfD/IGGrPIsexe4AzepFLdz51dWONryHdciNOoCz8UeGXyY8I2aqcHovL
	kgoj//o78xxMWcpXAGxzGra6bHbugzIeOLVM7zLE8QDieJUWnCJEFtaTsPXu+mdoLsQ4QYfmr5/
	FMvpGi26Y8BAvBu7HDjgEPCI0R8ZyAFthV/8qiTMUKxSVRZJZNVG5rIxG3ksDh9S9zQIqtkJOOx
	WZwt7RJxqYg1tVf8Gn4GVDv1k3Y+DnTJyoL3hdfJ+k1ZOA7MSqS0NKZS3VpGSFLJ4TVgrTjenwE
	kppNP6xwd+YseWk2C
X-Received: by 2002:a05:6402:20d9:b0:6b5:5cd3:5dc with SMTP id 4fb4d7f45d1cf-6b55cd3077fmr36964a12.1.1793788071437;
        Wed, 04 Nov 2026 02:27:51 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41d670sm54601366b.23.2026.11.04.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:27:50 -0800 (PST)
Date: Wed, 4 Nov 2026 10:27:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <ausIn5Txiy1uRjkY@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
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
In-Reply-To: <20261026161003.00003b71@linux.microsoft.com>

On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:
> Hi Mostafa,
> 
> On Wed, 21 Oct 2026 10:57:20 +0000
> Mostafa Saleh <smostafa@google.com> wrote:
> 
> > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > > or attach devices to another VM address space provisioned by an
> > > external owner, such as a type 1 hypervisor.
> > > 
> > > This is not a paging domain and is not sysfs-selectable as a default
> > > domain type. It requires external owner context, such as a vIOMMU.
> > >   
> > 
> > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> > never inserts any mapping?
> Right, the host does not own or install any mappings.
> 
> The external domain type is nevertheless useful for two reasons:
> 
> 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
> and detach hypercalls 
> 2. It allows an externally managed device to leverage the normal IOMMUFD
> device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
> No new ioctls.
> 
> It also makes the lifetime and ownership clear for IOMMUFD and
> hypervisor, the device can be returned back to host iommufd owned
> domains once detached.
> 
> In pKVM case, my understanding is that you have a emulated root SMMU
> which does not do hypercalls obviously. Then the external attach
> is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
> proxies those hypercalls."
> 
> Therefore, if we were to park the device in blocking domain while doing
> external attach (as you suggested), this requires a new PV only uAPI
> that must support pkvm, MSHV, and Xen. So it does not fit in the flow
> supported by PV IOMMU root driver.

I am not sure I understand this, how can the domain type change the
uAPI? can you please point to what breaks in the code if a blocking
domain was used?

Thanks,
Mostafa

> 
> I don't have a better solution for both pv and emulated root IOMMU
> drivers. Perhaps others do?
> 


