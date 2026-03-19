Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A443612D8
	for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930484; cv=pass; b=HIZQMJ0DVJ3hKXEB5HlBdX+1XtjlhJ+jKEmSW5r0PYQQZKXV8Fw5RsfEgsPwOYcfMu+nylNZDXay8eUxTWpW7B19xUc+TY9nQtZKp415U+gIeEjzivhpTjHIuh3BjyIXVfcZPqZ+o/8561N+o0JIuEgPGEVXKzpv/PCu0Iz/Mqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930484; c=relaxed/simple;
	bh=x6wZk7AvpBRTPYt5th9R3ycT2p5XdAgtnR98fAb1EOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXna/wBdy4eBxFf1JLy4UFyJtgEtLV6abAxXicPEixGUZBavhqcd6R9jMhNXFvoB5uW9sxYrdAQGpcI2avEbuQyPooz/cWHZtu9MRz69+ICzSzGUCCPWCO2dirVkTof2I0JKhg1u1ZdeyvGaUABCdvkZTuFSDc1wEITD8RgB4sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcCKrhoY; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcCKrhoY"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6652452d94aso2069679a12.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773930479; cv=none;
        d=google.com; s=arc-20240605;
        b=Zsra3synS8JyWlQcnuGZyuNcLm2eKYGmpWKkPcaIxb9eWKo0xrmZcteNh9RLB5U0+r
         V8YTsMsi9NbS1OL8+mNWoRORYWeCCnMqFG7Yh4kGFL8iMYjmuDo+Vw0tGow4UlBo9O9o
         MAfXFRmhy3hEjK3q1yRU8KXq/gKHgxWc6g9Z8Mbw7AOGJ7aQFlKPnJz8R2t1zaL5sPLE
         EHtlRHQ6hTVUh3VLZGYjR4+e4u5wSttmhZ4z+WSl3f1SqV9wJCuZ2j6vmX3Xs0ZdL+KR
         GReWASyqAalawwIMLHXDY+ERBe0xjnbkjbnMm6WdXRsUWnIhMm9UNNp5B/a6kHPEL8yM
         sxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        fh=jyohNQWFUThaiGn/k5z/nCL25ctG6p3jQ+eHlQcQvnE=;
        b=JVgMZ6HB7m1fsU9lx0KSF0YPcvZwUpqzUUv6pXYEOIA3/nX1G9bLjxytJ7lfLTW0uz
         65DThH8byjPrrbZn48dj2IbU3tSPOsH+0XtlF/apkdXKSmILKZwT8eqEIM5lrmYbcSdY
         11MzKiLRFq7FcHTQRj2Bd1DCW2Q+23HkET9PvMVNK0/ewVRyqw6EfvE/OahH1Lx/qhB1
         Osar4NnpcKFwdlYjQE3BD/lNMp3FdR1Uoze1TyqLKoeqwH5knwa2zYHOimyYHTDQfdGX
         Jdn6XHZ3jKo0n/qDQim38PyLMpURQs8lN4XafFPvvR/BH7VP+q7f8OmORG513uTAAhQ9
         Nf+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930479; x=1774535279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=kcCKrhoYX+8CZszcDQbuZD6T4DnxTVx1KFlZ0Jph2pEsT7DV9Mnj1YT1bYrXCuAa+S
         hpDAfQ1xXxUjFpI++GUXCzaWS1y6BSStTwjGD+OnOBciNoZ7Xp1VqamSGoaSAqSZ1u5R
         945g+zKdeorBhg1AKG/Bb90H6R2LtDirpwrPvj5Oh9WzuAiCQSN2EnknkZHTKsbab/zB
         fnD79VSfUGwENxCYTTrjL7dnOT3K9jltAF8JDxfu2vpVHutMN4ta0fP0qdP80PoqOA/o
         HPeL/1Ukubwi4cdQoCwu31uFJ5Bte1R3lZPg/JzllRmeny1zCPKEmeQumCaUrIAZcRJw
         +4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930479; x=1774535279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=KETLItFN07Xj0ivBUZ7MX5WFgCnjO79ZLoea3R+O1EQcTfX+NgCuGmLQ3gxDY96tPe
         pCBZA5TKoQJAjPHN6Ct7rgsSXKjPt8aAlKoo5u+7VYrt6X0+rR0Wv9juOYeTdCryMttE
         i9mnwW0bUtkG0L6QCXARXoZuI/HOFtzrOXJJLOcN8DO+lQ4TkorDha2TVLQs4TmU6hHT
         7/BHWllYztSwlutGufrcpg+Z1L5rBEv4OcUBOolPXIcc4orR3ltROitOaO8cVnjEseLM
         59GwuX/y2P5/e7/XXIOuHqws3Q7OpPOkMXWjGM0/R1uBMPtzHgIy+kZDbGsY+ssTrk7C
         Px1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOt0Q69MLFJouuQ4yanpypkjpgFuAhNXU0qpGP6BZbZuxxaDLIddSTflGHdUtaWQGElgYJVFFa6ORs@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfPYP1k1iMPAeQ6Yqe9YgZhicRwERFE0McVCfCGUEaYEQNfeJ
	e2CrHYq7L1GuE6EhEy2xLhs0ldKa0uRmKxXMWw375fakka4bXFEIA7qDF85SWmuZrC9u22UfbAt
	F6Ht+0EcgXrdNfSiVohsTShZNYAo/S9c=
X-Gm-Gg: ATEYQzxdix9JzTaJwjSp+lEih6Qw7w+lmWSWjEolIgYP3GO4ZvcwC+8RWafu249UrMJ
	8Smm332Xdxz2cnpgOOa8YY2L5EJg1CJQHhwQzV71BVPC0TLpmwzUTPHrCC9ogaH2/OIn1QcHlLl
	HjscTis3tfQ+gwkV5XRrWbiA7igY2K7BOJNCjdZPyOTahARPYQoqgx6rocitIPu3I7IKpwehXw9
	oqeOVC+cSFl2VXklZ5Af6Mb0BgRHR/JeoJoPAzl2VTnst5G6DlWFlB1feVajNUWc/5BGRJTBkyg
	rPxl26FUWw==
X-Received: by 2002:a17:906:ee83:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b97f4ab7799mr545864466b.41.1773930478856; Thu, 19 Mar 2026
 07:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 19 Mar 2026 09:27:47 -0500
X-Gm-Features: AaiRm52wQD6uRKulnt1Y_ioaRFL-b1bqEKDLHZMA0LYwV13CAWHAV79Bf5laR-o
Message-ID: <CAFTtA3O74BTJz8d87CJFQpa8Sub_ouKyyAB8cTXUxd=BnUzS7Q@mail.gmail.com>
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:27=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h |  2 --
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/aux=
vec.h
> new file mode 100644
> index 000000000000..fb4233445276
> --- /dev/null
> +++ b/arch/riscv/include/asm/auxvec.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Regents of the University of California
> + */
> +
> +#ifndef _ASM_RISCV_AUXVEC_H
> +#define _ASM_RISCV_AUXVEC_H
> +
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH    10
> +
> +#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/ua=
pi/asm/auxvec.h
> index 95050ebe9ad0..0a725f2aa2e7 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -33,8 +33,6 @@
>  #define AT_L3_CACHESIZE                46
>  #define AT_L3_CACHEGEOMETRY    47
>
> -/* entries in ARCH_DLINFO */
> -#define AT_VECTOR_SIZE_ARCH    10
>  #define AT_MINSIGSTKSZ         51
>
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
>
> --
> 2.53.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
