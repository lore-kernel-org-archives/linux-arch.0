From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Wed, 13 Jan 2010 21:15:13 +0100
Message-ID: <10f740e81001131215y6f15b25bq3bfa2ce2cea164a9@mail.gmail.com>
References: <20100113193923.22272.87546.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41807 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab0AMUPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2010 15:15:19 -0500
Received: by pzk1 with SMTP id 1so7592139pzk.33
        for <linux-arch@vger.kernel.org>; Wed, 13 Jan 2010 12:15:18 -0800 (PST)
In-Reply-To: <20100113193923.22272.87546.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org

On Wed, Jan 13, 2010 at 20:39, David Howells <dhowells@redhat.com> wrot=
e:
> diff --git a/include/asm-generic/bitops/fls64.h b/include/asm-generic=
/bitops/fls64.h
> index b097cf8..f81e04c 100644
> --- a/include/asm-generic/bitops/fls64.h
> +++ b/include/asm-generic/bitops/fls64.h
> @@ -18,16 +18,25 @@
> =C2=A0static __always_inline int fls64(__u64 x)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 h =3D x >> 32;
> - =C2=A0 =C2=A0 =C2=A0 if (h)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fls(h) + 32=
;
> - =C2=A0 =C2=A0 =C2=A0 return fls(x);
> + =C2=A0 =C2=A0 =C2=A0 int bitpos =3D -1;
> +
> + =C2=A0 =C2=A0 =C2=A0 asm("bsrl =C2=A0 =C2=A0 =C2=A0 %1,%0 =C2=A0 \n=
"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "subl =C2=A0 =C2=A0 =C2=A0 %2,%0=
 =C2=A0 \n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "bsrl =C2=A0 =C2=A0 =C2=A0 %3,%0=
 =C2=A0 \n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : "+r" (bitpos)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : "rm" (x), "i"(32), "rm" (h));
> +
> + =C2=A0 =C2=A0 =C2=A0 return bitpos + 33;
> =C2=A0}
> =C2=A0#elif BITS_PER_LONG =3D=3D 64
> =C2=A0static __always_inline int fls64(__u64 x)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (x =3D=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> - =C2=A0 =C2=A0 =C2=A0 return __fls(x) + 1;
> + =C2=A0 =C2=A0 =C2=A0 long bitpos =3D -1;
> +
> + =C2=A0 =C2=A0 =C2=A0 asm("bsrq %1,%0"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : "+r" (bitpos)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : "rm" (x));
> + =C2=A0 =C2=A0 =C2=A0 return bitpos + 1;
> =C2=A0}
> =C2=A0#else
> =C2=A0#error BITS_PER_LONG not 32 or 64

Why do you put x86 assembler in asm-generic? Those files are supposed
to be platform-agnostic.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
