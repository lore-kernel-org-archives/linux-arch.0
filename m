From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Mon, 26 May 2008 21:20:10 -0700
Message-ID: <20080526212010.664302cf@infradead.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<adad4n82xud.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:32813 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbYE0E1O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 00:27:14 -0400
In-Reply-To: <adad4n82xud.fsf@cisco.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: David Miller <davem@davemloft.net>, benh@kernel.crashing.org, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com

On Mon, 26 May 2008 21:08:10 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > either via sparse or some fancy lockdep like "device store" thing?
>  > If we can't test for it and it doesn't show up on x86 ... it'll
>  > just be an eterrnal chase.
> 
> Ben's point is that it will start showing up on x86 because newer
> compilers are reordering things...
> 
>  - R.


I know a basic reorder will show up there. A simple "barrier()" in
readl/writel solves it for x86. Understandably, Ben doesn't really like
that answer ;-)

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
