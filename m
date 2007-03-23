Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:35049 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933862AbXCWRvu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Mar 2007 13:51:50 -0400
Date: Fri, 23 Mar 2007 18:51:49 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: + move-die-notifier-handling-to-common-code.patch added to -mm tree
Message-ID: <20070323175148.GA12158@lst.de>
References: <200703212211.l2LMB08x005006@shell0.pdx.osdl.net> <20070321221748.GD28239@flint.arm.linux.org.uk> <20070321155953.6352e29f.akpm@linux-foundation.org> <20070322100117.GC29627@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070322100117.GC29627@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, hch@lst.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 22, 2007 at 10:01:17AM +0000, Russell King wrote:
> It seems that breaking ARM builds is all the rage; they've broken
> three times during this cycle due to peoples dumb untested patches,
> and with the restrictions Linus placed on my merging it's painful
> to keep resolving these issues one week or so after they happen.

I don't think Linus puts limits on your merging, you're just too
unfleible to send him the right patches.  Secondary architectures
do get broken once in a while, and other maintainers can cope
with that just fine.  That's of course not an excuse for this
breakage, as you might have notices I actually did steps to
prevent arm breakage and just got it wrong.

> Folk *need* to spend more time testing their work before submitting
> it upstream.  Merely building the ARM defconfig would've found this
> error.

There is no arm defconfig.  And the various board configs are totally
outdated aswell.  I just tried to build five of them and all of them
haven;'t been updated for ages and need answering of a gazillion
questions during make oldconfig.

