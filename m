Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56563 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861AbZDCBtO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2009 21:49:14 -0400
Date: Thu, 2 Apr 2009 18:43:08 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 143/166] preadv/pwritev: Add preadv and pwritev system
 calls.
In-Reply-To: <200904022359.n32NxNYu022834@imap1.linux-foundation.org>
Message-ID: <alpine.LFD.2.00.0904021839390.15441@localhost.localdomain>
References: <200904022359.n32NxNYu022834@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kraxel@redhat.com, arnd@arndb.de, "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, ralf@linux-mips.org, tglx@linutronix.de, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20090403014308.wCDDzE9tCmTRsOPIGXUvkd7ZpXBqtn35-o28J1tid_s@z>



On Thu, 2 Apr 2009, akpm@linux-foundation.org wrote:
>
> glibc entriely and use a syscall prototype which works without
> arch-specific wrappers inside the kernel: The offset argument is
> explicitly split into two 32bit values.

Grr. That may make sense on 32-bit architectures, but makes no sense 
what-so-ever on 64-bit ones.

Why not just say that it's two "unsigned long" arguments, and split it by 
"sizeof unsigned long". And then, on 64-bit architectures, the high bits 
can be ignored. You can even get gcc to optimize it all away by doing 
something like

	#define HALF_LONG (BITS_IN_LONG / 2)

	offset = (((loff_t)high << HALF_LONG) << HALF_LONG) | low;

and then gcc should automaticaly notice that shifting up that way is just 
a fancy way of saying "0", and ignore the high bits.

How married are people to this crazy 2x "32 bits" model?

			Linus
