Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA08385D81
	for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606055; cv=pass; b=qwWiPHRa20tgaAB5aoa2NhRagk7wehBIoB0mCu145QWVcTgLWmOyLPgaP9pTi6trDd7AOGXsAZYZqZzkXtynqfQw4DnFcDzfxVKGT1JGtNpM2vE0dlVS8KUJUtQVCNqqQe1ckCXqOX2N+9s6rg+lefbx9FaAdWRpaWzBUUlSapk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606055; c=relaxed/simple;
	bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWRAFoq2rXZlv434tqEKzaFX3J2R6pz3b7HeT4hP2yN7sC+hVL6UoX5Dy/2XSKh+8qMqkSK14t4HpkRCaf/s/GhFG5iXo0wrz4Z8IJX/JGHiEGuBxsnZw5wSoEUPY70BHubl3YItBjp8fLQuv2Jn6UKxZm+gkBp+BrRTa6+roBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGppsbak; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGppsbak"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso10211320a12.3
        for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 10:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778606053; cv=none;
        d=google.com; s=arc-20240605;
        b=cajNCUMmEWymq+NVNeOPuUul9CUE5SaxnBsdmFWBHgRaCtZvCickAtbJE4M7DwOlyT
         uyQ92qLGADOLFydURw+cZtzzF6K/1E8G8Pq/ealoSbhSIoyE1yiqxI8aHvkKoL3oa/i7
         PIkuAGx363ksJ6e214WkB0pruobYtPmOrT2oQUFbx/d/1BLgkBnfAhmxY+gQinTgeKXC
         OpTKQ2ftklzkrZK2/2jbruZCjBaybo3V2PV4XXwundhtQOx63v7qigzr5mp8LKsQNkIl
         71If7SAp7OpzvCT2D2wfm/2y6TDZtVAq2AGQbKVobMqfNmCRN+gppx4ORxaHoyogU7fp
         yr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
        fh=GUigVFqUpRNPUElKNbmDM9W/npNFURAz4KjPx7wnt5Y=;
        b=LWTKeMVvKuaDZMzoYDvgcpqhRP+kpJE5a4ptbpOOZhQJnc/A9Me0PqyHljDTYuXd03
         OhrgdnEpH9088UjGAWhDu8sz9gV/W5Am38sMmNhKQ5P46cKuH1bqdWuhGNzesLkKyJsK
         JtNS8JrEf5GUtXanKS2fG8ObBqWq001VePM9VKOGp40sK2UoDVI6zSkIMtbOj5W9F8TC
         UnEJtDzFgeHIRwihDhdRDTs6UZSqB/Aie2nPXhf+O6rBm6BcsYNpAzbfGF4g1gyGoBiN
         tDkl170IkSIcZ6ORF7md8XHYxoGbeaBX8JAMqAnbnA4EfZYbLlm1cjd10uLPhPqYShht
         bgMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778606053; x=1779210853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
        b=NGppsbakCAtsYSpY/QXVRFgbGAAlbijcE6L0bXKeaTNkicJA5rSu42bolfzXt/LrwI
         OAXgLd27HhZi1xTiDAD7TBTBcDMPFdu5FCjacxL95HajNWgdlEL+Ej1hHBp1cI1WOhmE
         zFHIoN1K+Qq91X9oTTqUsuAs/gwExlhfZddSU4lTzPwC24LZrjHn2elyN/FxjpeLs8+L
         2ne5S85mzFGPFdqVxe6/Q846l4gHd4VmwjGu+DRXHC4oNyAqxQ7klkva1TF55nU47lmj
         w0qxK7Zh4PO4Pff/nXI/peg3R2GI6LG6M9FFdav30/UVNrV/JKbTEzs/O/xyfNACVlvV
         H3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606053; x=1779210853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
        b=G7sRrDatGqTrONVJFoFwpLN+ASLOp8F+ecw5JSwht36f9TkNoWjYHGLeFHVQ91NISb
         nmrLup4cszijFZMyCrU6dyptLafk/kYHCavSBVe2Eldy0eup8m4PVnkXER07HtmCn2lu
         QTIxZ65LXzkAE3H1m2ilaDoNT7l6WWq9gsUyLvcJRspJUxdD2dVPh4myaPmATou8PfIx
         9rQxy2OQIzVCtuVwOlDwKFSGpDIMp3YYqUWcyZ7rAnJ+PZhNB8HwX3mlG1ZZ58c3kshG
         M33TCoYi2K+muEo86fG2xXqeWXmdUT2QPvDGkJn5eM5TeNfjV15Wd3bOiaOCB3DU3aCG
         +N2A==
