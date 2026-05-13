Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678E3655F5
	for <linux-arch@vger.kernel.org>; Wed, 13 May 2026 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713844; cv=pass; b=eVv0b7AQo3+59HlnW2DlL4ed3v40MgYSCAgQeaWNsMb33LcifM3ezC1C32xu880pRxkr8zobh9qH/IuAr3Lpd0Atq0IgDP/VZdsZkCgvoO53W5kRim+KvYD49AsQUR45ixeYcVtWpCeG6xkqzAUAhZUGhrGXSp7dL0MOvfK9ixU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713844; c=relaxed/simple;
	bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+32k3MnBQTrnmYHgmkNFwj2PPsIxX9uoegiPIvOEDF41NXQ38CQAcBqSAWNEzM2mo1eriIjgmYJmhJGyjlNgrzHGYG85mHS1FlyezZJlPgnjeAV/C1qaLlNVBDW5VJJnV+aVSqO9stNYOWr6aW2PgPCG3XHjJKe/FzdD/mWKIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sG+6nyqe; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG+6nyqe"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso13356463a12.2
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2026 16:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778713842; cv=none;
        d=google.com; s=arc-20240605;
        b=bmihQAKNiofKUgtsD3scO+32PKhILF/4RqVdDFBUBSFmZeFmFBkT3P8McZScu0eyXv
         A5yUJj7KFa0lBr57gNPpGV7k4BqOkTzTDS+ELfK28Pr0aharW4xP2x7EZo8hMB66n17L
         6aeuFora/mO4mgSvK/vMSrTuKmirfHg6eEKlgy8IcUhazY+PqGGLwAWcjU5u4EXySS3f
         EdsN2VDxJbN/CeHKb1yhiAMEBAHzveqeecWWvG3Srj7vyu/a4W/H/YlEjCBphS0KlPsT
         0xjaSvUcmCh9goH12nIvo4JwfU7XxDxL3UZaMW/00N/+oBUFspBeCQ16emXKI4vlwEUM
         R9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
        fh=x7f+7JBvraxTqnPyDh/ABDMXkk2h9bweChPmocIqfis=;
        b=X5tmoULskceDdvI0RAg4GsC+YjREXzjqS8Q4ZsVHacG1oN4d6XPo6j+MJ1rduCu5oh
         QHjokjaIlqixAOTzmHvdHOf8qkLlEddmBNUZIencO65icfTSIC/l2QXrs2cBzXy9VHXP
         cWrPHhV/hXD5OOjSAXKw3wMBfOFAIvVWooERM2Iz/PFBnkwVKeKEoOn2OsA/WtgiaC1z
         Lbtua9NEaEnPddquIhsfJ6kLWZJbE+nA8qmSg+Hz7IEeMLwJbM/rQnBNqEGEgo8LKpjZ
         qQLNWxiri0gkvF1+Z38TjKQLOErJz+9MmsEo4N3pgcoIj3jecw8+E2+BnnWmlzwhxcH2
         zxZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778713842; x=1779318642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
        b=sG+6nyqe9AqcKNszmQEXuS7Ow52nGH6vn2Bxbt4uW4NZEjJVI37JEGvIhYEaT4Oag4
         1Ifm3YoYC4t7YpMJ3ILK1mTiJz7AzI7PpcHsBlKYloex8FA3FAskCrREZr57TTdO+tOu
         r4osiL3jmzvq9tsw6sM/k0JsKFBNL8zkbguGVqkoL0KK9M4qjf1V22Y1aS74DfEd+2Ky
         qxfuP8x0UFwTtvXV61ND4mySlW5k2l8HKS7pYGy+Sg9IKr1K1e6+5t7GLWs0eBSqbOxZ
         UCUxoZPcj8EIlsUZNaECcwdS7H89coDkbon5vJpPrmzYdZ/BMAA67scdqfy7RwFKw5Di
         X2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713842; x=1779318642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
        b=s8q8oiXN54Kzfv0DqNXoz1eiti1l9j1al1AHXW/oN/O/IWSgOruOC3ccdWm2IsWBeQ
         7f2oPzb+3UziUh2jgwHYeQ3qZPnl2vd29IqjzxYbZX3ZR2vXGTHkowlsR2PMdGLdZhEO
         7zuKgHYY1ZmPb6csLUoyDCZB01Fgw1NyWT2VK1VgRwYG1xtHvPeMZRFCKPRbhC+LsxLF
         T5501gHzQ/jhOMDMUnYZGX/BDOkoKJMHzsZvrvNobiSzUdYSaZuBVZcuS1X+z/1G6MRA
         rEVvm1gE+fi6bHUZUXkEFuYpkkVT0owF3NdJhboGiUISf3Ti4h7Qq+SGXiUQ4mIvwkZv
         QFhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/i+NlzAaAzk+i9Iz3hnGjPvRWayvGQNnkul86VcHcUHTCM4zpNMO4g8303pHp3Yt844JddAHkZno8a@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3Ts1wMdhYyXVJwOoNoDwa9W8dJvKusZt1GUNg4ZXGNrrMj9R
	fYyyr1qJv4WF/VrKrAnkKdpBFoHZr//PR6qr62ARzZ14cTCSTGxoqIAtrOImWAwCpfVYR5wlg8X
	H00Am8L7wvQ7wYyikrI8OpaZoZ/1D32o=
