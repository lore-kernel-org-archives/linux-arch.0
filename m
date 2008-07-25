Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:61228 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYGYRMG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jul 2008 13:12:06 -0400
Date: Sat, 26 Jul 2008 01:27:31 +0900 (JST)
Message-ID: <20080726.012731.122621958.anemo@mba.ocn.ne.jp>
Subject: Re: [patch 29/29] initrd: Fix virtual/physical mix-up in overwrite
 test
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0807242032430.701@anakin>
References: <20080717191758.556975996@mail.of.borg>
	<20080725.003526.39154055.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0807242032430.701@anakin>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: geert@linux-m68k.org
Cc: ralf@linux-mips.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org
Message-ID: <20080725162731.ZBzdVF0PGQ8OpvFIo58gOE9ySieBkAewnLJgKGF-fUo@z>

On Thu, 24 Jul 2008 20:49:27 +0200 (CEST), Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Because an argument of mips virt_to_phys() is an pointer and
> > initrd_start is unsigned long.  It seems most (all?) arch's
> > virt_to_phys() casts its argument to unsigned long internally.  Should
> > mips follow?
> 
> Alternatively, as initrd_start is really a virtual kernel address,
> perhaps it should be changed from unsigned long to void * instead?
> 
> It's cast to `void *' in several place. arch/xtensa/kernel/setup.c even
> has `extern void *initrd_start' to fool around this?

I agree it would make code cleaner, but the conversion might be
somewhat hard.

If we converted initrd_start (and initrd_end) to void *, we should
also convert INITRD_START, free_initrd_mem(), some other arch specific
local/global variables and printk format strings.  Also code like
"initrd_start & PAGE_MASK" should be changed too...

Is it worth to do?

---
Atsushi Nemoto
