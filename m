Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:44506 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965163AbWIEGO7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 02:14:59 -0400
Subject: Re: [PATCH 3/9] actual generic PAGE_SIZE infrastructure
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200609050749.07639.arnd@arndb.de>
References: <20060901190805.C906A21A@localhost.localdomain>
	 <20060901190807.522EDD97@localhost.localdomain>
	 <1157434085.2413.22.camel@shinybook.infradead.org>
	 <200609050749.07639.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 23:14:33 -0700
Message-Id: <1157436875.4457.16.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-05 at 07:49 +0200, Arnd Bergmann wrote:
> linux-libc-headers apparently exported something anyway, in the form
> of
> 
> #include <unistd.h>
> #define PAGE_SIZE ((unsigned long)getpagesize())
> #define PAGE_SHIFT ((PAGE_SIZE > 65536) ? -1 : ((unsigned long[]){12,13,14,-1,15,-1,-1,-1,16}[PAGE_SIZE>>13]))
> #define PAGE_MASK    (~(PAGE_SIZE-1))
> 
> This looks like a reasonable implementation, I wonder if we should
> have something like this in the #ifndef __KERNEL__ part of
> asm-generic/page.h.

No. Userspace should be using getpagesize() or sysconf(). There's no
reason for us to be exporting PAGE_SIZE. It isn't a constant, and we
shouldn't #define it as if it is.


In general, the previous attempts at cleaning up kernel headers haven't
gone far enough -- they've tended to include far too much crap that
should have just been removed. 

I understand the reasoning behind that -- they (we) didn't want to
remove _too_ much of the stuff that people could access if they abused
the kernel headers directly -- because the distributions using the
cleaned set of headers didn't want to be inundated with complaints about
breaking programs which compiled OK elsewhere.

Part of the benefit of producing a canonical set of kernel headers
directly from the kernel is that we don't have the same motivation to
include every piece of cruft and pander to every abuse of headers that
somebody else might include/allow. We can start to impose some kind of
control on what we provide.

We've already discussed the broken and redundant _syscallX() today.
PAGE_SIZE is another in fairly much the same category. We have no reason
to export it -- userspace should just be using getpagesize() or
sysconf(). So let's not export it.

-- 
dwmw2

