Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C03624AF
	for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814601; cv=pass; b=k8+oSMQFIJkUOuKXO09e4NL84jPGL+LZrGZtkilcZBQKSOxlEr/iV096wXFto2a0rziOZKpYFm5tvL/YOJLGAkwpqN9lHrsYE+ArK4x//iYpCU6UMA9SqWo0gBxmNYv/sa3VxqPeXbmy4o09n7jYsOySoyYPHQn/1R8R2DEwL+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814601; c=relaxed/simple;
	bh=LyvuvQqufknbMfPTy2o7n/T+OqohBBDpzWX+jX0Ni6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYQlt6B3tQVCTEjGziBmH/WelTxG+Mj0Qv8LvyHY4DlYahr1r3ewkKY90ZNpKBbInuzNBn5AQlXXvM5SygxS95BqgW7UGVcItheTphgprs44P8ViblKujQyPUVwNz+LVkIwHdA6zavj0YP9DXseDz4Zc4ImDK2pYoBa3bP6+Mk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czA+VIq9; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czA+VIq9"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b979d16dd0cso613516466b.1
        for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 23:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773814598; cv=none;
        d=google.com; s=arc-20240605;
        b=HXgiP+llJyuAwky+r3DNwvH7ulxXkaDozbmNP/WjUV1Augt06t9EfGbJ0GZuWwhvdj
         CnMQOZ9sbtwV4tJCe74Z8NuSzYhvAudnMRWfhzDT7I9jf2XlP/V0hGW5/DAZ7cXCNaWD
         8TfYZSmxasTYr0NfLVixw/seuiGrxumC2PBvKDY81Itd4Col39uLDjwmg64MR4YBCQjI
         U/Ab/4HvErHNme00+8/YxUGdMqTRpuE4PysNRK4Veamtdw/Dfeq31pw44nUB9q+dh02q
         GwyUoRIhHxLCXWINz0yCQmchw/8MZZwcnjbqYpa8Hiz+/XfYWocYoT9D9Y8WWfKrfQno
         KHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        fh=uVMoGJW479CTG9NT5+vpSXyljczjVR1rRe+t403z314=;
        b=PDhKim2/JsGv41IGq8j3eHo1sPAd9CDV9p6c6BtFZnFQ0PTiP/5xIkEpGzWlpfBEUu
         9gG3dahMYsT0bdUES2mE+nkDYwm+p6vljiNPkdCrBWphOcQRBsU+u342PajoXov5TmRa
         l9MNsJhQfJcGpBNvVkDWfHB1x/vehqsdzenu4QfMHOOBmB9V7w+z3Y1Fx/r7wfwE8AtV
         GSN003dPGn+edEUq1tXtXie6fQiq/R5iqacKYhLkeb5K6YAfvVihcmxsTfOgR2usX6Un
         NTKErx7crOUbn/0GNymwUpSsPh/cKKYlgYboLq2loSvRksBULwT8wDUtakkD8Dpva6IK
         DSQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814598; x=1774419398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=czA+VIq9QGWQxIWviOuOrte+AkszdW/h15AxwnnBl8PgQdCUSJeFt/rkA58JF8bw1z
         MYdnPYGFr5y46Y9Ze6hH0uQbYgBxWhk4ISCFrpb1oCRqUKW8TesUGp2nfyk/tjdH6ZzI
         DwOCFfQmjthVedmcIE7z/9904oV0s5pfRk6WMlT+ADyKZllzFK45VHyMvAMFKoo37U/j
         J1nqKAueMk09QeZKqRnb2BbN9+d1iclFRFK4eWers79RzlXUT6c5NL6yIGsvvdDwBLkL
         mIaXTaJyIolZxl+55rCZtIapNWvPnqXYQeH5Kjuv+rgtZgAO2r5C3jf4lHbFErXbdAiD
         Zyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814598; x=1774419398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=quMWLYjeJuv+8mE9TLbj005hwUm59TTAj9Q4L8HQjZtJwCLAQeqZA9A7lgbgL5Q8cJ
         BvyqM5EEjIpgfTms7ewmrSE0Jf8w0qs7FrTInMPiqA3SK1nAedmeWc3hN2LKgsqmCbyh
         aPeqXwVKCgNh7R/gIhveGA/lWeCe6sAKIkKsndX4r1GXBDwwW3oUoq7+o1WSlBBlRvuh
         cTx0D5mrEe48xaOl/7JeddzgD9+hH0Tqhlii6aF62ma7/HDVccpdClkyAIy0Oj26DDlK
         b7+CPo7wP3wbPSGjUtYALpF9pUcop+MDxdFjb6VUDtgiBS2+449exOB/VWYAetcLESfM
         vwlw==
X-Forwarded-Encrypted: i=1; AJvYcCXuV6cve/yyyGcu6xMbAntXOQBlVqdiEIGmHqdIrCxsOhNbJ7NWhtIJUmXQxNL9RjKlLOiCV92fO/v8@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqLck0pFGIYqkoBq5xnnPZCDOHOl4YxU+eNfen0QUew4ZY0Ap
	I+/F1pfnZLsXxAY47/YLW9saQUjLm4Iv7kIwFvYlvhs9FTXr9Tk2QjEz4eoam+mEFRCvCfgkkxp
	IRLDU1POZYiLn2LqDUTUmDDix2Le7Hl8=
X-Gm-Gg: ATEYQzygu+8LUAvmgmfuk/uLxlX8CafXyxz3VYMaAtprRKkI1FBMiGXhe2eDWoNk7gi
	2XZ/Y84C+P149GpGvmLFQBSICGHayIde9udNWsd8unKOMrrGP+Wn6XRWwV9zuNBypP2i/uHiiK6
	U3i4AiN1EkubSGyaC9ZvLt68WyTXV41xNiAaOdwykSqnZA9b5yIO02Y4t98hbqrp51c0IYQwf4Q
	YK8VxthSKMtY4tYQX5ebm0rfv+1Hl77WSAwplRrCm71uya+aSqJ4ooWiTLS8FaR5gDvA9Pc1Awb
	AJZZpP7U1ePMeE+jmgQmWpt1AzkBhHiNCsxThv8iWalTO3g9X/U=
X-Received: by 2002:a17:907:7b93:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b97f4801ab5mr133040366b.15.1773814597747; Tue, 17 Mar 2026
 23:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Mar 2026 07:16:26 +0100
X-Gm-Features: AaiRm51Xx89jeaivgNYAhMk2LxpIu3kD6j5N4SuQDZ84WCnP1EAzJIW2dMNKGiE
Message-ID: <CA+=Fv5RLtUPp9BhXfFEUk3roE3Gah0iUamDEZ-MXCNM_xKm3PA@mail.gmail.com>
Subject: Re: [PATCH 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
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

On Mon, Mar 2, 2026 at 1:32=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/alpha/include/asm/auxvec.h      | 7 +++++++
>  arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>

Build-tested on alpha, no issues here.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
