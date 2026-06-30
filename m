Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB739283C
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802097; cv=none; b=evm4JJsOiO4CqfUVbRk0sbWgL7HJwZUrgGZv/E8gvS8qCHiIkh9U3We0CHma7IxBKYwKBKkr+lPVh0tLs3OUSEFy6QTfx1KQrJMLtBdKyabeJNDM83cLyCiirQZTmTj6B3uNMakGq3d15ZzzvR9Xo6psiLwsJdrnGK7MOft9mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802097; c=relaxed/simple;
	bh=HH7V0RO+G10+WPRVyC1TrQpVHHN/W20mERyQs529ODk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPTuZ3MLQXRInJVLKsLUxLcF9uWqhx/VUFZPTpzbc/zZVOkD+KQ5dewV6QLbcI4sTO9FEWKtXHhW9cLtB6li+128siUcTrTuO8Cu6pxwbEIvdHkw56JTQYEKNmrMc+bEdTiGhugfx2UXAKbZ0rfJGyOtFa9mssTly3dUJM1kZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQbUHPxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQbUHPxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5D21F01558
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782802094;
	bh=GmOeYBnH+pucvx3tPfeJ0XPPeaBlbElUu+Q/ZIKymgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gQbUHPxhEiH2raHpZIN6oBRl9E+1UD3QUNT2Fw4BPeFQ+WDHDN+zFU6PwALsNMK05
	 2WjNlTS+FoMmA2fr/tFjj4GhPIvIc9cC2METu1pc6GLfvit78DT+DLQV/gs1JE0hbt
	 fgb31zwcDdQo31BoonXIRM6Fq/apx7UcxVtwwsvPyNwkqB88Yh/LevTtxWfRLdoZMZ
	 rGXNGVVtUgJi44UaN8zODBgy2aNOsaQGrrILL7pUJP5D7qUzL9mSiRR3za3IxR1s/f
	 4WmaLujPY3xb+FTws1zpYt90YJaXS77LpBoqsRjCJKuubo6YxPtNvlspKmDadlCY35
	 LSZgNK5KCJ5eg==
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so3355308f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2026 23:48:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RojAgdKLbCZEQMkUiYEwPl4XJP+Zpu49hsTo5otyM7g38lf6o+ALitqXsgyScUzASx4cSkUUiU8ecsi@vger.kernel.org
X-Gm-Message-State: AOJu0YztjC//xD/tBv+yK4lzNbfwWXJ8jAgPL5g8ki44mgDzbmElNcvZ
	eS8H9WvJnabC3eDFHQQ9EjHVf+OarErDqlkpaAS1dKYEMr/Vs+wF9cq7uuNXjocnetvOk1bXKBd
	VoRDNbbU/oP1tIwlKajmtSR1elBXEahc=
X-Received: by 2002:a5d:5d06:0:b0:475:f100:3600 with SMTP id
 ffacd0b85a97d-475f100372fmr683383f8f.61.1782802093102; Mon, 29 Jun 2026
 23:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630045531.3939-1-kprateek.nayak@amd.com> <20260630045531.3939-5-kprateek.nayak@amd.com>
In-Reply-To: <20260630045531.3939-5-kprateek.nayak@amd.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 30 Jun 2026 14:47:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTi3EJj7NrOEZ0GF21VxfyUFujnaGbRmLuYy1_YcPkbDw@mail.gmail.com>
X-Gm-Features: AVVi8Cc9p7eoaCe7f58H6IC6apx1iBlYENd1M3Ce4o3oou9E96K3mWDK4f0IxWE
Message-ID: <CAJF2gTTi3EJj7NrOEZ0GF21VxfyUFujnaGbRmLuYy1_YcPkbDw@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] riscv/runtime-const: Replace open-coded
 placeholder with RUNTIME_MAGIC
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
	Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:57=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Define the placeholder used for lui + addi[w] patching sequence as
> RUNTIME_MAGIC and use that instead of open coding the constants in the
> inline assembly.
>
> No functional changes intended.
>
> Suggested-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v4..v5:
>
> o Collected tags from Charlie (Thanks a ton!)
> ---
>  arch/riscv/include/asm/runtime-const.h | 38 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/=
asm/runtime-const.h
> index 900db0a103d05..1ce02605d2e43 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -15,21 +15,23 @@
>
>  #include <linux/uaccess.h>
>
> +#define RUNTIME_MAGIC __ASM_STR(0x89ABCDEF)
> +
>  #ifdef CONFIG_32BIT
> -#define runtime_const_ptr(sym)                                 \
> -({                                                             \
> -       typeof(sym) __ret;                                      \
> -       asm_inline(".option push\n\t"                           \
> -               ".option norvc\n\t"                             \
> -               "1:\t"                                          \
> -               "lui    %[__ret],0x89abd\n\t"                   \
> -               "addi   %[__ret],%[__ret],-0x211\n\t"           \
> -               ".option pop\n\t"                               \
> -               ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"   \
> -               ".long 1b - .\n\t"                              \
> -               ".popsection"                                   \
> -               : [__ret] "=3Dr" (__ret));                        \
> -       __ret;                                                  \
> +#define runtime_const_ptr(sym)                                         \
> +({                                                                     \
> +       typeof(sym) __ret;                                              \
> +       asm_inline(".option push\n\t"                                   \
> +               ".option norvc\n\t"                                     \
> +               "1:\t"                                                  \
> +               "lui    %[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"          \
> +               "addi   %[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t" \
> +               ".option pop\n\t"                                       \
> +               ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"           \
> +               ".long 1b - .\n\t"                                      \
> +               ".popsection"                                           \
> +               : [__ret] "=3Dr" (__ret));                               =
 \
> +       __ret;                                                          \
>  })
>  #else
>  /*
> @@ -46,10 +48,10 @@
>         ".option push\n\t"                                      \
>         ".option norvc\n\t"                                     \
>         "1:\t"                                                  \
> -       "lui    %[__ret],0x89abd\n\t"                           \
> -       "lui    %[__tmp],0x1234\n\t"                            \
> -       "addiw  %[__ret],%[__ret],-0x211\n\t"                   \
> -       "addiw  %[__tmp],%[__tmp],0x567\n\t"                    \
> +       "lui    %[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"          \
> +       "lui    %[__tmp], %%hi(" RUNTIME_MAGIC ")\n\t"          \
> +       "addiw  %[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t" \
> +       "addiw  %[__tmp],%[__tmp], %%lo(" RUNTIME_MAGIC ")\n\t" \
LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
