Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49536
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932795AbWLaFXj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 31 Dec 2006 00:23:39 -0500
Date: Sat, 30 Dec 2006 21:23:38 -0800 (PST)
Message-Id: <20061230.212338.92583434.davem@davemloft.net>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061230224604.GA3350@flint.arm.linux.org.uk>
References: <20061230165012.GB12622@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
	<20061230224604.GA3350@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: rmk+lkml@arm.linux.org.uk
Cc: torvalds@osdl.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sat, 30 Dec 2006 22:46:04 +0000

> iirc, flush_anon_page() was introduced to fix non-working fuse on parisc,
> which occurs because fuse wants to use get_user_pages() to read data from
> the current processes memory space.
> 
> get_user_pages() contains a call to flush_dcache_page(), whose behaviour
> is defined for shared mappings.  Anonymous pages are unspecified.  It
> appears that flush_anon_page() was introduced to correct this oversight.

Sparc64 flushes anonymous pages too when flush_dcache_page() is
called on such pages.  It only tries to "defer" flushes for
pages which have a non-NULL page_mapping().  For NULL page_mapping()
we just flush immediately.

This works on sparc64, as sort of hinted by Linus, because we can
flush by physical page on sparc64.  I guess the lack of ability to
do that is why PARISC and ARM don't do that too.

For the ptrace() cases we created the copy_{to,from}_user_page()
interfaces.  So that when you access data inside of pages obtained via
a get_user_pages() call, you are supposed to use those two interfaces
so that everything works out right.

Therefore, FUSE probably could have been fixed by judicious use
of copy_{to,from}_user_page() calls instead of adding this new
ad-hoc flush_anon_page() thing.
