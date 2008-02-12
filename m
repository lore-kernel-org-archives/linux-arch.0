Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50066 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758117AbYBLQgb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 11:36:31 -0500
Message-ID: <47B1CB08.4020101@garzik.org>
Date: Tue, 12 Feb 2008 11:36:24 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
References: <20080211203146.3d28d1a0@laptopd505.fenrus.org>	<20080212044314.GA4888@kroah.com>	<20080211211751.3e265754@laptopd505.fenrus.org> <20080211.221126.230471463.davem@davemloft.net>
In-Reply-To: <20080211.221126.230471463.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: arjan@infradead.org, greg@kroah.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

David Miller wrote:
> This is why, with the networking, we've just tossed all of the network
> driver stuff in there too.  I can rebase freely, remove changesets,
> rework them, etc. and this causes a very low amount of pain for Jeff
> Garzik and John Linville.


s/very low/not low/

Rebasing is always a pain, and John and I both agreed the other day that 
you do it too often.

I've complained about this before, too...  but figured this was just 
another thing I was getting ignored on, and so life moved on.  But don't 
try to sell rebasing as "low pain".

Rebasing makes the history all nice and pretty, but by totalling 
flattening the history, trashing all the commit ids (and rewriting 
associated metadata), you create obvious downstream problems.

Rebasing is  low impact only if you don't have git downstream people. 
Otherwise, you're just treating it as a useful quilt clone, really.

	Jeff