X-Forwarded-Encrypted: i=1; AFNElJ9C1Xvmm1bbdwgdcoRnyhVIhWSbjQuQXwiCD0dQtTbAZwaXznAFIFmXgLyjPb5u3AAf1GPi7bIQG5rX@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/fe+hZ+JfbUej/W9sYYgY2yqTpRQWONECd1mq7sPwAumfdNy
	kwyHxgG713TwKv3nrIoAwbXKezsrg42exLVYOG6D6KYM4y8EYGb/qjapQHhSbNsK1toqFgVQdWC
	XbZzPB4VPSjTr6kIbhjY5jGiIwKBirhM=
X-Gm-Gg: Acq92OE2TMlhCefKWJBGYqd1iZ5fZHpmlcdlRMk7JYqF8uP706SQDakuJMdGm4yIWlk
	JyxfADqv5diA6dF8Z7f5e2Ltu0pHkQbCdbCHmcoV4bfp4CDo+crY4x9XoZ0vKxoheEv6xl/c0gK
	tBgCg9bUBw4SmJV/ytFa8SJLrQjHm6vXHAC+EbJaTuzYzfOfHKkLfCRkN/aJHr52CMhHE9PZ/DB
	oShN/TCifoVoE5+4UNshNHmHiA0I4vM1bZWHyP9PxPCn5hiPKxSuVz1piABoMBck+rKAwT/Owpf
	kmI=
X-Received: by 2002:a05:6402:3817:b0:679:4b89:d348 with SMTP id
 4fb4d7f45d1cf-67f714ed4a4mr7111570a12.24.1778606052319; Tue, 12 May 2026
 10:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
 <20260512023129.44966-1-lance.yang@linux.dev> <CAG48ez1xdO1wkqS+eAcnAV9QJ25=t1o0-Qz4qTZdg1Mo+en2QA@mail.gmail.com>
In-Reply-To: <CAG48ez1xdO1wkqS+eAcnAV9QJ25=t1o0-Qz4qTZdg1Mo+en2QA@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 12 May 2026 10:14:01 -0700
X-Gm-Features: AVHnY4JPV4nvI-vVDAMS4jJQpRRQJB_SbZAL6xKOyji_fdKj1jAiWLxEmrrsjQc
Message-ID: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Jann Horn <jannh@google.com>
Cc: Lance Yang <lance.yang@linux.dev>, rppt@kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ardb@kernel.org, sethjenkins@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:48=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Tue, May 12, 2026 at 4:31=E2=80=AFAM Lance Yang <lance.yang@linux.dev>=
 wrote:
> > Would it makes sense to apply a similar treatment to huge_zero_folio
> > as well?
> >
> > with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=3Dy, it is allocated at boot and
> > never freed, so it should never be written after initialization either =
:)
>
> Oh, neat, I didn't realize that that feature exists.
>
> I guess there are two aspects of making the huge zero folio RO that
> could be problematic:
>
> 1. If the huge zero folio comes from the page allocator, making it
> read-only might require splitting a huge PUD, which could have
> performance implications.
> 2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
> linear mapping can't be split at runtime at all depending on hardware
> capabilities, meaning the entire linear mapping may need to be mapped
> without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
> early enough to be excepted from that. See can_set_direct_map() and
> force_pte_mapping() in arch/arm64/.

Yes. First of all, this relies rodata mode. If rodata=3Don (used to be
called full), the linear mapping may be mapped by PUD/PMD if the
hardware can support BBML2_NOABORT, otherwise it is mapped at PTE
level all the time. But how huge zero folio is mapped in linear
mapping should not matter, you just need to change the linear mapping
permission to RO anyway.

If the rodata mode is off or noalias (used to be called on), the
linear mapping may be mapped by PUD/PMD, but basically changing linear
mapping permission is not expected by kernel.

Thanks,
Yang

>
> So making the huge zero folio RO in the linear map would probably
> require adding a new config flag, connecting that to
> ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
> memory management.
>
