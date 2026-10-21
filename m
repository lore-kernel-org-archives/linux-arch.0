Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626948;
	b=BkKYOyJ9FkzJYG8Sn7741oRW2xNTwoI1Pxdk4TqLPjY6XA3+XfI8SIm0hkzVmAlZhWLq
	 2f87A2lz4pHHR/Unu3x+/O3S+TcTCRurC4+Qfpk/RFSPhcXavNWlgVTRLGIvbDdw437MF
	 OnAw7FEbFFoe84CJWoA3R9XJQVjWaopoDn/C8QomOvCOdGL0lqkMgTZOiTxd6kFNg2Jet
	 mNQ4DmoC9Evpf+pLCQOkDUMIpG+S3CndKGskvGJ6hogQix/b38e3UpAGNnWf3+hGx6xhG
	 lJHqvzGK1P3kKJDWj5PA+CcSWziqDuP4XPXXsvaJA4EBe1fbDt4hRShiLsVqE9d9egw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
	b=rvp/25rrE9KamR/W2Wp4cipOZYrOep/jKyAE/pdkS2ps28ajLmD8KmcnLdg5fL5P5IVk
	 DQt+l6bJYDONM5Ok3p3PCworhyUACnB9dYnvhV7unn5HDcAbONX4IfWuk/YdOgWiusu4F
	 oTT3Rz9YToZUp/qAJq2yCj165uMqtVxiaDpGUWOhbOUQwKDrZmTzI7p2tNfTig+VLmHzG
	 VALrvww9UrDSmFaVMIH9SOT69NiQio5B/e1E5nsnHbY+tvDFdj8ykpQ/W1BGyzEO9bRHJ
	 9teZprwQoIJPAvMUSz6VMzV8Y9bhw/9YpkmNrUTyBalBebL/8SOrROnyYUMhtZGVdZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="EI/dWIvL";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D0606A31A
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 23:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EI/dWIvL
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so8028425ad.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626947; x=1793231747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=EI/dWIvL3ZikjYSg7HzlCkK1GP/TAO36DVcBPvrm7OAp5Wrc1orLvwatwzKpFMCAoZ
         Gk/MHdfrb7wrGGOpo3k/Frr+uYE1d4Xgt5PRmpSGIlZjyHw/k3QgV7DUprgR5sBPyCv+
         aqE0g9FVnWJwBPoCLUhELJbSdSK8E9PDXGOTZY0Fh9l4qG+w3xZTS/Mk4XA8y5aQ8idl
         QX0mAG+zkxeLBEf8PetIs2pbn5JamQFtrxMd9R/AIqbAKtAnqV4mlXswuKOwnIszeUyq
         oEewKXpvMZdytWFJCci0L3whMEC1xnrji2lk6HZt1kfMRAlCa5UvqQwN0fylrWb/61aq
         byAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626947; x=1793231747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=N3+bMW94fyAQ+fQPDMstGghv0TEM30ltnz/7htLPPiHXfO2TipWbgXoUAxCQ9VwVks
         pIj5zN/Q8X6CPCTaYPJ6yalkQ1m1AEUTXoJWR6Ty+J9B4haiPdAq2O+lOHQFrX9bBqYf
         QFzEsdgEKgNXaJxB/EbV+xxVRIHf/yQpl+YzDTIyQndAmPATZpjNxK6LFm+r9QpNck5g
         DKA5kPe75B3QNxtPNKEzaPpzh7WMkhqI1Y6PXKkUqcb5iV8hYIp4LEtHfiQrIFWSJU0R
         DDSl0JXrlKnWxwRVJdQC1UhqmB7oRki6G1Ivb37cSjXgqeL4HD3qmC4ygrVRLpRDGh1G
         lgTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwJMXFtxdWtzBUJMKZg+Tsmt8F6PnKWJi6WHBfWLxgml8ZIylxiOQ4yL1DR73d9XNs1EcuxC0XZ7SB@vger.kernel.org
X-Gm-Message-State: AFq9FYKu4wldhoLnxZmAT5d3TgODxwtGdC7EDEXoJndoLxYm0JU6zpsh
	mHa5is6ge98GasAGi4yWgO3wbtauoWAIHZUPRTDKEUAd0xfHsEnGYE5D8cxiWdDqLw==