X-Gm-Gg: Acq92OHSpay5Gdh3pOe0IHEk7wL1R6Ijl5hEjmJy2h1pW17mqNqshr4JLvBvwdxiSEi
	wRq6pdOsOorpjcpqV0CNxsYzLPZf1hY416n0Yb4QWUhrEfBgdMBJM4pyRgjPs2osy6tGAkqsxv9
	cGDqrROEIO74wC0VmXzGAORNOlXrE01KxtHfG5TDOYTAetnimPmRfB2DL3J7bQgAd0wrsxepY6R
	pNjsj6l5zbufHsaFRYvqb3KPESrqogNniU68vJoPrUBhGvvurRF8JD7UgTtmH8VLs2Z1EwsYzd3
	3k3dwZ5rIlWHUweNSWAIHlBD9gZxKoc=
X-Received: by 2002:a17:907:9704:b0:bce:267f:19cf with SMTP id
 a640c23a62f3a-bd3dfd64271mr315423266b.12.1778713841538; Wed, 13 May 2026
 16:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
 <20260513021148.17588-1-lance.yang@linux.dev>
In-Reply-To: <20260513021148.17588-1-lance.yang@linux.dev>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 13 May 2026 16:10:30 -0700
X-Gm-Features: AVHnY4IN0dYyc8FrioEWxy6x33mBpShrHTtaMmtJuX5Tb81bKkEuJTZaPlb8x7g
Message-ID: <CAHbLzkpBB2ia4pUG1khZy1w5G_sq6DD+9OnqjrJ6Yu0KxPAe=A@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Lance Yang <lance.yang@linux.dev>
Cc: jannh@google.com, rppt@kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ardb@kernel.org, sethjenkins@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:12=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
> On Tue, May 12, 2026 at 10:14:01AM -0700, Yang Shi wrote:
> >On Tue, May 12, 2026 at 6:48=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> >>
> >> On Tue, May 12, 2026 at 4:31=E2=80=AFAM Lance Yang <lance.yang@linux.d=
ev> wrote:
> >> > Would it makes sense to apply a similar treatment to huge_zero_folio
> >> > as well?
> >> >
> >> > with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=3Dy, it is allocated at boot =
and
> >> > never freed, so it should never be written after initialization eith=
er :)
> >>
> >> Oh, neat, I didn't realize that that feature exists.
> >>
> >> I guess there are two aspects of making the huge zero folio RO that
> >> could be problematic:
> >>
> >> 1. If the huge zero folio comes from the page allocator, making it
> >> read-only might require splitting a huge PUD, which could have
> >> performance implications.
> >> 2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
> >> linear mapping can't be split at runtime at all depending on hardware
> >> capabilities, meaning the entire linear mapping may need to be mapped
> >> without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
> >> early enough to be excepted from that. See can_set_direct_map() and
> >> force_pte_mapping() in arch/arm64/.
> >
> >Yes. First of all, this relies rodata mode. If rodata=3Don (used to be
> >called full), the linear mapping may be mapped by PUD/PMD if the
> >hardware can support BBML2_NOABORT, otherwise it is mapped at PTE
> >level all the time. But how huge zero folio is mapped in linear
> >mapping should not matter, you just need to change the linear mapping
> >permission to RO anyway.
> >
> >If the rodata mode is off or noalias (used to be called on), the
> >linear mapping may be mapped by PUD/PMD, but basically changing linear
> >mapping permission is not expected by kernel.
>
> Ah, right. So for huge_zero_folio the hard part is not just making the
> backing memory read-only, but also whether we can change the linear
> mapping permission for that range. That depends on the arm64 rodata mode
> / direct-map setup.

An alternative is you can allocate huge zero folio in the early stage
of boot before linear mapping is set up. Then when setting up linear
mapping, you can just make that PMD RO. It should work regardless of
rodata mode.

Thanks,
Yang

>
> Thanks Jann and Yang for the explanations!
> Lance
>
> >Thanks,
> >Yang
> >
> >>
> >> So making the huge zero folio RO in the linear map would probably
> >> require adding a new config flag, connecting that to
> >> ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
> >> memory management.
> >>
> >
