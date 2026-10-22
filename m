Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792627492;
	b=eQDlWy5dDpMj8X2QZAfr14kbNvNmRTnELuXmgBKWHzl5wMa/tfWhr+YUSxKOoIRDhRbx
	 W+lqXR0ClFhQgoUQe0JYdqu3ajtXKStKA37L4QdqIbhA1yVUaN5X72llP37y8RMLfSVLd
	 IyELz4VdXKL4LC/PHECrzUhtlfq9GJbXYTDIZmrf6wfKXUpdEJso7VlgoG3xASAdmVaki
	 gfSR+zx4GJxLeWvLd8VnYq2j+jvWk71Skt7iXzX6BpAFPzYRqeinwKhjdYRfHg5GqG0/w
	 6bPiUufGsk6yco1n1bZH8zSFVXlbqkwg+krXyoDEtTOow6nSQOp27FTS9PlaW2BMkig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
	b=tLllW5J419ULAf+hAZ75JlboaNt+tZRIIzie4+eIsMjABPCrCdppkuK7oCIfWCKgME1d
	 TPeFAS7Qe4vyJlNOijHO/geqEmagnjwbh+YjXfUciJD3EuoBO+Hz/kXObz7Sv9VBX0is7
	 bebEh+I4GIFFme/46nhCOjit7faKfhTNk6GbulWBmXAtAEij28vECmxOIbl/sRWwPFveW
	 cGWyEjyjBC3lQdIzN7F2M8U+9+3/gj2uZx0cb65BsgwM678ykW5KDpVaNmgn2zoduS41q
	 th+NGdGC5Isty/U7ZJ3eO6hrRFbOicIKQ7QRCiwnaHJrHMHbi0Yp00w/Hsa3E7DmrSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="r5/dMExZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE3606A31A
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 00:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76DE3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r5/dMExZ
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so182000566b.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792627491; cv=none;
        d=google.com; s=arc-20260327;
        b=CgdrMQXPT6JJXedmxQtWRbii++ZhTjSALnE+f5BKpaQec/ed1/Hi6/OIRlyeM+vslT
         DNahg7GKeltCit7zThFhS+7rnlwCb+vZCymrGYAPlR9Bbf6525wqoAAV6xreMaaBfUE8
         dBLUKF/v+m1/KvomjyMoLABWWR2u/ePyhpkdqRrNCiRpCxd6ZycLWC+0wxuclE/PQliz
         7d0RN0mJOmnUZnVvQxiF/qGXn92hhfdeNIxl5h4cLDmjdD9cmLSIoxn/xlU19/dkzsjK
         nIeYENodVvVpQqMJmAWZTSaScsX9bsOtC06kW4T5qPhD7XAkiWTOamgcByQKgQvOg7A6
         90ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        fh=Ah2+yp7zUjFCtZ5KOGNhnKUWz2SDhq20OBEOB4jzPuA=;
        b=CDUqA2EJIrDhLxeLJ91R41gRN8dkXa54rT/BU/sRQFR2BMcG82tC1M34kYfwLzcaeK
         agwy7awiEU/tX33Cd7egJM19dNd3vaGsoXxtuGagmk+M1z9MeyzUHHJ8QiS5DaPCfrLl
         dGxWUcDkNxXXYztPb8icmETeW9lYdOLIjNTlaUtVxHo3o5XIxN676AP1S9aRtHaD0aFM
         VJtV4fP3JcJpdZjdfc2g28RJKthWlxLzExAMI/1jLdn472CW1GoTqhlU//Fdnr0b9L7b
         6bJGy0W/ggKN8IleHmWG3DAJIABCIMGsts6TegsKy3ZR2GW/rko6HD3pq6pJ+Zzzi744
         RgSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792627491; x=1793232291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        b=r5/dMExZdsegqnBx5TcXIXcJN16gpTNCq61leyTUEjj2L+N/FE7G4H1kjXO80VsYSd
         3/XLoco5RmxHIp/OuhsTeNGUs8ckcsfub1kOql6DRJZk5t8OgA1OGSncr6uS8XWyhhFD
         ArA/0cZ8yOZ/3Q866oKH9xs4yBxacU/ZQw5p2zKvzQkoz81IFRKjrCwzeOdJPZ3CtvPp
         b6VcXyX+cq/Sv4RXtSo4qANAEQddQqsMd3+RbK1G0nLzOfPBFB5Yrw4pDtWo3ihigWVO
         uLuoQzyj6ePqhVDcTYB7N5o2M6EqFSof7pibTqpgQUZ2Ocb8e66lLa7Vp2u9Hd/ajh/s
         AL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627491; x=1793232291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        b=IvMgjjHwE6NucrXxLWX6XLQ85K+WJ/JbOTY5HxBBtGngMVzYZ9SF+Z/fO0vPBP0FmP
         gslSrbwsVeLHN3qpI03DZ01dW9paKa/Y8kb53UoERwer80LlEIzC50KJLqCiagLJBwUX
         Cs5IR9SMn142W+kqvt/c9zghy8iv1E+jH0a1fxqsew6CxYaKHQESnctJ4qwSGQkUGS7p
         EQWoRqAHNpIJOM92qjnYRQV+HhUEjzLmLQtDE0hBWmorqp76DrV3MlYGQ2OimNRiDu1n
         EztAlAWbRGxmq3rivGSmYIf32ylhYoBxSX123NZRpggVgjlfGuVnH6sNtpXhP4pJoctm
         aO7g==
