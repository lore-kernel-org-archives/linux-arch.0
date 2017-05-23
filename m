From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v4 1/2] asm-generic/bug.h: declare struct pt_regs; before function prototype
Date: Tue, 23 May 2017 20:44:43 +0200
Message-ID: <xa1twp972z1g.fsf@mina86.com>
References: <20170523160112.3446-1-abbotti@mev.co.uk> <20170523160112.3446-2-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37006 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933479AbdEWSor (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2017 14:44:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id d127so37908606wmf.0
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2017 11:44:46 -0700 (PDT)
In-Reply-To: <20170523160112.3446-2-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>, Ian Abbott <abbotti@mev.co.uk>

On Tue, May 23 2017, Ian Abbott wrote:
> The declaration of `__warn()` has `struct pt_regs *regs` as one of its
> parameters.  This can result in compiler warnings if `struct regs` is
> not already declared.  Add an empty declaration of `struct pt_regs` to
> avoid the warnings.
>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
> v3: Actually, there was no v1 or v2.  I called this v3 to match the
> series.
> v4: Corrected 'Acked-by:' line in patch description.
> ---
>  include/asm-generic/bug.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index d6f4aed479a1..87191357d303 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -97,6 +97,7 @@ extern void warn_slowpath_null(const char *file, const =
int line);
>=20=20
>  /* used internally by panic.c */
>  struct warn_args;
> +struct pt_regs;
>=20=20
>  void __warn(const char *file, int line, void *caller, unsigned taint,
>  	    struct pt_regs *regs, struct warn_args *args);

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=83=
=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
