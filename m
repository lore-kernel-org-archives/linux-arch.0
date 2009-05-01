From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 14:14:14 +0100
Message-ID: <20090501141414.4adfe4ab@lxorguk.ukuu.org.uk>
References: <cover.1241105648.git.arnd@arndb.de>
	<49FAEA2A.50504@monstr.eu>
	<20090501123728.GC27799@flint.arm.linux.org.uk>
	<200905011453.32006.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43606 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbZEANNa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 09:13:30 -0400
In-Reply-To: <200905011453.32006.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

> #ifndef CLOCK_TICK_RATE
> #define CLOCK_TICK_RATE                1193182
> #endif
> 
> to include/linux/timex.h. Since al existing architectures already define
> CLOCK_TICK_RATE as a macro, I don't see anything changing for them.
> 
> The only difference would be that all architectures that use the default
> value can have an empty timex.h.
> 
> Am I missing something?

Currently if you create a new architecture you have to figure out what
your equivalent tick rate is or you get an error for not defining it.
Ditto if you try to build code using it on platforms that it is
meaningless (eg S/390) you get an error.

You'd lose that rather useful property.

Alan
