Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634736;
	b=PvFwb1hhxaSG/ZQngrz2CG1/CRd2iS2BrJb8Gi/mMVGu8fHFUTLRQvc0uZm+3OyM4Uc/
	 qdwVY9njDzq80UT8h/txRP6ryvAZTBm4JLy1X3JKpjwGUkdQ7TNV832ohsIMw7lF2adJF
	 6/UXVw567Mi6vNTUSYsEKP8DiokGmoJwC32/KOnRLj1ojGXUxGZS5zuCRcRhBzQxffWW2
	 HlHDKWU7x4pV8I1OxXlIscri9iLaJ0aMZGJlrU91HyxBdbchHoMw2RItfACVnAJh+ehLx
	 MUJQhi4fgRSnMHHtRtRkQxAAQhVGuFAH3bLpbTBFKZjhMWcdHgs2KJpWjesuD6+9Nng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=j6RtsTbIlQ1+MerKC0xhFDG/d459vnICRyJwyVtriLE=;
	b=cbM4xJVMw7ClyxT7UrJq0n0SyfqnxwZ2I9p+ud1klbNK2TpI+tLsUjanIuC45hXUc2i5
	 HMZWxaaOD1srUC8EY9V2p6IYBt1iurw+fTYm01xo1x+yMNi4GAKwI+jYCP0sDuiSccY5g
	 qtLWjgoN4kectcOWKl8cRszuNsN1qw4WBVLqwoIe233XiGAj6g+FzKMdgTgEstqB9xckE
	 8VLe5+tNCFfT6Nj6CbHtZ3bBi9IG4wi9FfYMH8XBWBLL4XYg/hRbaz1Vv/TAdvRHR6u04
	 KnDFVnRRcY5z+vTd1bgQq0JQQ63qpwaRTjFxsxSHKLaFnERkewgkFvvcGhHSea3g+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BHPvzdIU;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6988606A333
	for <linux-arch@vger.kernel.org>; Mon,  2 Nov 2026 15:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6988606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BHPvzdIU
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so1330747a12.0
        for <linux-arch@vger.kernel.org>; Mon, 02 Nov 2026 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793634734; x=1794239534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j6RtsTbIlQ1+MerKC0xhFDG/d459vnICRyJwyVtriLE=;
        b=BHPvzdIUTfLewJrYkQH7AM5ACZXWMySrmwNdCiSs5e6SI86mj4u2FQFZ7r+Sb1n78o
         gc7efW8JFDUlvS0IFhI4lySJQ+geqabqJd3Q5I7XQAl3Y3/Yw/+TdJ8ntmwzO5rfOTpG
         PoKQ8nTXisY9CAUjnrWbqf8y6JSz5U9KT5YbVXJcpFQQX4bZ54DVJBvod155mno//Klr
         K4qF7GT6YqPFEocNq77QalEX6VfNP+5OPCh9Rl51yPooTkxLTI41oszKeo9V3be0MCxE
         125q2mUMZMjjNDHFbTMTsuMzt+8SAccC+vqPIehEIlLY04xwwd9hOUGvIAqgUWFvNJVv
         m9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634734; x=1794239534;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6RtsTbIlQ1+MerKC0xhFDG/d459vnICRyJwyVtriLE=;
        b=EP53EsI0p/3ZOgeo3FL/r0MoxZjr9h5doc0ifOF6vaCXlSboo1u2ExO9OX5pDjoHnj
         RmEgv5d6Ry8rxuBu1dUNQYaPQXIwBeWZBG8HviZNOqg4P7ulkNDx+WVujzwrQ56VVwHD
         mU0/EHU/cZBMb/huykmQ6r/dPKsj+d4DqEqsy8bmkw21+emAh8x7iclKuvx6v+sZ4fPo
         RO1EXianEHWK1e5CsF3YB34ts5H6uJvIDBb70VZuZCZrVholzTrn+SDQAo0x5PLxgtTJ
         RXBu07CqRDckEcjgUpsxyoE+T9M3A3VXvXBdBOR42u5JOAfLMPaqX2t/5yQQ6pqcCbis
         E04Q==
