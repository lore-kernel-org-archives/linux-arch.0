Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be ([80.88.33.193]:20398 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265665AbUEZQo3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2004 12:44:29 -0400
Date: Wed, 26 May 2004 18:43:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: arch-specific "make" target
In-Reply-To: <20040526163230.GA30047@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0405261840160.28417@waterleaf.sonytel.be>
References: <40B4C2FB.5040101@pobox.com> <20040526163230.GA30047@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 26 May 2004, Ralf Baechle wrote:
> On Wed, May 26, 2004 at 12:16:59PM -0400, Jeff Garzik wrote:
> > I just wanted to confirm that all architectures generate a bootable
> > kernel image -- not just vmlinux -- then the developer types "make" with
> > no arguments.
> >
> > This is the 2.6 kernel standard, but I just got word that some arches
> > don't follow this rule yet...
>
> MIPS does so for those system that can't boot the vanilla vmlinux file.
> Most current systems support direct loading of ELF binaries though.

Same for m68k: all systems have a bootstrap that can boot (gzipped) ELF
images (vmlinux and vmlinux.gz). Some are even rumoured to boot bzipped ELF
images (vmlinuz.bz2).

make all -> vmlinux, vmlinux.gz
make zImage -> vmlinux.gz
make bzImage -> vmlinux.bz2

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
