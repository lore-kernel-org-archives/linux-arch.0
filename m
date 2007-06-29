Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:33730 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbXF2ENz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Jun 2007 00:13:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18052.34556.48421.672836@cargo.ozlabs.ibm.com>
Date: Fri, 29 Jun 2007 14:13:48 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] cross-architecture ELF clean up
In-Reply-To: <20070620230902.387008536@goop.org>
References: <20070620230854.246399397@goop.org>
	<20070620230902.387008536@goop.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Aubrey Li <aubrey.li@analog.com>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andi Kleen <ak@suse.de>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Matthew Wilcox <matthew@wil.cx>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Miles Bader <uclinux-v850@lsi.nec.co.jp>, Chris Zankel <chris@zankel.net>
List-ID: <linux-arch.vger.kernel.org>

Jeremy Fitzhardinge writes:

>   powerpc also appears to have its own duplicate copy of elf.h in
>   arch/powerpc/boot/elf.h; presumably because the standard elf.h
>   brings in too much.  Update it to just linux/elf-defn.h, which
>   should be fine.

No, it's because the bootwrapper is not part of the kernel and does
not use kernel headers.  The aim is that the bootwrapper can be built
and used outside the kernel source tree, so it needs its own copies of
any headers that aren't in /usr/include.

Paul.
