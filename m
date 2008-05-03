Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:38451 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762893AbYECRbW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 May 2008 13:31:22 -0400
Date: Sat, 3 May 2008 23:00:23 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Message-ID: <20080503173023.GA2394@linux.vnet.ibm.com>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
References: <1209832169.6929.42.camel@lappy> <20080503165511.GA21967@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080503165511.GA21967@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Guillaume Chazarain <guichaz@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Galbraith <efault@gmx.de>
Message-ID: <20080503173023.ahAYmA9b3l5r-45P_5sLtMaK4UsiB7O2t-OGCgGcjRk@z>

On Sat, May 03, 2008 at 06:55:11PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > it _DOESN'T_ boot ;-/ [...]
> 
> FYI, the merged version against sched-devel.git does boot fine here and 
> the clock does seem to advance as expected.
> 

boots here against linus as well.

> 	Ingo

-- 
regards,
Dhaval
