From: Willy Tarreau <w@1wt.eu>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 17:52:19 +0100
Message-ID: <20151123165219.GD768@1wt.eu>
References: <5868782.RxZY0W5S4d@wuerfel> <20151123163359.GC768@1wt.eu> <20151123163750.GT8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33122 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbbKWQws (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Nov 2015 11:52:48 -0500
Content-Disposition: inline
In-Reply-To: <20151123163750.GT8644@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, josh@joshtriplett.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org

On Mon, Nov 23, 2015 at 04:37:50PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2015 at 05:33:59PM +0100, Willy Tarreau wrote:
> > I think you could do better by simply calling panic("BUG!") instead as
> > BUG() does. It will avoid the printk() call and pushing the file/line
> > number onto the stack. It will also probably not inflate the rodata this
> > way.
> 
> Does that not depend on the architectures BUG() implementation?  If an
> architecture implements it as a signalling illegal instruction and a
> lookup table, changing it to be a panic() would probably be more code.

That's a very good point, I didn't think about it and yes I think you're
right then (eg: when CONFIG_DEBUG_BUGVERBOSE is not set, x86 and arm will
only emit a single instruction).

Best regards,
Willy
