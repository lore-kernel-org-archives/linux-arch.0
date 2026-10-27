Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059281;
	b=Dn/5Xy6G8bQl8swdXP/gzIF0a7MaAYoRMXG0GXKDjGZQir2oVqwDhrJZUhW51FHZE6+I
	 fqjkHQnsAJdig97KXU+2ubhytN/q51AEyX2ORju/rEY+YYUTxhM/VYLEBxz1O0g+GLm7w
	 zgZhD56cbzhukDHKzTDV8cQDni03DqcGMT3W3/5d/i885wWuvPgQN2sdMzz8w56zxAh3N
	 oKL8AqbMnGxJdJju+RFZy8UA+noDvJgNZ6a+lis2AJJGAApHKYXlBzY7NBYKAwRNOWRs1
	 AQhrGCK6xcssiE/1Derh74re62+QKy4aj1ut+2vUwBPHWmlZnJymDolHZjpVJE4XR4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ixKouDoUlCLHB71PytJx4w1v0AUAxSqI48/quFxSDg4=;
	b=Pr4gyuuOKel5icy0Uz7xyFXSZXmt8wWeRAaQMfPLCD49CCwXLInF9OkRe7p9suDjyPma
	 zvT7mN5H96yXNOVfRwrpgza2R4Zux6Jt22vVDu94UfJx4Tn9ps3EAiIEBmreYdcgjrGYt
	 VIYug57pXyfCBl8Nx0Air0icTFnv+TDImegOiuoDNP5OUOFaAjvMjI0aBYb40sj78QO/q
	 JX/5S4kUDXuLzj945ZnzuqZsAlO5wVEUWnU6pr92B9Or1eBeuCiD7X7uLTohgSFdAAOIy
	 PQQpYtrqiP4DFs7Hxgv+x6X75f+2TVsS2MXF+KFwGhc+yZ5+m6gMwcF3znZnTaRs6Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y7rRSLa+;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA7606A31F
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 00:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3CA7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y7rRSLa+
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e812e2b31bso21267655ad.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793059280; x=1793664080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixKouDoUlCLHB71PytJx4w1v0AUAxSqI48/quFxSDg4=;
        b=Y7rRSLa+r3RxhoSoO5PKClqNGCT6jKuoILUdAyOjrBpIDh7kUFYmgiVqS8gY1r4d5k
         9DHu7H8Ko9bJ3ecF7KmcPNXMtf7+nfFx3FpxAx9vlbHDn2PmeRgH+4zWCScjqtvdd5XE
         zeqLRBecPuTUklO6miOjNQZhg89cuFNqhRyWEKnVgnX8o8J7IHE1/Bt3GuBmsQ2iNgkm
         SZJsbukQV29TFg0bsUxCyzF7KdhcQ+LK0E5h/46+GtjXPTumnS0vF8fqpLHg11n3uLud
         plrOm9I/PQxoxdcJvK4CMp4Jzdyih0RYPGf1ARU5NIPwGR7rOeWrq72UcdCGlUzIYpVy
         KErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793059280; x=1793664080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixKouDoUlCLHB71PytJx4w1v0AUAxSqI48/quFxSDg4=;
        b=ZrKXRgN0lRrlbO8Bryut5dqCTtYmqSddgW3JtoSTKJ+vwYEQ6QJKHX0DxoAqW4VmoF
         NNT4F2IyRlceVBL3nyl3YEz18ucMWDCgLM2yRD0DsQjfGPw1EuG1bFMrYWRcPR9LofPj
         g4pqRNAUJhyUDg4LDVk07SdRTMXe/Jrl/9GKLeeolJt7XiA3TgXIVUGMcLVqvU+4+pb5
         Rmp5JWjqr/wzNxQcHUS4AAOxoSnDDdOssJIY1DfhTml9ZgUxp4GUVFeYaZRs5Y72lDt2
         fr+dwuR1DYpmvMaLKkBPjx6M6Uil1PVXzdr86kNAO9VLPkDcdHCp3j8aR8BxMeSNaYYq
         2jkg==
X-Forwarded-Encrypted: i=1; AKwUvBxKYwrDscnoqLvx7xsEGvN7DFUVlUafkNujV2FC1mWhay3SSC34NW4QXsNiyjN624I80/ssL2zDU3Mh@vger.kernel.org
X-Gm-Message-State: AFq9FYKpU5pgRlw43JLmxDDcYAomX725Yru9ZItSi6DC6LNKB4Nrz8lA
	ruThQJ87STa7Um5Erm8SIy6lzIgO7GHhGDPmBCDUq7ZWsilyZb8YvHoShAUd6qkUng==
X-Gm-Gg: AYBFou3bb9BCEVD9TTjZJxg++J9fhKAqyDgdwkamaGaC4qNUkYc6HpoixzZUQLoQMB6
	I7d1DamjbIbgfDNPyLeoPfCh+04mun0x9/wDQ14Vmhc94pLZYP5DkDvJHCP3Yp0gFfJhLspLAIK
	SR8UOVC6AuOBdsu5m5P9SZTEbM/vMLKWRY2j+Y8cP3idaLaT4bCLrMK0i7iq1Pl4tozBKMuwkfQ
	wLmD3KZH5ZyMIUJXUAGaBSAQZwadpES/JeTlsTSU0Zer67QnVJv8ckcuuxUCRTpWfuf6xb6A25S
	bR0kwffcgRvgu7IbctWzYlKlzfQHSMs5/UhBYgOJ60rdomQvcEvj06CZr20M3nnUdzTeUjzsf6P
	VeX8y0xGwN03yoLmohflUU6bNJmmsW/wmZsu2x76wQ1F7buEH53zZk3LJ2XHBuFCU7THTSEdGrj
	yfHlF4AKxrtxdLoqGNLLZ7QqKLspq9fbGQy43DCtdou9of2zWOY49SQwFU1YlJI74+w0NkraG6S
	XWt5Dag+qLXRs+ZGrKkDYNFfnae+54LjXs+yCCY4n5r+rb5dZwLGJChOtVPyZRIGtTNaDnKyOb7
	eFrxuxpdoQuSLdgF+wUJKyJtEYR8nw6HfP+RK4ccZ2qcYrXGTVRtma3pTeUH8SZ/zjIOjlg=
X-Received: by 2002:a17:90b:528c:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3adead444ecmr7102022a91.10.1793059274755;
        Mon, 26 Oct 2026 17:01:14 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066cf2dsm1119900a91.16.2026.10.26.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 17:01:14 -0700 (PDT)
Date: Tue, 27 Oct 2026 00:01:10 +0000
From: David Matlack <dmatlack@google.com>
To: tarunsahu@google.com
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
Message-ID: <at_pxoULR1Tp5anN@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com>
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
In-Reply-To: <9huzecdcghxu.fsf@tarunix.c.googlers.com>

On 2026-10-26 11:28 PM, tarunsahu@google.com wrote:
> David Matlack <dmatlack@google.com> writes:

> > But looking at this again, I think the required bit is redundant. Whether
> > a feature can be safely ignored is a property of the feature itself, not
> > of any particular file. Every file that has a feature present will have
> > the same required bit for it. The only thing that actually varies per
> > file is whether the feature is present.
> 
> The required bit is subsystem property not the per-file. e.g. memfd_luo,
> it is set at compile time for a kernel. So every file will get that required
> bit set. It is not per file property.
> 
> struct u8 memfd_luo_feature_state {
>        [MEMFD_LUO_CORE_FEATURE] = LUO_FEATURE_REQUIRED
> }

Right, whether a feature is required is a static property of the
feature.  That's exactly why it's redundant to send it in every header.

> > The required bit still has to be conveyed to the target somehow, since
> > the kernel that needs it is the one that doesn't know about the feature.
> > But it can be conveyed by the feature's number rather than an extra bit:
> > split the flag space into required features and optional features, and
> > assign each feature to one of them when it is defined. This is similar
> > to the required_flags and optional_flags approach in struct pci_ser [1].
> >
> > Keeping the same header shape as discussed with Pasha:
> >
> > struct kho_ser_hdr {
> >     __u32 size;           /* Size of header + payload in bytes */
> >     __u16 nr_required;    /* Number of required feature bits */
> >     __u16 nr_optional;    /* Number of optional feature bits */
> >     __u64 flags[];        /* Required bits, followed by optional bits */
> > };
> >
> > Required feature N is bit N of flags[], and optional feature N is bit
> > nr_required + N (using nr_required from the incoming header). The length
> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> > are numbered contiguously, so there are no gaps, and up to 64 features
> > still fit in a 16-byte header.
> >
> > Each bit just means the feature is present, so the truth table becomes:
> >
> > Source bit       Target supports  Action
> > ---------------  ---------------  ------------------------------
> > Not set          -                Accept: feature absent
> > Optional set     No               Accept: ignore the feature data
> > Optional set     Yes              Accept: use the feature data
> > Required set     No               Reject: -EOPNOTSUPP
> > Required set     Yes              Accept: use the feature data
> >
> > There is no invalid encoding left to check.
> 
> 
> IIUC, I believe this will not work.
> 
> To Communicate between source and target, We are defining a protocol, A
> protocol which will be standard for all the kernel. And each bit location in
> flags must have the same meaning in both the source and target kernel.
> 
> Now in you approach, If Source kernel send feature N to target kernel,
> target kernel must understand Nth bit as the same feature. Even though
> the bit position in your approach is not fixed but they are fixed
> relative to their starting point.

I think you misunderstood the proposal. I'm not proposing to pack only
the set bits, and I'm not proposing that each feature have a bit in both
ranges.

In my proposal, there is no such thing as "feature N", there is
"required feature N" and "optional feature N".  Required feature N can
be found at bit position flags[N]. Optional feature N can be found at
flags[nr_required + N].

In more detail:

 - Each feature is defined as either required or optional, once, when
   the feature is added. That choice is permanent.

 - Each feature gets exactly one bit, in its range, and that bit is
   always at the same position whether or not it is set. Required
   feature N is bit N. Optional feature N is bit nr_required + N.

 - nr_required and nr_optional are the number of features of each kind
   the source kernel knows about, not the number of bits set. They tell
   the target where the optional range starts and how long flags[] is.

 - A set bit means the feature is present in this file's payload. A clear
   bit means it is absent.

 - There is no invalid or reserved encoding to define. Each bit just
   means "present".

 - The target doesn't need a supported table. Required features are only
   ever appended, so it rejects any required bit at or beyond its own
   MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
   just checks the ones it knows about.

> For the current appraoch and V3 [2]. Think the below one as msb is
> required bit and lsb is feature present in payload bit.
> 
> 00  FEATURE_ABSENT / DEPRECATED
> 01  FEATURE_OPTIONAL
> 11  FEATURE_REQUIRED
> 10  IS INVALID (analogy: required set but feature is not present) which can
> have different meaning in future if in future, a need arises to reuse this
> field.

In v3, 0b10 is reserved and not checked by the target. That means an
older kernel will silently accept it, so the only meaning it could ever
safely take on is "safe to ignore", which is what 0b01 already means.
A reserved encoding is only useful if older kernels reject it, and at
that point it's no different from adding a new required feature.

> Deserialization can happen per feature from right to left. without
> jumping back and forth.
> 
> Because of all these reasons, I believe current approach presented in
> V3 [2] is the better. It is close to your PCI series with two flags
> field for required and optional except I combined both field into one
> flags. In your above approach you do have two counts but not having gaps
> (which is wrong) and the way you proposed to parse with an offset is different.
