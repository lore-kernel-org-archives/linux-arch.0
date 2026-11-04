Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787810;
	b=hcnPRc6wgIF/5Bi/jEoX0G3gxrj6Kq6tEb26sYhVxooK4NqwbKfLdnjfhb1JOjkiJbJy
	 QCy15OrOAhfP3eF8xPPYXI3UrvF6S4are0k1vUpMsMkdkFchxBbFIw0FkJhaMSJswtvdv
	 rRcqCKX4k4teYtEqJbQkmIfv+6aQgtkaA/MmkX7SQ+e9vj9FfiNRG4W2oQ3arBplpYTCx
	 nY3FnNZNKq22CU37Vo4j3vxEQWZZLE2myfJITyFlDYWHHPLCLAKOAcwj+gQfZx4CBYhbk
	 ja9zCVTzv62nW6bUusJ5zpdWoS23bhKsbuHwguM9ovQTOgKSBBP59scjpkDb+5iwEsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fP2wtbL8okahCme2REeuz/5kpLBhIsTYBbFIyLkDukQ=;
	b=a5R9gBQ4om5F1F2rfDWmgzxFqa/qufDrARZV3vRCgwpdBgxkzkKppeaynJMPObVT78ip
	 0YAYKCIh0dWZ/144jcK1FoSXbNlJADS4Mnqn1d2j6udVsKb7RG1cSIGxnRxR3wgYRgCgS
	 9XNJI+BbrfdM3a/vwP265Ph+ZzgL+78FYbMDvyNJZfLs6bpj3LMyMZwEj+2ggkcG9t4Ca
	 sGwS5GlDhR7jLlWeZhv8dRR3GpB5F/Dk86dPUQYbyG3xqc4d5qRxlr5eZZslkpU4Fddnt
	 zYuOladeNWEPZaiDT4oZQmMRBvuKKS3FoLU3B5o4hqpyeDiRwasjcMtPyeRTbilHwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOH80JmD;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C50606A31B
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 10:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C50606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOH80JmD
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so6872a12.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 02:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793787809; x=1794392609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fP2wtbL8okahCme2REeuz/5kpLBhIsTYBbFIyLkDukQ=;
        b=BOH80JmDvOkOft+cKPp7n1RirDBIBFL2zo4WJZDGlWTn0vLjSBwquwsHFimt4K+vA1
         FdhAnhkpRpC7pduXSvZ+wG3rv/sxZmXhoWLS1uEqK+jTRPZWyd4Md60+3MPU2OOGKZZy
         3r+suUFd3TMG2GtAoDCzc8Mrc8s063vNBN2gqQt2tUZCxE+/nAa4YFsisojEjNCQKoCc
         fSK+aGOVHtKanDoGRkovZI45rCR8TKH0vZQRA7zy7t/vzRmWkA8mpNYclrLDEomrjwPP
         RNzlTcn/803NgI+tVuOvSJdntkLED2/EKHQwTSjyVt/kTlNjRRYG4pMdP4Wm5ONavfih
         Tulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787809; x=1794392609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fP2wtbL8okahCme2REeuz/5kpLBhIsTYBbFIyLkDukQ=;
        b=ABnEUz8t3uKujUIO7e3nk5WLezZXG2+U/Q1z+RsOtAGGxbkmAtox2Y7A8YEOMdhYe1
         tUGOMhqvauvr5mZRSMahquuZZrB49jrOHYF33/+4wNuAKsV6c7mMrhAaVqnWspkKoxhY
         x+G/RfIAhVQSEo92+XeG9fGsAe6jmeZ8Xofq4wR3KyWZ572+yFJ7U7tTxnCy7irYcHvs
         FyDfN7jtBa4NNXaIf4gtx81WYSBB+gno9cFkhKEdvqgSDh4x0FYIfdQ366FaloCfFMnd
         PI5f5pmnRKL54l8Q3vmbjNlj6yolp0rGTBmBLXDTrhw4b0rplvRaMNMta57lztkUMcR3
         p+8w==
X-Forwarded-Encrypted: i=1; AKwUvBw5AYAlS1cdyrF5z5tJslh75UtSki+vCZUH9QFvMr2addmrMBt1/9623igkz59xV1sAAUgU5COy5QCZ@vger.kernel.org
X-Gm-Message-State: APuU4Z+THcPzG83DMlp40rfCG3eOFh9mPWtuysQqa5Sd+BfZyr8L9+EE
	6Ji/iZU6uDgmnaNl576Al5Qnt4xfipwrfg/xELZT3EGt2qlyKweMRt3S40mJhJZP0A==