X-Gm-Gg: AYBFou0PDzJVZRTsKaNcfvb2XfC58GXBlOBydHlx1V2NhwhLO1BoCE7u0d0LEmYhkXo
	WSditTf2aMKyL5zhZFoSm2JNXFGmR/LtvzTjGgQ+4fOw57rfFX4GAgC8Uc1YAsOkyhjYLoNK5XM
	tWqu8sPHXDEzY4ux02Htci4WIRPdZ67pD+lc05tJelO7e4igPh8tp9/UYDFN2/ammkQ91yHWoBE
	OOFDJpLYErwylaBWjXPctsEH29fFk1OjVMkZbnGN/r0sPaULcIKH5MrDddeSdkxXLN8Rf+CXhny
	NXLaaRZg0FPt9VeQJYxY0zM+ikF9uQqHfLYBfSe6anOB9gijknBNyecUlM6pr/VTN1Qzt4uUGEi
	aObH/hdImGtnXYT36yIRYq9TK9NjmIYtyLldeKUsV00OioTFuZbx8gc1W/mjN1FQNx1if5aZeGE
	MV6SZT0lBz7ax/v5Cglvf4+IBdosP9aPz5VUI4sumhQb6hXWX3PfamTnrAJBnefSaQmd75dCRS6
	o13KhWLZxHz31WlcTyMrggKasYZm/A4z1a/Z8mIER5fHReE1ZcFICBfmAdL9FJeMy+jGEQX6+a2
	CD5zlwhacA+XleSY
X-Received: by 2002:a17:902:f70d:b0:2e8:3190:73a with SMTP id d9443c01a7336-2ea44075412mr31011645ad.58.1792626946744;
        Wed, 21 Oct 2026 16:55:46 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b30829csm16784705ad.11.2026.10.21.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:55:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:55:40 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atlQ_Er0Ig7CCSxv@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
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
In-Reply-To: <20261021152527.375070-4-tarunsahu@google.com>

On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> LUO and its file handlers validate handed-over state with monolithic
> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> structure, even an optional additive one, must bump the string, which
> breaks live update between adjacent kernels. Replace the string in
> struct luo_ser with a feature header, so that the target kernel can
> accept or reject the source kernel state per feature.
> 
> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> structure size from the source kernel followed by 15 chained u64 feature
> flags entries. The fixed size keeps payload field offsets identical in
> every kernel, regardless of how many flags entries a source kernel uses.
> 
> Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> holds 31 features, and bits [63:62] = 0b11 chain to the next entry (465
> features in total). Each subsystem defines its feature states as a
> static const u8 array indexed by its feature enum, which
> luo_feature_hdr_init() packs into 64-bit flags entries with
> LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header from
> the source kernel against its own feature array via
> luo_feature_hdr_validate() according to the per-feature (req, active)
> truth table:
> 
>   Source Target Action
>   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
>   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>   (0,0)  (0,0)  Accept: feature absent
>   (0,0)  (0,1)  Accept: feature absent
>   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>   (0,1)  (0,0)  Accept: ignore payload data
>   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>   (x,1)  (x,1)  Accept: use payload data

I think we have different definitions of "required".

In the PCI series [1], required and optional flags describe the _data_
the previous kernel handed over, not the kernel itself. A required bit
means "this preserved state depends on feature X; a kernel that does
not understand X must not take it over". An optional bit means "the
data for X is here, but you can safely ignore it". The source kernel
only sets a bit when the preserved state actually uses the feature.

It's up to the FLB/FH retrieve how to handle the scenario where a
required bit is set that the target kernel does not understand. For the
PCI FLB we panic since failing to adopt the PCI state could lead to
memory corruption as preserved devices can be doing DMA.

The target kernel never requires anything from the source. If a
feature is absent, the target kernel must handle that, e.g. by
falling back to default behavior. If it can't, that is a compatibility
break and should be handled by the compatible string.

In this patch each kernel has a single static feature array that is used
both to generate the header and to validate the incoming header.  So if
kernel N marks a new feature X as required (so that older kernels reject
data they cannot understand), then kernel N will also reject every
kernel that does not have X, because of the (0,0) -> (1,1) row in the
truth table. That breaks forward updates from N-1 to N, and rollbacks
from N to N-1 even when **nothing being preserved uses X**. Therefore,
every new required feature becomes a compatible string bump.

I would drop the target-side required state entirely and let the source
kernel decide which flags to set for each Live Update based on what is
_actually_ preserved. Accessing a field added after the original struct
then always requires checking its flag.

At the end of the day it is up to userspace to never start using a
required feature while they can still rollback to a kernel that does not
support it. Cloud Providers know how to do this since Live Migration has
the same problem. This also means we must be very careful when adding
new required features, as they need some way for userspace to explicitly
opt-into them. I do _not_ think we should try to have some generic LUO
opt-in for required features. That is up to the File Handlers and FLBs,
as they have their own uAPI.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
