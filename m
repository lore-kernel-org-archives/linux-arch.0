From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Wed, 10 Dec 2008 12:03:14 +0100
Message-ID: <20081210110314.GA25779@one.firstfloor.org>
References: <20081205.002701.172921476.davem@davemloft.net> <20081205084233.GE2030@elte.hu> <87ej0mx0c0.fsf@basil.nowhere.org> <20081205.120814.51226316.davem@davemloft.net> <20081210034824.GA27217@linux-sh.org> <20081210102819.GF23556@one.firstfloor.org> <20081210102335.GA30942@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34323 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbYLJKvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Dec 2008 05:51:38 -0500
Content-Disposition: inline
In-Reply-To: <20081210102335.GA30942@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, mingo@elte.hu, a.p.zijlstra@chello.nl, paulus@samba.org, tglx@linutronix.deli

On Wed, Dec 10, 2008 at 07:23:36PM +0900, Paul Mundt wrote:
> On Wed, Dec 10, 2008 at 11:28:19AM +0100, Andi Kleen wrote:
> > > Oprofile has been a pretty bad fit for them, and while I'm slightly more
> > 
> > You could always use a extension of timer mode that reads them
> > periodically? 
> > 
> This is what I do today, but it is not an ideal solution. It would be
> nice if these sorts of use cases could be supported by newer frameworks
> without every platform with similar requirements having to implement
> workarounds hanging off of the timer IRQ.

But you shouldn't hang off the timer irq anyways, but better use a regular
timer or hr timer. This would give more regular sampling even with dyntick.
And doing such a timer is only a few lines of code, I'm not sure it would
buy you all that much to generalize it.

-Andi

-- 
ak@linux.intel.com
