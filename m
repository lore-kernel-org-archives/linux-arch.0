From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/30] sysinfo: Use explicit types in <linux/sysinfo.h>
Date: Mon, 20 Feb 2012 13:12:34 +0100
Message-ID: <CAMuHMdV2-StqLjnMXk8EDbfMSUik7BWuQ1phNSoUq_D0i_1icQ@mail.gmail.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
	<1329696488-16970-7-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:62104 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2BTMMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2012 07:12:36 -0500
In-Reply-To: <1329696488-16970-7-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

On Mon, Feb 20, 2012 at 01:07, H. Peter Anvin <hpa@zytor.com> wrote:
> --- a/include/linux/sysinfo.h
> +++ b/include/linux/sysinfo.h
> @@ -1,22 +1,24 @@
> =C2=A0#ifndef _LINUX_SYSINFO_H
> =C2=A0#define _LINUX_SYSINFO_H
>
> +#include <linux/types.h>
> +
> =C2=A0#define SI_LOAD_SHIFT =C2=A016
> =C2=A0struct sysinfo {
> - =C2=A0 =C2=A0 =C2=A0 long uptime; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Seconds since boot */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long loads[3]; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* 1, 5, and 15 minute load averages */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long totalram; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Total usable main memory size */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long freeram; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Available memory size */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long sharedram; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Amount of shared memory */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long bufferram; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Memory used by buffers */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long totalswap; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Total swap space size */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long freeswap; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* swap space still available */
> - =C2=A0 =C2=A0 =C2=A0 unsigned short procs; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Number of current processes */
> - =C2=A0 =C2=A0 =C2=A0 unsigned short pad; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* explicit padding for m68k */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long totalhigh; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Total high memory size */
> - =C2=A0 =C2=A0 =C2=A0 unsigned long freehigh; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Available high memory size */
> - =C2=A0 =C2=A0 =C2=A0 unsigned int mem_unit; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Memory unit size in bytes */
> - =C2=A0 =C2=A0 =C2=A0 char _f[20-2*sizeof(long)-sizeof(int)]; /* Pad=
ding: libc5 uses this.. */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_long_t uptime; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Seconds since boot */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t loads[3]; =C2=A0 =C2=A0 =C2=A0=
/* 1, 5, and 15 minute load averages */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t totalram; =C2=A0 =C2=A0 =C2=A0=
/* Total usable main memory size */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t freeram; =C2=A0 =C2=A0 =C2=A0=
 /* Available memory size */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t sharedram; =C2=A0 =C2=A0 /* A=
mount of shared memory */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t bufferram; =C2=A0 =C2=A0 /* M=
emory used by buffers */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t totalswap; =C2=A0 =C2=A0 /* T=
otal swap space size */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t freeswap; =C2=A0 =C2=A0 =C2=A0=
/* swap space still available */
> + =C2=A0 =C2=A0 =C2=A0 __u16 procs; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Number of current processes */
> + =C2=A0 =C2=A0 =C2=A0 __u16 pad; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Explicit padding for m68k *=
/

=46ueling the discussion about natural vs. 4-byte alignment?

> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t totalhigh; =C2=A0 =C2=A0 /* T=
otal high memory size */
> + =C2=A0 =C2=A0 =C2=A0 __kernel_ulong_t freehigh; =C2=A0 =C2=A0 =C2=A0=
/* Available high memory size */
> + =C2=A0 =C2=A0 =C2=A0 __u32 mem_unit; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* Memory unit size in bytes */
> + =C2=A0 =C2=A0 =C2=A0 char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(_=
_u32)]; =C2=A0 /* Padding: libc5 uses this.. */
> =C2=A0};

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
