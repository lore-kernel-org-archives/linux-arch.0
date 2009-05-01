From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 14:53:31 +0200
Message-ID: <200905011453.32006.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <49FAEA2A.50504@monstr.eu> <20090501123728.GC27799@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:61798 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbZEAMxo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 08:53:44 -0400
In-Reply-To: <20090501123728.GC27799@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Russell King wrote:
> > > All of these are either PC-specific, or they don't actually care
> > > about the specific value. Most architectures just use the
> > > value from the IBM PC, so we might as well make that the generic
> > > default.
> > 
> > ok. Let's move out from arch to generic location.
> 
> That's only possible once the users have been fixed - otherwise the ARM
> stuff listed above _will_ break.

My idea was to just add a fallback of

#ifndef CLOCK_TICK_RATE
#define CLOCK_TICK_RATE                1193182
#endif

to include/linux/timex.h. Since al existing architectures already define
CLOCK_TICK_RATE as a macro, I don't see anything changing for them.

The only difference would be that all architectures that use the default
value can have an empty timex.h.

Am I missing something?

	Arnd <><
