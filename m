From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/2] sched: INIT_PREEMPT_COUNT
Date: Sat, 11 Jul 2009 11:32:42 +0200
Message-ID: <1247304762.7529.51.camel@twins>
References: <20090710125755.559739294@chello.nl>
	 <20090710130125.037018244@chello.nl>
	 <200907101518.13894.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viefep15-int.chello.at ([62.179.121.35]:17363 "EHLO
	viefep15-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZGKJcx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jul 2009 05:32:53 -0400
In-Reply-To: <200907101518.13894.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu, tony.luck@intel.com, rth@twiddle.net, geert@linux-m68k.org

On Fri, 2009-07-10 at 15:18 -0600, Bjorn Helgaas wrote:
> On Friday 10 July 2009 06:57:56 am Peter Zijlstra wrote:
> > +#define INIT_PREEMPT_COUNT     (1)
> 
> If the parentheses are useful or necessary, I need to be
> educated about why.  They look like superfluous paranoia to me.

They are strictly speaking superfluous, but since I already knew I'd be
adding a term I added them.
