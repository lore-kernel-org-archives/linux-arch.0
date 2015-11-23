From: Willy Tarreau <w@1wt.eu>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 18:04:56 +0100
Message-ID: <20151123170456.GE768@1wt.eu>
References: <5868782.RxZY0W5S4d@wuerfel> <20151123163359.GC768@1wt.eu> <20151123163750.GT8644@n2100.arm.linux.org.uk> <4150271.zrLzq08T60@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33127 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbbKWRFY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Nov 2015 12:05:24 -0500
Content-Disposition: inline
In-Reply-To: <4150271.zrLzq08T60@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, josh@joshtriplett.org

On Mon, Nov 23, 2015 at 05:52:38PM +0100, Arnd Bergmann wrote:
> On Monday 23 November 2015 16:37:50 Russell King - ARM Linux wrote:
> > On Mon, Nov 23, 2015 at 05:33:59PM +0100, Willy Tarreau wrote:
> > > I think you could do better by simply calling panic("BUG!") instead as
> > > BUG() does. It will avoid the printk() call and pushing the file/line
> > > number onto the stack. It will also probably not inflate the rodata this
> > > way.
> > 
> > Does that not depend on the architectures BUG() implementation?  If an
> > architecture implements it as a signalling illegal instruction and a
> > lookup table, changing it to be a panic() would probably be more code.
> 
> Correct, overall, we are down to a 1.40% size reduction compared to
> 1.70% without my patch and 1.49% with my version:
> 
> section     CONFIG_BUG=y    CONFIG_BUG=n    CONFIG_BUG=n+patch    panic("BUG!")
> 
>  .text            8320248   |     8180944   |     8207688	|  8221848
>  .rodata          3633720   |     3567144   |     3570648	|  3567344
>  __bug_table        32508   |         ---   |         ---	|      ---
>  __modver             692   |        1584   |        2176	|     1384
>  .init.text        558132   |      548300   |      550088	|   550592
>  .exit.text         12380   |       12256   |       12380	|    12448
>  .data            1016672   |     1016064   |     1016128	|  1016064
>  Total           14622556   |    14374510   |    14407326	| 14417898

Thanks for testing :-)

Willy
