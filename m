Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637867;
	b=upLAHMIZWM3JOGzFVLCWiFgAe8Lc2N7w0TaPAFT0CV91jqI4ORNr8PbJRBxHFsSN3O/H
	 djyh7/CK7+tCFuLxFoHun0eoRVs1JE9SE9wEPlRCgY6ixiJMk6yjkEunrum01PqsZPvUx
	 S+02iQIZeb8fIIBi99YiE6qnJiPOcN/BqRXuAAVhkPTRnazvoZKA8Fqf8zoRXasWt0qLL
	 75MfWivYznbC/PPuvubZGvPKYAmstRipa8mHUT227LcmRPRYqWYPApTK7JLkqT7aZDsiH
	 a5txRKrP38DASGs+6Zrt74HVZ7Yy/Uf8LwHm6VYG3YS12LDGRqHrvFfswJ5IU2Fmo+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
	b=C2aFqiYzKlhN2Z8ugX3l93K+rQDEt6EiLx6HPf2LoJGVUuZ3Deq6TVraWrq36aCBTB+r
	 FgNzYrHWKpDCLeekcYrYauoS0Zvt6HnVok8udHeFNsKhq9rwVvcIgrAkx/SXVad73KSfS
	 gvsOYCaAcYwMGSD20+yybkejJecaLtT/nP60zIbTeN5EnwMxMQbPD5LEbzFfcxdkkn1mH
	 XREMSrzz/Agke270oXuNO6oQc3gZO535568GAYlx2yHGsFg6v8VQntFUpF0/1q1Y8jwsk
	 k9f///uKsFB4OOsy06HHd2VeFTYC3oljvdTBIUj94QH+F/E8NTBo/DHETnteUbC1BGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRoWI2O9;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C4606A31D
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 02:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRoWI2O9
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so534383a12.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792637866; x=1793242666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
        b=dRoWI2O9b4O92k+WOpxwi565DGBEPYlPq0ghfq07r2y3WRvZEDPJ7i0ROgbY6wUSuS
         AdNT2jZT04waQarxGzpsFOkuGkcLz6ztwEZzLkyCgXet2o61a5dXghq9VTZ92NNNcMrf
         /+LGCpmWuIP1Aagyq4YfMSLq+WSt92yoZPw+QaI762w393JWkg6u8G3V17ksbFYBBVzI
         gHiGvVlcABlRMpDhSMkjjrVx/XmdpP/fklOi0VmZNnNnWKpmuvwaR2vQUOrwKNF2oWcT
         QYXdnfSlN1Fdfqf3CrBxt7gsbSBeCL3AcwfNBYU/Go70bECwqrn8/zbZOHnb2Tq4F2CH
         jQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637866; x=1793242666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
        b=ZdqoUuHDBoZGjtjpneV6xIatOUJz5RX2UGuLir4V+3bLkwZIR8U34Tgr61USfDKgNw
         tWHeaYgdceSWdJ1WoRmYNHF/t+QDgdjlqbjuhTa7LOXOb4OQfjyiccoERMmExZZSZfWK
         SgHlxQsU/mxVU4IdN5AFcjJlF8kDJOFK8Gs2tGoVvOmV4KMr7FR2+Vk6Af82MA8UFNf4
         j3xC4njy4oFBk+7ZtW01KJypxNJx3zmth4/UmAeoBJN1FS8XrFY/HzVTXPcjm6IC+TWR
         fJ0W0ECgreJAR2Pjys6ww6IIdJhxP43pps8Y1XPXWu6RyT13ytMo/cCsjpjVE5D8p6f7
         79jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBYv7VfI/UpX9hhimIjce5aeA7FTLZp9dHvnsO/+iL93u2buGxDqLqiQyy+Pos8QhsWd8cqz/+9GW+@vger.kernel.org
X-Gm-Message-State: AFq9FYLEbpCMIHPa7wV6OWpzA2UJiZgGT7xc7AlknhCQvosPGaP4GGsz
	MNE62zzCYrGBbkHG+V4Veh4eSl/h67Fo5fLHxg4MPuAuaqlrAIEYJIOmo7EhIjpuMQ==
