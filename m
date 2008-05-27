From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 09:24:30 +0100
Message-ID: <20080527092430.6380d962@core>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45050 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757449AbYE0IlY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 04:41:24 -0400
In-Reply-To: <20080526.192812.184590464.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com

> It's just another complicated thing for driver authors to get wrong.
> The other side of the coin is of course the cost.
> 
> The only thing I am absolutely sure of is that we should make a
> decision fast, document it, and just stick to it.

It's unfortunate that the __read/___write versions have other different
semantics. The default should definitely be ordered but having un-ordered
ones as an option would be good for zapping the hot paths that matter.

Most I/O paths aren't even worth the thinking time for non-ordered I/O.

Alan