X-Forwarded-Encrypted: i=1; AKwUvByqDFOzvm+8nt9Uk923pi+kink4cQ9s7FULVMPcX7NbtQGRhj5HSmilvfXxe+JEJsgDBWtUTUZmOod3@vger.kernel.org
X-Gm-Message-State: APuU4Z8NmOSfJVt5FDk5ZV0hMEvXzZaqbQAO+OdYNwUzA6idYQRQoLZl
	uJ2+IcAtcQaHFnzjwR01Xoc7UMmRfMi12HRNmGadWVTyVZONNpPbzgDaJqf84JURB2cZYr2SI8/
	D6z98ewybS+YdKTtkeA==
X-Received: from edwr13.prod.google.com ([2002:a05:6402:34d:b0:6ac:bd6a:1c30])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cc09:0:b0:6ac:7737:e50d with SMTP id 4fb4d7f45d1cf-6b4d4d83eb2mr5865537a12.29.1793634733847;
 Mon, 02 Nov 2026 07:52:13 -0800 (PST)
Date: Mon, 02 Nov 2026 15:52:12 +0000
In-Reply-To: <auI02M-pZO_aQ4jn@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
 <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com> <auI02M-pZO_aQ4jn@google.com>
Message-ID: <9huzik2fz0wj.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, jgg@nvidia.com, 
	robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, 
	pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> On 10-28 10:24, David Matlack wrote:
>> On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel=
.org> wrote:
>> >
>> > On Mon, Oct 26 2026, David Matlack wrote:
>> >
>> > > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
>> > >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@goo=
gle.com> wrote:
>> > >
>> > [...]
>> > >> The reason I care about keeping the header compact is that we are
>> > >> defining a foundational kernel ABI and want to use this header acro=
ss
>> > >> almost every serialized data structure so we can evolve them later
>> > >> without breaking compatibility. While some top-level structs are on
>> > >> sparse folios today, other serialized structs are tightly packed, a=
nd
>> > >> we are looking to add KHO slab support in the future where tightly
>> > >> packed allocations will be common.
>> > >
>> > > My intuition is we will have a small number of headers per preserved
>> > > file and per preserved FLB. One for the top-level struct and then
>> > > optionally a few more for sub-structs like arch-specific data. That =
is
>> > > why I am less worried 8 bytes per header, even if we fix the folio
>> > > problem.
>> > >
>> > > Maybe where our visions differ is when there are collections of
>> > > serialized structs, like KHO blocks. For collections I don't think t=
he
>> > > elements will each have their own headers. Otherwise the elements co=
uld
>> > > be different sizes.
>> >
>> > kho_block today doesn't store entry_size in the serialized payload. It
>> > relies on its caller to do so. With extensible structures, this can ge=
t
>> > messy. Sure, the owner of the kho_block_set can track the size somewhe=
re
>> > in its payload, but perhaps we should store the size in
>> > kho_block_header_ser to begin with?
>>=20
>> +1000
>>=20
>> KHO block should track the entry size automatically and not rely on
>> the caller. Otherwise every caller is going to have to store the entry
>> size in the struct that owns the KHO block, like I had to do in the
>> PCI v10 series :(
>
> I am fine with updating this as part of the versioning change so that we=
=20
> do not have to do it twice.
>
> Tarun, could you pelase include entry size change into the next version a=
s=20
> well?

Yes, This will be important to track the extensible serialized structure
across kernel. For example struct luo_session_ser has larger size in N+1
kernel which gets deserialized on the beginning of the boot so incoming
block_set must use entry_size of the kernel N which we can update inside
kho_block_set_restore(). And this updated incoming->block_set be used
for iterator in luo_session_deserialize to properly walk through
session_ser entries.

I will send v4 soon including this.

~Tarun

>
> Thanks,
> Pasha
>
>>=20
>> > Anyway, not a problem this series needs to solve, but something we
>> > should eventually do.