X-Gm-Gg: AYBFou2dYHOydfZF3G7yikR8Y/c0p/nNSyMW1k6aoSh7HY4tClVjWDGHrctOO3gv9/g
	Xqy/GQIKUTNAXzQpcaDqXH1anVMxS9KBCg7MgWrDRjGRP50IqwVYdlxcpXcp1mOlezC76lICDNW
	LzZRx03M+1ZCFSL+3bwhPQGG02wYaZSVJsVPjo9kVLilb3lT8/JlRTNxkk7Lqw7ljQsi2bdk6i+
	Ou9Yu1ja47WrmRt1eEfeMVZmdN0cGVDAd2/zjv9LTXCPk2y0DYf9ba6Gss/4QLLgINDU3/XIWVT
	jRqJ82eqyFv4Cbo8r4gXEIJg5jgQlpYPk94l2fJM+FonkvT3CzY7PhKsjTiIxxG6CD46VMaiWFj
	UfCb3gir1LapYHqNtt0phbEt9ZCO+fe33gR7unUUt66MS3yK9FyGmBjUE/jbUQSIfWzlmnl0Nzx
	62gfn3NFpiltBYahFJjhS4a0g/IFy3yBUNIpZhZGtrrSnFHWqjuukQezP0fzlwhZuS/J/sMsRE2
	NJmIjI8kXTVYBNR2ks/Cz3LoLpPjGhjU7n1iqHbB1q9XrT7F03E4u/ytqMwh2WsNK3EC7zqNKBT
	SoOt2lj5p6bTFPxVznQP4Vmd11dazqAQ7VdO20fAXJ/A9JyEqDr4027vDXOQZPS02wqoEA==
X-Received: by 2002:a05:6402:a2ca:20b0:6b4:6725:f2c6 with SMTP id 4fb4d7f45d1cf-6b55abce7efmr53379a12.13.1793787808278;
        Wed, 04 Nov 2026 02:23:28 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e1402c6sm55414666b.2.2026.11.04.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:23:26 -0800 (PST)
Date: Wed, 4 Nov 2026 10:23:22 +0000
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
Subject: Re: [RFC PATCH 0/9] iommu/iommufd: Add hypervisor external attach
Message-ID: <ausHmkhAegDEyeKV@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <atiaKG86qcifKzBT@google.com>
 <20261026114917.00005a22@linux.microsoft.com>
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
In-Reply-To: <20261026114917.00005a22@linux.microsoft.com>

