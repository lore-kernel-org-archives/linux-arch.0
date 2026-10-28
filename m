Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209475;
	b=ZQvyliSt2hgfAOumruRjz/w3xo58MmnKAxAjxrIQhTVlP6WIX/sjLOoq01py9xKCtfHm
	 7l1tHTDQfY/NYiCI4PH6vB9CcM0Z8bCRtdGEdwhAdsA3nhOCp0+rPJkOSR4YWDX4P9Tg0
	 shj9OGGVpU7jpd+N2IzMPxinwAHdW1KTF47fZj2PsH6FetO1NLYqUlHwJ4xt8XyS7w4+j
	 geno+hQTtupqYoLTs5NKbephUX4XF8PuTUMZSVquWr0qNmRGIiyo9mCJBE2nNN1Cxpjl6
	 Nuhb6ZuJjFY7WQy/GIoKGZnbQ11BL4IuMMfEhOvCZXe8Dqzl8rswmdyLl+rmgfz+LhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
	b=iqq1B369cRpu6MFHusyjb7Ee8bW1P8g8tb8N+aJLtg12GYgEKbGk/raCIW04ZIk0yk3h
	 BieBo115vdMC5JDaOR+n2+McPO4AOdqzq+Krn6ncjDKxN0AG1iBO1uX/kSaQOFBhXB3Yy
	 2xazToUr6mkwplofq1RzLFHckPCiIeHJ99pxw9CI2Rj08gf/zj7XuWel9ZLFL6phVDfPG
	 rfLpkJDNZ0Y7NVCukShTvByurqY695nF2s/LEgC0PJuwHl/zmPqUSMS7THImuyuS0bmWK
	 5Du0DimSIVtE+ZclmSHezqoaLk7NVYHP84aFVpSfKoQTc9lX9M+eLagmvaF2NHo24HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E3606A322
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 17:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 735E3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc91ddf447so483237137.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793209469; x=1793814269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
        b=iJy5kuJIKEFoVGXIv0G1W+lcBvi4+8Xg3Up72eyRWsM34ppCddP5ilpekezxnMXx54
         wNVtglNWl1Juw56jX8SNwQS7WZKs9Y2X61a375wMFfYgiH4i03Atn7I+ij8S+kLhqtfT
         l07FNZinyoqAk6s+eVtDRNFkKCg8ONt5X560obpxpG2ZC7VnPvjzuP7bhaeVMMRQaZQf
         bnvIZGVN+qVBNlncKqiFZBQ2j+79seozjiyPSZgLY1TuGDnPTDoB10ATDbxfyjixqlJz
         vdOfv2Qybh76j3dxSW1ILlTknOlei2s6oL7+i6Y7LDLEJWeTZKkbkP+obWZ+cP33y8/P
         9s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209469; x=1793814269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
        b=s+GPQPflV3Ko48lx5XwGe2YCN4lK7rLbt8KpCDAnSSAJOyFNgiTSGMX3cklKujWUNl
         oF9uVN/pAdz8j0M0N1CAdl4KtciULDP2y/ItB8o3bc900PeZHeYKk9kMgnEyqOS/HLkX
         j9YlOI73vdfkapi/1Y/UIgFwbkpkFAtphz5pFfYRA0XbfM1R1srjJ8Vcd4E0Xry3r8zW
         26jnyrjIoQatTtuNcYqr44EAV1JimFzHxiEPP8dnC9zllwu9h/bCHrPzuxOWnD7kw0g4
         8YVTN51Oy6NV3RUBJ+AWty2+R4pXCt6miLxuL935ymH2GRDrMkSVlknl6jl3J9UhdbkT
         xkEA==
X-Forwarded-Encrypted: i=1; AKwUvBzwc6G6r4g2PGx6SB0nX2X2ZxpPTLODvVz+zSfeGCUUBHwecrzzI0810ipWnWZ1DDOXvO/VZsHidkHz@vger.kernel.org
X-Gm-Message-State: AFq9FYK4itIyhI76GyX0UDo4guReY1hkiAz7KXNQzAig3yXTZYrak6fs
	uzE5y6oockCoEl0ed9k8kASsEU1Ff2dCaqsODphaUTeZM1mQNt0tbaIfnRDxG123rYQ=
X-Gm-Gg: AYBFou2CC4545IORUr4RBZzTns8NaFeTX6/IWt07QNBho0Od4ljFPjC/rdQI8TauV/3
	re+UVITY5s8ncXakBDbXwRrMAbPHeSZdjeQDM0Rc7ZwnlX785IwWFsb2hRxQ+G/kk1nRHGlS1lK
	vEdSpjHeGpg8XCjGv3DopsJLo9BZ1ASTROOo5S5hWJj0SRlyv5NqDhnZHkLn4riqTvypaGtwiEI
	LITyBgv2rR1zu1GmiWOMYdgV3Ip3jl9XYrVWiK56UcnroWiUwkwNIgtKV3uiO9IJhpUUVtEv0oa
	AERmUk7UdEsxE5rCaNPVSU/QXt95PYJx9PQzQPZjzUhaYMyuSnlJUR3NNnPwgQ11ZMUqCPBxghM
	R5n/S71EuDChO3fcIrv+bwBDfP9AmIvjGSOGnRMYBQoMClbp50smcQdgq7njt7wnkKbBjdSJU8m
	ifhi/u6EX1K9/1rsl4Kko4p+Laf4veKI9qsYIssqnDiOm+Fm540+2WW+jQKY5ofidbtVYABzjIf
	LdSBncmseMIO60z71f5yLzTwxVU+7VHsTS2AfRTGBWkuKn82qOEhkRt4kJLN209dgTutZD0x6T8
	MueTo0LAhuRb4ZDi2IKncs0EP/JytYUbEjCF6HBAUGKvbT66PV9ZQfkQxtvm6+9TxUrdc9XNHH3
	T+ijR+mAFtOhIgt7g/8mSn/y4JeE6MvOK
X-Received: by 2002:a05:6102:3e8d:b0:7a5:7282:1994 with SMTP id ada2fe7eead31-7d03a50a85cmr1269510137.7.1793209468986;
        Wed, 28 Oct 2026 10:44:28 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125931983sm6616412241.2.2026.10.28.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:44:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:44:27 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, 
	seanjc@google.com, will@kernel.org, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auIvjVmWnsVPN_9g@google.com>
References: <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <2vxz8q3hoicx.fsf@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>

On 10-28 18:17, Pratyush Yadav wrote:
> On Mon, Oct 26 2026, David Matlack wrote:
> 
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
> 
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

I agree, and we will discuss versioned vs. owned serialized data 
structures separately. With this series, we establish a common 
framework: size/feature flags and accessors, and we update most of our 
serialized structs to include them. All "shared" structs (e.g., KHO, 
FLB, radix-tree, block_sets, etc.) should have their own versioning.

kho_block_header_ser should have this header. 

Pasha

> 
> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav
