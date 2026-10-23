Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763419;
	b=Rp6FI44eHlXJx1hLW1sToDUkPphzdK/5/+jlh6EHO0ac09n3KONTzL9X5nb6w06eASab
	 knNdi6Zws8sAtPfPVmjX2yOaLSfMY++4WUwevi7njR6aw+KcKu9tWpTKcBOMUYZS3pCIy
	 pWC5UDOv1QhSGf87nQ9e215jHu2vydknfvGhfjtqGKtPPd6YLcgXUhBCtuFqJw20d6z5r
	 ddL40Ad2qNhrVIYjEYQubMnFgHlGzYGHqDyWQjKu6+C0V77LMDhQvBgbg59Jek/76YG6p
	 zSUxiAtSWp839SRRcaKKyhXjGemIdVAVGXnhRjB7AS+/GBh/y5M01c7BgnRoNAiZayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=8FyuJnnll3uJwbR+wT99CVBO9fzREsmjzeqnUECMRTY=;
	b=DHmC/dvTfZu+eydbgKWVFPxYaoDDZ0zJLujlwgBdItHg6Zlmr+OAWZ3zel/H8lSVecmr
	 wN6iQuuTPf1ZsnAI2CHPghfZmp6SQLR5tGLj2ldqkV76UPvSoOwR5FWRaz6yvAqdo4V4D
	 cJM+011Mdm3IQ5ZTdJuqzlcYXpSe1BrGc+Ui7GswCrbG+Yc1AFvMQIpXqhuJF+Mzom7Hn
	 pnTVoIFe8JD3/8Nl1WCIuJegfu4bbKqP0yqbLUoByq8pf31PHa4xJv0mW8NQ51mukMvfL
	 BO8zcNyQk3xRDBVElWl+seGX1cejN+ZURdzRr9rWv3hVh975Bvv1mpucFpzy7Hksluw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tePYhySp;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A9606A31A
	for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2026 13:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007A9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tePYhySp
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so361492a12.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2026 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792763418; x=1793368218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FyuJnnll3uJwbR+wT99CVBO9fzREsmjzeqnUECMRTY=;
        b=tePYhySpUVOPmNC7qMFCyUKUchitL2PPRJngdPKMZb+6YMlbzUwgcreLJ2yA42AZnA
         v8cLSMIlGA3u4RIUYVaES5a8/BGQAUiCR1RaqgsSgZkWKdBE/ZcATVE5Tll8cS9l1X0y
         jUG+yVquGbWgcvm/8MxxycOg/mddw+0l+MplyEJOYfUmLmzlCXrzhSBgacFZkAq8wkob
         Pj6RrEf69ya9zTjuBsqnaaINqezSaQsmRkyRLV8jGDNSGGxqoJhr6jeq4my7fpYC7dyj
         qOmm9rddJ6UF9PtTp9Nx897N1k7lGSJXyujgP0EVLYI9Voi13+8/ttJ+pRcICMcmmMTc
         3lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763418; x=1793368218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8FyuJnnll3uJwbR+wT99CVBO9fzREsmjzeqnUECMRTY=;
        b=rRWaXAVbE2ad7rYv5j3zZvZ6TI9+pINq/rVxrIpv4/4oOsg+APUu7ltmgAI1IEuxTm
         s2tGa/TTZXjfXpQ0cISDPMIjYJFqEJ8JQZ6EN/r6x5k8o5+6jQojsreLWYyLzGVMMJCD
         osvgdg3n2MVzAoBGRMrOqbbeyxuSx5oEy4+J6q90JVQFqhGn9Sg3x3+ATSrCw6X1JioM
         wXviUnK6Q3ne6cuZ23Vwu1UFUuL2PNtDDYnIch9SiWlusaPdfsf/CZYJh41fpJqeNHD9
         nq5IWlod8t8lAun5Oncj6QzyhZB1xHkQY7Jyryg7ImpWgdM46d0a56tohs37z9rrFEmc
         MfqQ==
X-Forwarded-Encrypted: i=1; AKwUvByS/57qZ1HnPLWg+cCQoK2bJBzMrlLmf6X91BV9yuk7QJFwjrrb4z5WnCHC8Z/fzEl+eNg/oNJBNR3/@vger.kernel.org
X-Gm-Message-State: AFq9FYKqGRQlAZl/THtRT+3yimJcwbV6tDY4/AKDKQjWO68ELrR+rxqq
	b6bEZV8Bfsy56EDVa05Wwhw4u34s6IdxPtsjMx1bZnFLWIdnKJo+tMwizy3WPn/V7w==
X-Gm-Gg: AYBFou2gBix6U4Cje59efb7v/gPWGfU1qWVW1jHjXTre/MdB6Ryxg65DQ1eCVm9EVyE
	xWnCYRCYzyvFpUqouDH31Dh87mBgmyOVQL8E+OoSdhcIntN+DqPux0mENcXkIWvjmxWgsKlY04i
	tQBVLkbeVI0BNB0ZJXgwxwi8UVPhSAqpM/SS0w3xJuHXmGITS6NVJH77ugpRySBzSO6A/xfUh+l
	YM2cx97mCMKV6B3hACjCiH5JTu4YmGiOPG9cEd/LbAU/r4gERmW0FRerXffeZU6cvT75QDoHgll
	6qk5/Ssz4G0UBRb9fZ1OBYjllQ/pKti2IAoC1cmHeCaxLbQrLBuJ0hWRCIJzsBlgWHS6EA7zrTm
	ISUWpicglqgX2klVn9tXmuW5owYmraq2C72HtReZD3UsHqNALOJwV+EbuBz/fn5HrJZqPwZlHKQ
	B/dBYgzcBMs6MsgV/kClqvc9nzoED3eNHep1z9LwJY03EKe0L1hOtssNxC1a7orxlYM3grvsbn2
	y/rOd9DX9bbdyb7ZSyhKdwr65wA9VflYcFbByLnimbzLKS/0Rl3cnRVcQkl+xhm+4RUTnO5DpkE
	zebq5bRNF9wLFdg7gm5+uUQtw9jD/Psvc55qDQ==
X-Received: by 2002:a17:90b:5906:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3adce0073a2mr1983207a91.29.1792763417701;
        Fri, 23 Oct 2026 06:50:17 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea94677c91sm545015ad.4.2026.10.23.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:50:16 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:50:13 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <attmFVIFU_mS0Y7p@google.com>
References: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
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
In-Reply-To: <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>

On 2026-10-22 04:53 PM, Pasha Tatashin wrote:
> On Thu, Oct 22, 2026 at 1:51 PM David Matlack <dmatlack@google.com> wrote:
> > On 2026-10-22 12:11 AM, Pasha Tatashin wrote:

> > > Lets drop the fourth macro argument and generate the combined struct name:
> > >
> > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)              \
> > >     struct name##_hdr {                                                    \
> > >         __u32 size;                                                        \
> > >         __u32 flags;                                                       \
> > >         __u64 ext_flags[ext_flags_count];                                  \
> > >         struct name payload;                                               \
> > >     };                                                                     \
> > >     static_assert(sizeof(struct name##_hdr) == (expected_size),            \
> > >                   "LUO struct " #name " size mismatch!")
> > >
> > > For example:
> > >
> > > struct luo_memfd_ser {
> > >     __u64 pos;
> > >     __u64 size;
> > > };
> > >
> > > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
> >
> > I think we are getting close, bu I have two remaining concerns:
> >
> >  * Reserving bits in each flags word for continuation leaves gaps
> >    in the flag space that users have to know to skip.
> 
> Yes, but callers should never manipulate the raw flag words directly,
> and we can provide simple accessor macros or inlines that take a
> contiguous feature ID (0, 1, 2, ...)
> 
> enum luo_memfd_feats {
>     LUO_MEMFD_FEAT_HUGETLB = 0,
>     LUO_MEMFD_FEAT_SEALS   = 1,
>     /* ... */
>     LUO_MEMFD_FEAT_FOO     = 15, /* Automatically lands in
> ext_flags[0] bits 0:1 */
>     LUO_MEMFD_NR_FEATS
> };
> 
> if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
>     /* handle hugetlb */
> }

Sure but why deal with all the complexity just to save 8 bytes? All of
these structs are allocated on folios and there are kilobytes of unused
space to fit this header. And even if we optimize that we are talking
about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
sub-structs like the KVM ones.

> >  * struct name##_hdr only matches structs written by the current kernel
> >    (in terms of length of array and offset of payload).
> 
> This is not an issue on the incoming path, we never cast incoming data
> to struct name##_hdr or access ->payload directly. Instead, we parse
> the incoming buffer, dynamically compute the header size from the
> continuation bits, and cast the payload offset to "struct name *"
> based on the negotiated feature flags.

How?

This is the only data structure that describes the header. Are you
saying the incoming path will parse the header purely with a void *? Or
use this header but just be careful not to access payload?

We should have one header structure that can be used on the incoming and
outgoing path. We should not have one header data structure that can be
used on the outgoing path and one that can be used on the incoming
path.

Also we need a standard header that can be shared across all structs,
not a per struct header. Otherwise you will need to do weird casting and
overlays to implement the shared helper routines that parse it.

> > How about this instead:
> >
> > struct luo_ser_hdr {
> >     __u32 size;        /* Size of header + payload in bytes */
> >     __u32 nr_flags;    /* Number of features encoded in flags[] */
> >     __u64 flags[];
> > };
> >
> > Each feature occupies 2 bits of flags[], so feature N is always bits
> > [2N+1:2N] of flags[N / 32], with no gaps:
> >
> >   00: Feature not present
> >   01: Feature present, safe to ignore if not supported
> >   11: Feature present, must be supported by the next kernel
> >   10: Invalid
> >
> > The length of flags[] and the header size are computed directly rather
> > than by walking continuation bits:
> >
> > static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
> > {
> >     return DIV_ROUND_UP(hdr->nr_flags, 32);
> > }
> >
> > static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
> > {
> >     return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
> > }
> >
> > static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> > {
> >     return (void *)hdr + luo_ser_hdr_size(hdr);
> > }
> >
> > and bounds checking is just luo_ser_hdr_size(hdr) <= hdr->size. The
> > payload is always 8-byte aligned.
> >
> > Payload structs are then declared on their own, with no header:
> >
> > struct luo_memfd_ser {
> >     __u64 pos;
> >     __u64 size;
> > };
> > LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);
> >
> > The static_assert covers the payload to catch embedded structs changing
> > size.  Asserting the header doesn't add anything since its size varies
> > by kernel. And because flags[] is a flexible array, the header can't be
> > embedded in front of a payload in a combined struct; it can only be
> > reached through luo_ser_payload().
> >
> > I think the only downside is that the header increases to 16-bytes when
> > there is at least 1 flag. But I don't think we need to be so concerned
> > about an 8 byte difference...
> 
> I would prefer to keep the default header at 8 bytes. With 15 features
> fitting directly inside the base __u32 flags word, adding the first 15
> features to a struct keeps the header at 8 bytes and does not shift
> the payload.
> 
> Computation-wise it is also very similar: for the 99% of structs that
> have <= 15 features, LUO_FLAGS_CONT is 0, so computing the header size
> is just a single bit test with no loop. Even if a struct ever needs
> ext_flags, the loop will walk at most one or two extra words.

Please explain why it is so important to keep the header 8 bytes that we
have to jump through all these hoops to map a contiguous flag space
onto a u32 + u64[] array structure where certain bits are reserved and
have to be skipped.