X-Forwarded-Encrypted: i=1; AKwUvBzQGgoWceXmYbTh47nwIBEioEoPynSUV6ncOj2cDil0r2w7UbtlfP2EDZgYnV8sCRfH6zL2uD/7olpP@vger.kernel.org
X-Gm-Message-State: AFq9FYLXpg451pzl69CWZj6Hmt/Te+SL1S1WXo73dNvY8CkJVbQQ0GEQ
	Ara+oMuAaQ0ojIkkg3WgEPPb9NrcMz/RhY9OgwByeN5D6F21UIyLskfqVDbe5msx/3NB0RTZcsv
	bamL5tG/E1Iybzqhg9r6xN+q1fXT+gC8Vs8GM+wkN
X-Gm-Gg: AYBFou1DThHUUx2+oTaDH5/uYLWk771L6DMKO6Nvx7h/ImX9sv7Bd0PcplqhVdPJUT3
	FpugueL4h6HOfYTzhPk+soHKQAnIF9amTKrt7Lf8EVGKqjHEJHCq/UjXNh3E5vYjEaLxyf+VRHh
	PNt3haHzKFs27ig/wenrwihq4hSh99LDsNpjQWEqC6WixugTAhF48R6sV/VhzTOzf3fFhry6lf0
	m78DFZLSh7uMvAw9wp5/td/VN8dgRCciTa3UVTK2e0MIKRC1eXeFW5+AnwIjMGbjPLRAcHNfomv
	ezBEQtyUiSlc8Oytr6SGnWBQ5sr+p6+IWHaiwaJSo3pCSYg7f6ZjPJeLNGdCfz6SvKjRxnlq5Na
	zIohta1OSpGwiuZQ2vnGsmpl/seKTpt6edIVIAQ==
X-Received: by 2002:a17:907:86a7:b0:c34:cf13:a930 with SMTP id
 a640c23a62f3a-c4679689896mr324348966b.34.1792627490183; Wed, 21 Oct 2026
 17:04:50 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
In-Reply-To: <atlQ_Er0Ig7CCSxv@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 17:04:22 -0700
X-Gm-Features: AclHuK9LuxkFhyY58-PllQ_xn35qEFAv5-F2hDjCZHaof6GARbd972qVOi8lSVA
Message-ID: <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> > LUO and its file handlers validate handed-over state with monolithic
> > compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialize=
d
> > structure, even an optional additive one, must bump the string, which
> > breaks live update between adjacent kernels. Replace the string in
> > struct luo_ser with a feature header, so that the target kernel can
> > accept or reject the source kernel state per feature.
> >
> > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > structure size from the source kernel followed by 15 chained u64 featur=
e
> > flags entries. The fixed size keeps payload field offsets identical in
> > every kernel, regardless of how many flags entries a source kernel uses=
.
> >
> > Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> > LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> > holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (4=
65
> > features in total). Each subsystem defines its feature states as a
> > static const u8 array indexed by its feature enum, which
> > luo_feature_hdr_init() packs into 64-bit flags entries with
> > LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header fr=
om
> > the source kernel against its own feature array via
> > luo_feature_hdr_validate() according to the per-feature (req, active)
> > truth table:
> >
> >   Source Target Action
> >   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without acti=
ve)
> >   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
> >   (0,0)  (0,0)  Accept: feature absent
> >   (0,0)  (0,1)  Accept: feature absent
> >   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
> >   (0,1)  (0,0)  Accept: ignore payload data
> >   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
> >   (x,1)  (x,1)  Accept: use payload data
>
> I think we have different definitions of "required".
>
> In the PCI series [1], required and optional flags describe the _data_
> the previous kernel handed over, not the kernel itself. A required bit
> means "this preserved state depends on feature X; a kernel that does
> not understand X must not take it over". An optional bit means "the
> data for X is here, but you can safely ignore it". The source kernel
> only sets a bit when the preserved state actually uses the feature.
>
> It's up to the FLB/FH retrieve how to handle the scenario where a
> required bit is set that the target kernel does not understand. For the
> PCI FLB we panic since failing to adopt the PCI state could lead to
> memory corruption as preserved devices can be doing DMA.
>
> The target kernel never requires anything from the source. If a
> feature is absent, the target kernel must handle that, e.g. by
> falling back to default behavior. If it can't, that is a compatibility
> break and should be handled by the compatible string.
>
> In this patch each kernel has a single static feature array that is used
> both to generate the header and to validate the incoming header.  So if
> kernel N marks a new feature X as required (so that older kernels reject
> data they cannot understand), then kernel N will also reject every
> kernel that does not have X, because of the (0,0) -> (1,1) row in the
> truth table. That breaks forward updates from N-1 to N, and rollbacks
> from N to N-1 even when **nothing being preserved uses X**. Therefore,
> every new required feature becomes a compatible string bump.
>
> I would drop the target-side required state entirely and let the source
> kernel decide which flags to set for each Live Update based on what is
> _actually_ preserved. Accessing a field added after the original struct
> then always requires checking its flag.
>
> At the end of the day it is up to userspace to never start using a
> required feature while they can still rollback to a kernel that does not
> support it. Cloud Providers know how to do this since Live Migration has
> the same problem. This also means we must be very careful when adding
> new required features, as they need some way for userspace to explicitly
> opt-into them. I do _not_ think we should try to have some generic LUO
> opt-in for required features. That is up to the File Handlers and FLBs,
> as they have their own uAPI.
>
> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@g=
oogle.com/

Oh and please see the follow-up PCI series to preserve BARs and bridge
windows for some examples of using optional_flags to extend struct
pci_ser with additional data without breaking backwards compatibility.
e.g. https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@go=
ogle.com/

I don't yet have a use-case for a required_flag.
