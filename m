Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267276AbUHOXre@vger.kernel.org>
Received: from i-194-106-37-22.freedom2surf.net ([194.106.37.22]:5760 "EHLO
	shirehall.home.oldelvet.org.uk") by vger.kernel.org with ESMTP
	id S267272AbUHOXrS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 15 Aug 2004 19:47:18 -0400
Subject: Re: Using get_cycles for add_timer_randomness
From: Richard Mortimer <richm@oldelvet.org.uk>
In-Reply-To: <20040815154821.2d6edb03.akpm@osdl.org>
References: <200308160303.17612.arnd@arndb.de>
	 <20040810162435.GK24690@krispykreme> <20040814183623.GB5637@krispykreme>
	 <20040815154821.2d6edb03.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092613609.4169.22.camel@duncow>
Mime-Version: 1.0
Date: Mon, 16 Aug 2004 00:46:50 +0100
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: richm@oldelvet.org.uk, Anton Blanchard <anton@samba.org>, arnd@arndb.de, tytso@mit.edu, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2004-08-15 at 23:48, Andrew Morton wrote: 
> Things have changed a bit - sparc now has special-case code in there too. 
> Hopefully we can remove that now.
That came from Dave M & me before Anton remembered Arnd's patch. It can
be removed with the new patch applied.

> Is everyone OK with this?
I certainly am. I have tried the patch on sparc64 (albeit on 2.4.26) and
get similar results to Anton.

Richard

> 
> From: Anton Blanchard <anton@samba.org>
> 
> I tested how long it took to do a dd from /dev/random on ppc64 before and
> after this patch, while doing a ping flood from another machine.
> 
> before:
> # /usr/bin/time dd if=/dev/random of=/dev/zero count=1k
> 0+51 records in
> Command terminated by signal 2
> 0.00user 0.00system 19:18.46elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
> 
> I gave up after 19 minutes.
> 
> after:
> # /usr/bin/time dd if=/dev/random of=/dev/zero count=1k
> 0+1024 records in
> 0.00user 0.00system 0:33.38elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
> 
> Just over 33 seconds. Better.
> _

-- 
richm@oldelvet.org.uk
