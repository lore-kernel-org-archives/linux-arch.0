From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Fri, 18 Dec 2009 09:21:30 +0900
Message-ID: <20091218091901J.fujita.tomonori@lab.ntt.co.jp>
References: <20091217163036.GE2123@thunk.org>
	<alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
	<20091217173957.GG2123@thunk.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:39834 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZLRAW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Dec 2009 19:22:29 -0500
In-Reply-To: <20091217173957.GG2123@thunk.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tytso@mit.edu
Cc: torvalds@linux-foundation.org, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, hch@infradead.org, linux-arch@vger.kernel.org, jens.axboe@oracle.com

On Thu, 17 Dec 2009 12:39:57 -0500
tytso@mit.edu wrote:

> On Thu, Dec 17, 2009 at 08:46:33AM -0800, Linus Torvalds wrote:
> > kmalloc() memory should be ok. It's backed by "real pages". Doing the DMA 
> > translations for such pages is trivial and fundamental.
> 
> Sure, but there's some rumors/oral traditions going around that some
> block devices want bio address which are page aligned, because they
> want to play some kind of refcounting game, and if you pass them a
> kmalloc() memory, they will explode in some interesting and
> entertaining way.  And it's Weird Shit(tm) (aka iSCSI, AoE) type
> drivers, that most of us don't have access to, so just because it
> works Just Fine on SATA doesn't mean anything.

iSCSI initiator driver should work with kmalloc'ed memory.

The reason why iSCSI didn't work with kmalloc'ed memory is that it
uses sendpage (which needs refcountable pages). We added a workaround
to not use sendpage with kmalloc'ed memory (it would be great if we
remove the workaround though).
