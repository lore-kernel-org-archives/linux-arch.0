Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from edna.telenet-ops.be ([195.130.132.58]:33477 "EHLO
	edna.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762526AbYBFNAU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Feb 2008 08:00:20 -0500
Date: Wed, 6 Feb 2008 14:00:16 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
In-Reply-To: <20080206111258.GA1742@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0802061359430.7370@anakin>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org>
 <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
 <20080206110425.GB25012@flint.arm.linux.org.uk> <20080206111258.GA1742@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, torvalds@linux-foundation.org, davidel@xmailserver.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de

On Wed, 6 Feb 2008, Heiko Carstens wrote:
> > Wasn't there a decision at a kernel summit that anything which adds
> > new syscalls should have a test program included so that architecture
> > maintainers can test the functionality on their architectures?
> > 
> > I seem to remember that it came up because the merged timerfd was a
> > pile of utter crap which didn't have a hope in hells chance of working.
> > 
> > So... where is the new timerfd test program?
> 
> As described in git commit 4d672e7ac79b5ec5cdc90e450823441e20464691 it's here:
> http://www.xmailserver.org/timerfd-test2.c
> I used it to test the s390 backend.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
