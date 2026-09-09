Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659E55D882
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958770; cv=pass; b=Mp9kWtDc8XJkLmCBWff9C563UZ2G0fylGxSErgNfZQhjpyB3XYxo7aBy8TVZGgzdzN2/tk97pS1uYYOOW+UNBjGX+bWVHydXnOId5+LKOtTG7iPDx8HNUfrl9F+hvMMAuMcRsWUfuigIazBmDfnM9+zZ3k1FlC7nngqU38oYu60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958770; c=relaxed/simple;
	bh=i1HbAAmLLEsFjOnWR9bXHueuoEhrvxEd4xap4Bi/h/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAQcxf2tHvwc+2OE1sCJNZiXsKm68AgNjefM3FnEEGt8g43LdOwhFKrkxclOr0M9zC5BK7DAwzKZJPqZNh7WlCxwELdIeJWOBx5edMJB8NSzJL75UN3CsLRDBsQhaXaECo2ZM4nC0Jt1EmGS0Vb8PTaMdf2a646q6AGpYthQzQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8jdgobp; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8jdgobp"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed441so1010519a91.2
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 05:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788958767; cv=none;
        d=google.com; s=arc-20260327;
        b=HiS8HKGjNSAO6lYA4ll8T0ow5RZ8T/lRB3EIKaQXI9Y/w1r7Ha+bjvj9LXqadiZZtc
         31Dl3P2tOs+L5nqceQ/YTShNhvgX0NK5XJN5WW1zFduBQg1aTbeA4M2DBoE6AtQPhLax
         TB3G/DRtBrKahEot/oxTeQJkoJX6L8ZmKntIc5g7oMDxgJbMR9BRrFw4Fvk+E/dD3XTy
         ZLrezHgexbatY0uOOXp0GNHQ8RNKHW/CZ9dWEkwmqkUtnPnh8iMzGe+oWVrwQyslnsIh
         Kbdt3s5aZxOsXG9MVfWsB/JSACMlUhe+KR/aB4iXLHUNMnee4H3ZtwZ8X26ovHYhgR0B
         IOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1HbAAmLLEsFjOnWR9bXHueuoEhrvxEd4xap4Bi/h/A=;
        fh=9movU9bgjoj9/l2qPNSh22xmaVV+tcoE9fCgF3ybyc0=;
        b=B5Uu9mEVD8EjT21gzcz/XkBptck1CwgOVw+tLA5Ft99U/GN4TjoKuI8TI8xF2EpF30
         Oja1Ztw9pcYyYybJEl4k+TQiLS8ivpuU3RwruWnj7z+o5/DsK3HvT3NsV6w781t4BdBA
         TVfeVlrbog9cNeTFL65v4Zqs3WiWPbtvbNzzmU3bhNh8xtAyOLtNJT41n+/21EokHI0i
         NA3OSOH40yO6JbxWd7aRdzhSYUnQtVbCz07cQJdvQwb3IxuXwx/D2jyIxnOPL0IG0vvE
         6cuDcHOXiPNFU9wPArsScgYjdSAzdMxL4b+mhfnK0pJV9Lu2n//1RJCtak52Rfj/bfVJ
         DpwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788958767; x=1789563567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i1HbAAmLLEsFjOnWR9bXHueuoEhrvxEd4xap4Bi/h/A=;
        b=b8jdgobpf6iJotPCt++6HS1J65D8oOCUtiAvw7bxOnm30uNVMENIz+xN63rhab1PO0
         6SWPMFrF0x9OzBV7nwBlofsQ5UfThkTqMOmSPh92d3YqDnSXPLgxyDRWyGwrZEIKgLQa
         egJuvXBIulCz1E5U4g1z5I8qK6yWEnim27+7z20Bb8G1gx9a2ePzK8MgZKNGIwPT4GlF
         zNT1HFz/e4tw/lmQQGBBUVDnsB/ao0ANBTLj74hLGxuScKDR3huGLbWQl9+eBdN/gA2S
         Y6P6TaJV9MdyCXmG6zWs09pjhSMycM/SMVSA463TU8mBqC4DxhQtCT9Erw9liO2TDGpJ
         rhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958767; x=1789563567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1HbAAmLLEsFjOnWR9bXHueuoEhrvxEd4xap4Bi/h/A=;
        b=PciDS5pCbuCxagiFzCJxuGwFUbD24/YpVNxo60422SpCjOwlcTHx8kZlTyYOeRq4G/
         AS2/neUb1hNn2SYwTHusBt8wEWDW83bJl2xyfEXFxhfgMIsZ5Uwz6cfDyaPe17O/cOwn
         OENi09xXBXFEC54B5BFtDlZTUHL3GPTED3ijOlh6DVR03OP5qU2F2Iw4wcd3hEBCsIXU
         79gdiLt2xRK6GQy+cij19US6B+PYfKbddxOYCpFX4Vyr/m/+IqYl8tdAYJl89lyJSLoD
         ciCQa1xks1xPtnm8jncJ9eD+h5ru2EgdVXEltHanuK8YQ0rlJ1zX2sxu5TyF44B4vaR5
         n9MQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMPVEyrOjUSZlrBqq0b+UTwoYerPwHMJ2ErhRtjBSHCt31oRyAtbPCRjxkcazPk7QC/ihtxZNyvBEX@vger.kernel.org
