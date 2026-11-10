Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316946;
	b=K72HGXr0biYYDjHEWnzHyGJPHT59tZcmwpxTHHu+iNcyazGGJ4R2b3CoDayDPCobtn79
	 P9mwMIwUYbuTD6vZxMyDJXvTYHPsATCez3NPO7xO8LymleN/E5mu9YIqigPA/L7dZIjC8
	 DBVhfuASQbYMCHJ2rVNFajRxvCYObYDlWcEzZx+XFvrKYvKhCe+cZy+8yM8+uUrJGMVmI
	 BGomgm8DjrVMZ7LNolFRMV79tCno+csyzaLAr3uZ34el69SPnf7ZSCJALpuw8NDHggRFe
	 zRsohePkeBPpdD8dB2PczxkN4WUk3CcRf+YeZp4XMnkkRHkHkdj1n1+pOEfbiRoSAhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
	b=e77jtKRxJQrXnNf68iHAeFQ/adhNdhV8GJ9I2UqFWVg/XHayHQTkzOqLvMPR+hOeqOq0
	 HJ4y+DAKEEj6Hqze0ofLlrFY9jAmA2gg1phRW6ejhwQR4FZz84GDhbAVdkQozS1+GY5NZ
	 ZAs3fDb3CAE0kgXtcmXegx1jhhSRG+bVqHgWmcj96M/seU1ekfYJtCjIDJbXTegNaAzV9
	 2vXI2e7QC85UNEiSKeYGMIyXlfM08MpXIdzRwShq72ENfhcsLP9RITjK4Xs06U1Ehx/+7
	 +iJE3gRloJOJXPgcTJH9XkaSs0eXSpN1kjtIjqurgG3VajmI6/JY0AaIsXrJ+BcVomA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FHvsNgog;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0323606A7CB
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 13:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0323606A7CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FHvsNgog
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so203439785a.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794316945; x=1794921745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
        b=FHvsNgogAjEacq7zoQCQutH3H2rY/Mp6nn0PQAx6XhH7dqAsY4gCPt7R9BdbuXPKAi
         wxpxDLfikqVcN5xM1VY/H/v/NFQ6nTNQYbBjTB9Y+X54YQTUKZWiCbPrue0kUPKLvs0B
         SWItP2scQqWO4gEug+/zO85bmIDyfB5gy06RbKUkHIRG6Td26af+dAAfFxPpJhtVkzxI
         RTY8q4wfOVoj8Mo0U14wRoJwsgbjTWIxlmNGak378mVQpNEb8y5wGLQ5tkNTHEct8BTD
         2QLJqKjtduDf7mQ4NLfWes8q0X9CZ1SxAGlG6dddpQmRt2wbHKc2ucYJzj5kuQNmJupi
         3xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316945; x=1794921745;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
        b=GXNVOoOjnDvCHHT2wgzxVhtYP1RuD/mWZCMXM+WRQGpTc+q/BIjgTsgkktFSWnC983
         yMWBSvC+1M8d1mJudKoibt20TCPgjYBgP1Kew2EEmOVgw3feDHGhlcE1NQKf0O1j5uZO
         /Q5Z0Obb4WF54S+f4PK509grTPutkj9minOAcJU+0x4VGU4L+INorEgwuvXQaH7cwD0d
         c+tbHmxp7XN9G/uS9MqZOC95ji/W0LprRJjp7So5ZvFVxT3oce4c0TL/okUvTkUcK9lY
         tjBEo2MSKctKZEQSq8ckDOlvGQBympEetWKVpYWxs3R2jfRcrOVRobP5rFJ8F1oAYQPn
         60Ng==
X-Forwarded-Encrypted: i=1; AL+hErEWPvvA00o9VouOmIFP12epNVc9fdmhLog4t1MjGCHrTrCeDazD3Nfs38jJAmQaQo7J0b79VIgfzMZd@vger.kernel.org
X-Gm-Message-State: APuU4Z/2PG2N/GmkVwPuxkw7twUWXPR0fzVv6XWLp+7dW8BmGosXIrn5
	wn+lfjM8GKkodQSSxjKYnGb2P8usG9X9aR+H8+8Alf37Xf9YOLe7GPj5bwQh38GJfqSJJOu2KQf
	Udyxg
