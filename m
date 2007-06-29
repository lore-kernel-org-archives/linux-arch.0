Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:57522 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbXF2Fcv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Jun 2007 01:32:51 -0400
Message-ID: <46849948.7010907@goop.org>
Date: Fri, 29 Jun 2007 01:31:52 -0400
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cross-architecture ELF clean up
References: <20070620230854.246399397@goop.org>	<20070620230902.387008536@goop.org> <18052.34556.48421.672836@cargo.ozlabs.ibm.com>
In-Reply-To: <18052.34556.48421.672836@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Aubrey Li <aubrey.li@analog.com>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andi Kleen <ak@suse.de>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Matthew Wilcox <matthew@wil.cx>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Miles Bader <uclinux-v850@lsi.nec.co.jp>, Chris Zankel <chris@zankel.net>
List-ID: <linux-arch.vger.kernel.org>

Paul Mackerras wrote:
> No, it's because the bootwrapper is not part of the kernel and does
> not use kernel headers.  The aim is that the bootwrapper can be built
> and used outside the kernel source tree, so it needs its own copies of
> any headers that aren't in /usr/include.
>   

Hm, I see.  But <elf.h> is generally available, isn't it?

    J