On Mon, Oct 26, 2026 at 11:49:17AM -0700, Jacob Pan wrote:
> Hi Mostafa,
> 
> On Wed, 21 Oct 2026 10:55:36 +0000
> Mostafa Saleh <smostafa@google.com> wrote:
> 
> > On Fri, Sep 25, 2026 at 12:07:33PM -0700, Jacob Pan wrote:
> > > Hi,
> > > 
> > > This RFC supports guest VM device assignment from a Linux host
> > > using the Microsoft Hypervisor (MSHV). The goal is that a common
> > > set of flows and infrastructure can be applied for Xen and other
> > > type 1 hypervisors.
> > > 
> > > Background:
> > > 
> > > The IOMMUFD/VFIO stack used for device assignment has largely
> > > evolved around the KVM/QEMU model, at least as the first enabling
> > > target. In that model, the Linux host owns the host-side physical
> > > IOMMU programming as well as the physical PCI devices.
> > > 
> > > Architecturally, MSHV and Xen differ from this KVM/QEMU ownership
> > > model. At a high level:
> > > 
> > >   +------------------+
> > >   | Guest VM         |
> > >   | virtual IOMMU    |
> > >   +--------+---------+
> > >            | vIOMMU ops
> > >            v
> > >   +------------------+    external attach     +------------------+
> > >   | MSHV             |<-----------------------| Linux host       |
> > >   +--------+---------+                        +--------+---------+
> > >            | programs                                  | owns
> > >            v                                           v
> > >   +------------------+                        +------------------+
> > >   | HW IOMMU         |<---------------------->| PCI dev          |
> > >   +------------------+          DMA           +------------------+
> > > 
> > > For MSHV, the specific ownership model is as follows:
> > >   1. The Linux host OS owns the physical device and exposes it
> > > through VFIO/IOMMUFD, but it does not directly own any of the IOMMU
> > > hardware. 2. The device node (/dev/mshv) owns the VM partition file
> > > used by userspace. 3. MSHV owns most of the physical IOMMU
> > > programming, including stage-2 I/O page tables.
> > >   4. The Linux MSHV root pvIOMMU driver bridges IOMMUFD/VFIO UAPIs
> > > to hardware IOMMU programming through MSHV hypercalls.
> > >   5. Guest virtual IOMMU emulation is done in MSHV rather than the
> > > userspace VMM.
> > >   6. Stage-2 IOPT may be shared between CPU and IOMMU. It is
> > > managed by MSHV and abstracted from the Linux host, including TLB
> > > synchronization.
> > > 
> > > These structural differences from the KVM/QEMU model create several
> > > needs for IOMMUFD support:
> > >   1. Move a device to a guest whose I/O page table is externally
> > > managed. This patchset refers to that operation as external attach.
> > > Unlike conventional IOMMU vendor drivers, where translation is
> > > managed within the driver through paging domains, external attach
> > > means that translation is managed outside the driver, such as by
> > > the hypervisor. 2. Identify the guest-visible device across VMM,
> > > host pvIOMMU driver, and hypervisor namespaces.
> > >   3. Identify the guest partition in the host pvIOMMU driver for
> > > device attach hypercalls.
> > >   4. Tie the device-attachment lifetime to the hypervisor partition.
> > >   5. Coordinate guest-memory pinning and mapping for DMA between
> > > MSHV and the external IOMMU domain attachment.
> > > 
> > > External attach has a few caveats compared with KVM/QEMU, where
> > > nesting is typically handled by the host IOMMU driver in one
> > > transaction after the userspace VMM uses IOMMUFD to form nested
> > > domains:
> > > 
> > >   1. MSHV creates a temporal split between host and guest
> > > device-domain attach. The host first attaches S2 through a
> > > hypercall; later, if virtual IOMMU is present, the guest
> > >      allocates S1 and establishes nesting with MSHV directly
> > > through a pvIOMMU or emulated vIOMMU.
> > >   2. Guest-memory pinning before mapping is covered by the
> > > MSHV/userspace VMM contract, not by the VFIO/IOMMUFD pin-and-map
> > > DMA flow. 3. Device capabilities such as ATS and PASID need a
> > > contract among MSHV, the userspace VMM, and the host pvIOMMU
> > > driver. At the time of host external attach, only S2 is attached,
> > > so the guest's later ATS/PASID usage is not yet known. For example,
> > > whether to expose and enable PASID in the device could depend on
> > > whether the userspace VMM creates a guest virtual IOMMU.
> > > 
> > > This RFC proposes an IOMMUFD external attach model for those cases.
> > > The normal Linux-managed paging or nested domain is not the object
> > > that ultimately owns the translation context. Instead, userspace
> > > identifies a VM/domain object, binds a physical device to a
> > > VM-visible device identity, and asks the host pvIOMMU driver to
> > > attach the device to an externally managed address space.
> > > 
> > > The series makes that relationship explicit in IOMMUFD. The model
> > > is anchored around a hypervisor vIOMMU object that represents the
> > > per-VM partition abstraction. It introduces:
> > > 
> > >   1. IOMMU_DOMAIN_EXTERNAL for externally managed translation
> > > domains. 2. IOMMU_VIOMMU_TYPE_HYPERVISOR for the file-backed VM
> > > partition. 3. IOMMU_HWPT_EXTERNAL for user-visible external type
> > > IOMMU domains.
> > > 
> > > It reuses the IOMMUFD vDEVICE object to carry the guest-VM-scoped
> > > logical device ID visible to the hypervisor.
> > >   
> > 
> > This is very similar to pKVM on arm64 also, where the IOMMU is managed
> > by the hypervisor, and for device assignment, the host doesn't control
> > it for the guest, but the hypervisor (in EL2), and there will be a
> > channel between the guest and pKVM directly after the guest runs. 
> > 
> > The host only sets the virtual to physical topology (how many vIOMMUs,
> > vSID -> SID mappings) and describes that for the hypervisor through
> > hypercalls.
> > In Android, we have an out of tree uAPI through KVM/VFIO bridge
> > IOCTLs that proxies those hypercalls.
> > 
> > In that case, the host just creates a virtual IOMMU and the guest sees
> > a paravirtual one which runs with single stage collapsed translation,
> > although I don't see a difference on the host side if nested
> > translation was used beyond an argument change to the hypercalls.
> > 
> By "argument change", do you mean that the host would pass the guest S1
> context in the device-attach hypercall for nested translation? 
> 
> IMHO, I don't see any change needed for the host-side attach between hw
> nested and collapsed single stage, if guest and host attach are
> split. I think it is up to pKVM or MSHV to handle guest virtual iommu
> mapping for both cases.

Although the hypervisor (pKVM, MSHV) is managing the guest IOMMU in that
case, I believe the host should be able to decide the guest virtual
toplology, as that will impact the firmware tables populated from the
host for example, as in the nested case the guest will see an
architectural SMMUv3 while in the collapsed case it will see a simple
HVC based IOMMU.

> 
> > My goal is to converge to IOMMUFD and I believe this series is the way
> > forward, By relying on the vDEVICE virtual toplogy uAPI and the
> > external attach introduced here.
> > 
> > I will try to prototype something based on that to prove that it
> > works. However that work has a dependency on the host SMMUv3 support
> > [1] which needs to land first.
> > 
> > [1] https://lore.kernel.org/all/20261015200903.2735565-1-smostafa@google.com/
> > 
> Same here, our pviommu root driver must land first.
> https://lore.kernel.org/linux-iommu/20260929223622.778617-5-mrathor@linux.microsoft.com/
> 
> My next step is to rebase on Aneesh's v7 such that we have a converged
> iommufd viommu layer, i will remove mshv specific helper registration
> in this series.
> https://lore.kernel.org/linux-iommu/20261008055955.4014342-1-aneesh.kumar@kernel.org/
> 

I see, I will add this to my review list also.

Thanks,
Mostafa

