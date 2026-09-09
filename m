Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15E1DFDA1
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991767; cv=pass; b=YMn/CT8eJZvLsQG1WbGx5BaSUJhb0nJ5h0t4Mx3aTGbRz8noKOsV+sE+7Mc38jJAmOFszy/r8bdulL1dIpheYJG30I+pqXwtHYFp4k/SPOjnF/JAU4f2p6ihSrkAZM0QlIb85Uvw6Z5wHhNG7VSZjVrJj7GD/EVFd3xAtHrg32k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991767; c=relaxed/simple;
	bh=bvzxaEfHxbnbItUGjnix/CzOoHNfP6Agb5FNfRpjWL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Suvi9zy8/GujzdpGLLe+5SKPg6s8Do17pJNqUpENOd7e1M9AHjTupmk8Otuk8ouGjV7LkooWL9021cDZOciigLKI1FD2wwlAxkJ/s7Y31GdFcJSpVzsCjapSDHnYbx80PDyYvx1dLrjYORx48xA6j8S3Cpo4CAOEK2Zc3KO3IHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJnHmHhe; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJnHmHhe"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so50585575e9.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 15:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788991763; cv=none;
        d=google.com; s=arc-20260327;
        b=aQW/5xIUk8X7B31bru1r2EpRmFp6z4k6xTQXURyixSJUJR3VzndC+B45gy9UJV8Kzs
         U6bQCF/KCvjd3TXKNro/5eNka0qWugJAWK663mmFs/93V4+zq9qo5vdXtw16fxubIhR2
         kO1xxGzYuI4IpduEe/tUdcHnHZVkJjGGfnKMMu28a1CK7O/N5UY5KeQmAJ+vD+TtryuT
         K+JfKSyz/2BP3Bs9XkVYQ4+NutQIGakoF/ZwxNEJ61keXq3GiO+UbUnXG2pbEUHTsE5C
         SgxRGBRHKL4wvbMJbX+VPxIlylzCVBU5y5WDzwNHcE/cMJwOFlb0bM9rgmI8OItkZCG4
         1r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bvzxaEfHxbnbItUGjnix/CzOoHNfP6Agb5FNfRpjWL4=;
        fh=WDE186BeDni82+BUXoMSeZeq0OfzmEznusox0W5hDj8=;
        b=LPmtN6roYfCIotjR8MO2nwzZIaXXXj+6tmo41tCNP63MU1GJKf1hKKjt4uWMLq2ylE
         YFOc8tSqFOe4DdG5FTyt/paYKWWi5yCfX8QwiykNXT08t0R13WjY4bW1M0kRFpxDJpN1
         0uxgdMRZ9wKMCThl3jtemlQvdRhuP0JaQo27d3BG2qTWNA4Wm0QXQGM8pPdu93KZS2Yc
         8HynSmSfIbbXLKjWEA6PnSazKSWSmPGUvCk1pVzhOk7v3x2FZuyEVH4sCk/m1Sw55cEq
         Xs73LXonFeiG98s6pGZLGCfU4hCJm/WZQYC5DT65ClNuibCr2GzG3Bqo7UwSUcB3CWIa
         otyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788991763; x=1789596563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvzxaEfHxbnbItUGjnix/CzOoHNfP6Agb5FNfRpjWL4=;
        b=hJnHmHhe+3Z3B/o1b9i3gNkm/aDnbsezDcQyviqY7dy1zsxKPyI3bYCDtR1pjVAytV
         yhiu4H+vtxVlBhhNE1bQlb6f7a48UllOzIPrYLGGCIAN4VhfSbAXPRCETqRmpiSPDTOv
         rWJDZaqFYHjuluIDtrEYzUPixzXiqxS/D9IuWtdGQYfHep7KfZZ14736P7EXNQpqVW08
         pKn1RBFdnG2451tR/nrEy7dEFMergprk0ekp8fLZLbsiP5bXRvyDoJRneG3y2J37tiN7
         kc+HMdzfao1r9BRM3SH3gaRbanbA8Sf7jUGn/rPWRtaAzSNYEBIxyhaqePlgxLqEmC+C
         bNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991763; x=1789596563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvzxaEfHxbnbItUGjnix/CzOoHNfP6Agb5FNfRpjWL4=;
        b=LcjbjEHKg3zClslQ8M277VoacKYxOZtukwublz4tLGjEO/mnxFYfZsTH6SERgg0dpG
         vvHW0t3Q4TFiYbLVUg8YP9rdBajGUsCCdkGq0QFPeH7fp9yltafu4mYhkZlAvZctHWyd
         5wcFKK4z68t2ZP4XsD1YkgmIIEHHyXRB7VMppPqRvR2G7PtRMDuB/pA0WoZkCOI7e7KQ
         RGQOF7pHS0jJEjiC6ky4VXhVIDdvkXCjEe9Yb2l4bZEKNAs+aAJKSh2F6oUeC+Ev7RRN
         9ubBDBrvKZ6aYIvDveE6y0Z6Q+YNXQULKZzGRll4ieQSh7AaITvahI91gHtj1bFgki9w
         Fp9w==
