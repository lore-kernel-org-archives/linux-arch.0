Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:50658 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbXJVVfZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2007 17:35:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
Date: Mon, 22 Oct 2007 23:34:45 +0200
References: <20071020235546.GB1825@martell.zuzino.mipt.ru> <alpine.LFD.0.999.0710221254550.30120@woody.linux-foundation.org> <20071022130223.f7d75c31.akpm@linux-foundation.org>
In-Reply-To: <20071022130223.f7d75c31.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200710222334.45667.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, matthew@wil.cx, ralf@linux-mips.org, adobriyan@gmail.com, viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 22 October 2007, Andrew Morton wrote:
> It's almost always a bug to do spin_lock_irq() when local interrupts are
> disabled.  However iirc when we've tried to add runtime debugging to catch
> that, it triggered false-positives which made the idea unworkable.  I forget
> where.

I tried this as well a few years ago, and I think I hit a few places in
the early initialization, but nothing unfixable.

> However what we could do is to add a new
> spin_lock_irq_tell_me_if_i_goofed() which would perform that runtime check. 

How about the opposite? We could have a raw_spin_lock_irq() in places where
there are valid uses of spin_lock_irq() with irqs disabled and the same
for spin_unlock_irq with interrupts already enabled.

I can try to come up with a new implementation, including some rate-limiting,
which I think my first attempt was missing.

	Arnd <><