X-Gm-Gg: AYBFou3f6UUZm3jIFWXprkbrsmbIHU0DxcrD2I54ue808QvEEEFadIGjRo5FjEQTTII
	P2E1MHOABKQTq0yWwBbpFn/qASSi60BcG14VFpe19n8JpAMPl/i8B+iWGKYP+bEY96oq3UgEooD
	HU7zierPdkCeav4rsdTRtkOQYpcMt729jJslE7HBHReNp7HvuDrwa2wWUWQT8lcJ2URtIq7Vq/F
	0QeMUqNb6rcPcrdQfLRLXfMnIkpvejLMyHBkm31msx2VOjAb+6gFR9KgJgpAD6dIvWo02p7Os+C
	ZUUOi0DZdahkaX+hRra4GYM0F3Epgr9F2+ywbxuhVztJkZMg018w+fTexvkKCZwldF9HIzfdKs3
	etvBPt22gx/WLbNsnm+SjP4C8RPF0OAMAJhkTZJlfs7NRntFDKcR0Q4iWL7C5vbdXkPoCc4Plb3
	X0ZrF3l/nmxSA9w23kgqDViwFXKLViBGzuDDa9EMmJtnpPqUF6e97uy3RfvZbYkaiyh2sC//hRH
	K4BaA/K/+KfIq/Q6c/kGx1mnMJN7kKtkwj1QAZ59MvGY3cNK+AYtkN3uM/ns3O3IO79Et0T6TfE
	U7GRa8Ebu85i8J6tFslWZUrkTgSVAshkbFExdGrKCBtzv+wFBDXd/gw2NaEIMAHcHb1U94Zc1gK
	n+Hz0iY2yYPM=
X-Received: by 2002:a05:620a:1a21:b0:93e:c12c:43fd with SMTP id af79cd13be357-9479f373debmr404603885a.74.1794316944696;
        Tue, 10 Nov 2026 05:22:24 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7915e2sm220546385a.23.2026.11.10.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:22:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQlnr-00000005hfb-1yLA;
	Tue, 10 Nov 2026 09:22:23 -0400
Date: Tue, 10 Nov 2026 09:22:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
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
Message-ID: <20261110132223.GX663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
 <20261104170816.GS3889730@ziepe.ca>
 <20261106130352.0000638d@linux.microsoft.com>
 <20261110005259.GU663069@ziepe.ca>
 <20261109224200.000033c6@linux.microsoft.com>
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
In-Reply-To: <20261109224200.000033c6@linux.microsoft.com>

On Mon, Nov 09, 2026 at 10:42:00PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 9 Nov 2026 20:52:59 -0400
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> > > I am not stating that it will break UAPI because of blocking domain
> > > is used. What I am trying to say is that with the blocking domain ->
> > > external transition, we do not need a new UAPI for external attach
> > > for non-CC. It will just reuse the existing UAPI.
> > > VMM:
> > > 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT,
> > > &attach, "VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> > > hv-iommu-root: external_domain.attach_dev() will do the hypercall.  
> > 
> > You've basically described a wonky NESTING domain.
> > 
> > I think you should just use nested domains for this. Even though there
> > is no S2 make it possible to create a nested domain through the
> > viommu..
> I didn't use nested domain since the current parent hwpt is a paging
> domain which cannot be used to express the external attach semantics.
> 
> Are you saying that we create a parent-less VIOMMU (in Aneesh's patchset
> and my RFC), and modify the iommufd core code to allow nested domains
> to be formed with an externally managed parent? or we expose a
> opague parent S2 that is not paging domain?

Just use a null S2 for this. If the viommu was created without a S2
then the nesting domains should be created that way too.

Once you do that you have a normal HWPT representing the S1
translation in the guest (identity to start) and everything works the
normal way.

The only wrinkle in your setup is you don't have a S2 at all. Not even
a placeholder.

> But if we go with the nested domain route and let hyperv iommu driver
> handle the nested domain attach, it still would not work for pKVM.
> pKVM's root SMMU is emulated, so it cannot do the external attach
> hypercall in the unmodified SMMU driver.

Yeah, I think it is fine that the hypercall is not part of the smmu
driver..

> So I am willing to entertain Mostafa's approach to park the device in
> blocking domain, then use hypervisor provided viommu/vdevice ops to
> invoke device external attach hypercall. Basically, move the
> attach_device to external S2 operation out of iommu driver to the
> hypervisor code. It does not need domain ID or anything IOMMU specific.

Right, though in your case some co-ordination is probably helpful
since things might go strange if the hypervisor side and iommu driver
side disagree on what the translation is

Jason