X-Forwarded-Encrypted: i=1; AKwUvBz3DEAcd5EShI79yhkpq3WXQqrjltwn16NFJc5fwxJsKWHy3tTYmGKVibW3W0369zj6EVPyWek8PHCK@vger.kernel.org
X-Gm-Message-State: AFuF++k3l08PDUcipI3YuLO+Z8Zr3TYw4sg4+Z1Uiv9CvPjgBIG1Jh/O
	HwQ6HVmU3+UObcIEltw6WfUmwC+Tj/zBQFljfsY4ZmZwzzpW4A97NkBUil2UtVLNtQDxFml1uR0
	PmsXBJQIOmctP2Xh9fnnivBfmey8Ocf36dtU/W0bT
X-Gm-Gg: AYBFou3sLKdqtiToHUbs2GJSyijifWk6VsGoTUcJtO0toUufAWlBwrnlY741yZmLZJ+
	7/JQrv9rSqUwPkBES5akKVhLgw0SDQNJ/OTP108LTYc2ghCJEQpbJqLTr49y3cFnYSMD3hMQeLN
	0/w/HREAqmBaolz2yg068VPHWqQWtxTpPH1LyQLPPpOcp7V4OPI388Ng0+/jRZeRgqiyn/wc88d
	UJozzqFoudRaV3c1Zd/iPVIMENk/OfgBx/1k9IEizT2PY5ou3lCGTvQN6zloVhOWgsGO9vXyQdm
	FFvlmeDIaMB3dmAWPEW8Gp0nQPrRkuTEAx7e1IlDk+HH44OGm6kGMTOh4d0MiTTmwMxXGw+c7/U
	eiO0wTejk4tiPdMzwRfumdS96fwA5QH3m0MM4FLnLHOaXmL0EcZg3weVd9UFKmeigpbZ6jDc=
X-Received: by 2002:a05:600c:81c8:b0:49d:1f10:8b9f with SMTP id
 5b1f17b1804b1-49d1f109802mr74781425e9.7.1788991761946; Wed, 09 Sep 2026
 15:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
 <CAKwvOdmdFdW8=y+s5NLoNeKz4LVbmW8tr+JqJ26wqYFJDdARFQ@mail.gmail.com> <aqFptJRjLZIL-NX7@gremlin>
In-Reply-To: <aqFptJRjLZIL-NX7@gremlin>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 9 Sep 2026 15:09:10 -0700
X-Gm-Features: AcwNN1VBBOSItlzf2aBfQ1Tsn20Bkz1vl5nUIWxayca3KAiKBTvQ_pPLoFqBSq8
Message-ID: <CAKwvOdnMuwKxPB_SXDcwmrAiwZFXWUAgcS1TdAkW+bqhYEZ=ZQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] kbuild: significantly speed up kernel builds
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nicolas Schier <nsc@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:17=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Tue, Sep 08, 2026 at 02:06:18PM -0700, Nick Desaulniers wrote:
> > It would be cool if your LLM could generate any visualizations of
> > what's going on during a build? Seeing what's serial vs parallelized
> > in perhaps useful. Particularly when you can compare the before vs
> > after.
>
> Great idea!
>
> I asked it to do exactly that, attached. Came out quite nice and sums it =
up
> nicely :)
>
> It also provided an ASCII version:

unreadable, but the pictures you attached are worth a thousand words.
Particularly exciting are the speed ups to the usual edit+compile+run
loop.

For the blue graph (the top one, first), any idea what that dip in the
middle is? That's always what annoyed me.
--=20
Thanks,
~Nick Desaulniers