X-Gm-Gg: AYBFou0I0aCOB2QAH9bkZYz/+9Sv9ezykU0N6WB49x/X6d4zdiAkDrbqUQP6TpWxXKe
	upqqmLBkTx8JkyR8KnFYZTpVFRKO2z93JcVuNBMIg5o6EK8EgH4u9v30YF5P7t57WulKCH6+Vrr
	KBR6cJP9DhMzCK3z3/cvmtNYVkn9J6dGJVd274g8J0iwspskyVFtZ4lJYlW7x9U3igznOkpePwQ
	0hnUPZ2bqdAaQSB/OUUVJ0N/96xjzvnxTf9iW2dJZ3EPJRcKsr5Lfk9CT4wLbbaPmp04PFgaytr
	A68JokXpXnjOfk9PhvhTJlETwFatLqacXNFrXfG8NqrJoS6ONNYUIP25Q8hySUEBZ6fvffghUax
	fohotnQeb/0IXj9v3SHyFf0nFH27nGR3KNsIR6F8ugLM3OcXS0pwuSuv3GrttLbxLin9AXkJDR/
	LBC6cP+KKlIPjW1kuS0R8DPWPrrJ2IfOcbfchXgFmWhB0+cm0dz7zkYjehmNpMql18rH35LCU/M
	Df8w3WnFfarW+KU+Y95fxcMsDnSHKEjbLik7ljbLTQKe5zNfZ4kVBQ4sCfZXJ13pJDyt44YotcP
	YiAvF8SfKIvCOh6a
X-Received: by 2002:a17:90b:3ec8:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3ad86e96c9emr2886416a91.22.1792637865925;
        Wed, 21 Oct 2026 19:57:45 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada495315dsm2092370a91.15.2026.10.21.19.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:57:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 02:57:41 +0000
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
Message-ID: <atl7peoVHdP5hz7z@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
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
In-Reply-To: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>

On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 7:28 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > On Wed, Oct 21, 2026 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
> > > >
> > > > On Wed, Oct 21, 2026 at 11:40 AM <tarunsahu@google.com> wrote:
> > > > >
> > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > >
> > > > > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > > > >>
> > > > > >> LUO and its file handlers validate handed-over state with monolithic
> > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> > > > > >> structure, even an optional additive one, must bump the string, which
> > > > > >> breaks live update between adjacent kernels. Replace the string in
> > > > > >> struct luo_ser with a feature header, so that the target kernel can
> > > > > >> accept or reject the source kernel state per feature.
> > > > > >>
> > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > > > > >
> > > > > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > > > > struct, we only need 8 bytes instead.
> > > > >
> > > > > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > > > > over-engineering.
> > >
> > > 128-byte per serialized struct is not starter.
> > >
> > > > >
> > > > > >
> > > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > > > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > > > > bits of the flags indicate whether an extended flags field is present.
> > > > > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > > > > that yet another extended flags field follows.
> > > > >
> > > > > If we will have dynamic extension of flags, Think about this.
> > > >
> > > > To support dynamic extensions in a backward compatible way you want
> > > > something like this:
> > > >
> > > > struct luo_feature_hdr {
> > > >    size
> > > >    flags
> > >
> > > __u32 size
> > > __u32 flags
> > >
> > > >    extensions  // offset of first luo_feature_extensions (or 0)
> > >
> > > __u64 extensions[0]  --> but the size should be specificed in
> > > declaration macro that I showed in the next patch.
> >
> > I think you may have misunderstood what I meant. In my proposal,
> > extensions is an offset to the first extension, not an array of
> > extensions that immediately follow the header.
> >
> > If the extensions immediately follow the header, then the number of
> > extensions is baked into the struct layout. Every field after them sits
> > at an offset that depends on how many extensions there are. If we ever
> > need one more extension, all the fields shift and old and new kernels
> > can no longer read each other's struct. That is the problem Tarun
> 
> We can structure it cleanly by nesting the payload: something like
> struct { struct header {...}h; struct serialize_data { ... }p; };
> That way, the header can expand dynamically at the front, while all
> fields inside `serialize_data` stay at fixed offsets relative to the
> start
> of the payload.
> 
> Since the header size is self-describing via continuation bits (e.g.,
> the last two bits indicating whether another flag word follows), LUO
> can
> easily compute where the payload begins in the incoming blob. This
> keeps the implementation simple, avoids linked lists of offsets.

Oh interesting. I agree a dynamically sized header at the front can work
and is simpler than a linked list.

So the header and the payload need to be separate, and the payload is
located with pointer arithmetic on the header. For example:

struct luo_ser_hdr {
    u32 size;    /* Size of the payload in bytes */
    u32 flags;    /* Bits [31:30] indicate an extension word follows */
    /* u64 extension words follow while the continuation bits are set */
};

/* Size of the header, including any extension words. */
size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);

static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
{
    return (void *)hdr + luo_ser_hdr_size(hdr);
}

On preserve:

    hdr = kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(*ser));
    luo_ser_hdr_init(hdr, sizeof(*ser), ...);
    ser = luo_ser_payload(hdr);
    ...
    args->serialized_data = virt_to_phys(hdr);

On retrieve:

    hdr = phys_to_virt(args->serialized_data);
    err = luo_ser_hdr_validate(hdr, ...);
    if (err)
        return err;

    ser = luo_ser_payload(hdr);

What would size mean in luo_ser_hdr? The size of the payload or the size
of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
maybe it's just the size of the payload?