X-Gm-Message-State: AFuF++mwp01lYFrz6ni2+VxEri8FXCl08Uoor7YvIzfHk06KahGFVHAK
	Rg2TiwxgdyPgdDu0oZplRum28u2vjV/Pbx2gamNj0aGPXXHDuCxr8E9La8WVjAFFeyzCvAlCVPR
	o3pdAqxXFPyqhxSa1UeGNXdHjnpAboHQ=
X-Gm-Gg: AYBFou1W7nvXVZ1QaCjg/jgrGNNAYc21mpnuG7sdrtTvCUpVEwo4/zSmGCS+3pyThkh
	M2tkt3e7bp0R9ETAIqdpzyaVfuZO5Leu0noldbrIUbGMKEgrJccYCh4kwC+If7J9uSrNzLKgOiZ
	mCPK3dOXi0/1ht8xuXUDBLH6p2t+EBtTmgdRIBzP7gSOjqffk2c+8u8Srk3TA/04V7DXomFMCkD
	1zIiWETg9fsuWqh4lR07u5sov7Md1kJ8wISGpG5vJ5qcfnLqpFm6GLzag6FPBO6/nKnN3onZFNf
	AB3nTHEmEgJjAsnYKGjnuYHqxRq//SeiyTOsbb6kBPi99sAoHLXomFJoV2BQqPxcWoVYr0DF73s
	F+HYL0ftLyjOzVecxb+Az+8Y1ZXTdBO0odNqICNGKKm4Bq3xwkjO0TQQgC+/Us2QPKAxZU61Y7q
	JfwBpJOC5i1kim4vEMYDpmx2ylqz1b4LKItfi70QvvlROEsB/ZsWI=
X-Received: by 2002:a17:90b:2888:b0:398:cee0:67dc with SMTP id
 98e67ed59e1d1-39b2699849cmr33697284a91.5.1788958766896; Wed, 09 Sep 2026
 05:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
 <20260908-build-speedup-v1-20-5dc1ac01672d@kernel.org> <t8iID_-Rgtrxxg-f1ZfdOg1xmm7YedvOT4pgDFEXKxoIeu29-JooZ3SSlbze088O0kLSOdgP7xN_Bo9Xm_lO1x51Gd-gIgT-tFPfwM_gCEw=@protonmail.com>
In-Reply-To: <t8iID_-Rgtrxxg-f1ZfdOg1xmm7YedvOT4pgDFEXKxoIeu29-JooZ3SSlbze088O0kLSOdgP7xN_Bo9Xm_lO1x51Gd-gIgT-tFPfwM_gCEw=@protonmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Sep 2026 14:59:13 +0200
X-Gm-Features: AcwNN1Vwugoxsn23N3HKo79fRO4c4hCKpdWpUEii2k3VTwCoJF2DILgisLp6T0w
Message-ID: <CANiq72=rUrjFD8dHggtO5g0D5Yu-LjO4s7t=+yoKtteD56KfXw@mail.gmail.com>
Subject: Re: [PATCH 20/23] kbuild: rust: parallelise rustc front end
To: =?UTF-8?B?QmrDtnJuIEJhcm9u?= <bjorn3_gh@protonmail.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:22=E2=80=AFPM Bj=C3=B6rn Baron <bjorn3_gh@protonm=
ail.com> wrote:
>
> There are still several known reproducibility issues for the parallel
> frontend[1] and at least until fairly recently there were also deadlock
> issues and incorrect errors[2], so I would not recommend enabling it with=
out
> an explicit request from the user. Perhaps even only allow it on nightly
> rustc for now, then you don't need to check which of the two spellings of
> the flag is supported.

Thanks a lot for taking a look Bj=C3=B6rn.

If there are still major issues even in nightly, then I would say
let's not add it yet -- some users/CIs are testing with nightly
routinely, so it is probably best to avoid surprises for them. (If
someone wants to test the flag, they can still pass it manually.)

On the other hand, if there are no major issues left and it is just
reproducibility issues, then I guess we could add it to help figure
those issues out and avoid surprises later on.

> By the way, currently backend parallelism is entirely disabled due to the
> usage of --emit obj (which forces -Ccodegen-units=3D1). For -O2/3 builds

Yeah, we even set `-Ccodegen-units=3D1` explicitly at the moment, so we
would need to change that too (and likely make it an option, because
normally end users will want the best results, while developers may
want speed of iteration).

Cheers,
Miguel
