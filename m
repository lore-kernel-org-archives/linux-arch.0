Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811866;
	b=L2TfFVCevxz1koNQET0AYM9pUJjprS97vVq9VDV95c3JhySbeFjsvaaQIEmFj9yf2KIs
	 +3FSIMUafg12mjkoMYfzkUUvpD9Vmmei4beRIY8e3WLg79mt40JgRveXVBOwFofUuqxlS
	 uLe85iUhNWjn2WlYST8/2z5JnWrSlTfDQyf/IsQSx7owJu5n8lcUkZYYoAItI1Ub7FsB6
	 UOM2ulKOLIXif7+zXINGBZ0KtulkhcbhOVpRTtuAy/iXwKE3R+yFnh769JNDxqH8i0Ofs
	 GGKRhKFgQoN4S7KP6SiKTZ0EUlX8y+SUh8LQB0GJDAkpc4/easidIMVhHPZ5O23Uruw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
	b=TxTPEFVeDgSWhBR71qy3OOKYFGl+F8j5VR63Z3Gx+W4hzFTueqmDlK06uKp/Trbk63LN
	 7V1n4YcrHmJfcPKnpRhipcj7361SL7FPV2CEJmfaW7F7x0SMcbwtd3af1AxcHVD97zeSk
	 BMeCgfY0exn1W3T/UWDSf3mHsuI2lwAQkvdb9sDYeF+qDP8KYH/MXSwXkzQg0q3Z/AvT2
	 4O7DszORjuiGJurolQlSut6shTJFVbDO93V0YpmsWr88uNmNh/buRx6c5x+HPj9xezT7b
	 2fL+9WZukwFchjR93ngfhGd7TRy9XyfWWA4K65dSA0XiEiYIi8N9zA8WU8TU1IM6EdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FnPloMwq;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C8606A326
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53C8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FnPloMwq
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53644ab1f7bso7747681cf.3
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793811864; x=1794416664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
        b=FnPloMwqvWngKH5CC21E5gJVOtx9Q5IEOnDICAe0sUklobcLcaZM+/OzQztOg89V0i
         KuoYr6SyqqP0xsZKBKmoT7XPljGNtu70vol3a74doIKswPmkwzug2tclYHu0Kv6e8+l1
         +JFi5Nq1SAEhSZWtNoYLF/yglFUJwdfBpio1QPbUxTqzxSq0ojCqMir0AcZtuREGNKkc
         xyRB328ONytLaREiGlvambI6t4Rgz3ko2L3z8UmYQdtz5N13n5IxPkmJRjT0jTqvisOv
         Q5yUTN4FFVFuHWw9xNUBcxZAVWN3xoPTIIdN/XDafoot5ZcebTrlkbNL0cBh0geCpS5L
         XNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811864; x=1794416664;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
        b=YrQi59uxLJGGnrRIScXR830m+8VjJV6M3w11Ovklyj4DG2oRi9bmQDvHA59z86Lver
         vw1ZNEEOdGY46oJtd35SCxg/X7SYAEdrIQQtKmKh2drXM65Ricx87a8L4KgAmU80B0tU
         QUT7jH7I+TxVXwF5qE7s/gQCJvek3YNd+Kp/ZBdWFZo4Dzm2mMD2aLhJhdXy/aPbXxge
         z5Wsc8o++1DvXVCBUE5Zn74oKJtAM1L/CpENoC9wrvCYm+toUDmkzUZd1rMNAJeLEWio
         YqDWwGL1Tu8HceFSXXLIN6LHU3KvyBxVE8Yulrsz6nfPbkUr9EGeGzO6q+/NSkI4jC83
         UbMw==
X-Forwarded-Encrypted: i=1; AKwUvBxm65ajx9l5EgafupY3wnvtlT39vMdM+Xd9DVkoJuRuM2czLxS1lOZY17+iDgf7CAWOx1MgZCPvCwXF@vger.kernel.org
X-Gm-Message-State: APuU4Z/SK2BmID4Dl1x0+9bMnf6vQU27vAUaAENaQ81PZO3w5cEZJmhJ
	NvjKn/qkTSjfaRYuTb474wEuLPomgv42yOmUwJ/8o6iY167AIA+va8ncQK4X4JjjCvc=
X-Gm-Gg: AYBFou1o1IVGO0eEBvSw16J7Z7Y612TKLi6apzTN/SIoPpxWLFu1q6BuhATiRuWhcCm
	pThrDnwR03EUTZ0ap+Da4EUa3drJFooUKGR7+dTUt7v38cEIRB9cL8PnXJhmrcb1tT/gYAI3g8D
	+PeCBKVlxh68u7H1R4yke3bqIW8HIGE9O7vu/tlrHmS9MWkSxjmT0v7W0EKUU/8nSMi4DLND+QI
	l+f41GbYPS1cUUE3gHDEoivbSCgP3XVhIFB+fR34uSX/lEUneMmAnZ2AzaRptW9K1HgJ6FBQ4YY
	RQzy4sk/W0e7VwoGuh/v52zAOsShT0fg74MMv1oxJJDhyxe/XISN2oKo7nWHasra58v/et785yd
	9gk3hT2hpqT1Rkk3aOzd1ovbySUp+0PGVUQkO0RKyU5leWGSEnicZNWGi0U8deF7oBfei4V10gF
	lyHXamLeDu7uXdLundGSQtFD2tWZR0VBZ6JC1hRcvV4hiubAKmqUTEe4XfVU04v1EE1A13imRM/
	q8I5zlW6V/J92zCNlPUg1ShR5uHvGcuRQhtRkN2CgmvS91iIjqhRCrWdsHh8BoG5kigyvS15seg
	x+XxnPIkrh8DZItIpy1J782GKshqRdqhOR3LiDHVF2jTvulJt3XdGipDyGiMkjMKIo96wlJt0FI
	AZrORBN6NkQ==
X-Received: by 2002:a05:622a:e342:20b0:537:83e9:e46f with SMTP id d75a77b69052e-542b3c732f5mr202335741cf.3.1793811864442;
        Wed, 04 Nov 2026 09:04:24 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c49ab3sm28279301cf.19.2026.11.04.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:04:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOePP-0000000Gg2b-0y2m;
	Wed, 04 Nov 2026 13:04:23 -0400
Date: Wed, 4 Nov 2026 13:04:23 -0400
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
Subject: Re: [RFC PATCH 0/9] iommu/iommufd: Add hypervisor external attach
Message-ID: <20261104170423.GR3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <atiaKG86qcifKzBT@google.com>
 <20261026114917.00005a22@linux.microsoft.com>
 <ausHmkhAegDEyeKV@google.com>
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
In-Reply-To: <ausHmkhAegDEyeKV@google.com>

On Wed, Nov 04, 2026 at 10:23:22AM +0000, Mostafa Saleh wrote:

> > IMHO, I don't see any change needed for the host-side attach between hw
> > nested and collapsed single stage, if guest and host attach are
> > split. I think it is up to pKVM or MSHV to handle guest virtual iommu
> > mapping for both cases.
> 
> Although the hypervisor (pKVM, MSHV) is managing the guest IOMMU in that
> case, I believe the host should be able to decide the guest virtual
> toplology, as that will impact the firmware tables populated from the
> host for example, as in the nested case the guest will see an
> architectural SMMUv3 while in the collapsed case it will see a simple
> HVC based IOMMU.

Yes, this is how RMM/etc are working in CC land.

Untrusted hypervisor defines the vPCI topology, trusted hypervisor
implements it as instructed.

Jason
