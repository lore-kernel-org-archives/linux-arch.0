From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Date: Sat, 3 May 2008 23:00:23 +0530
Message-ID: <20080503173023.GA2394@linux.vnet.ibm.com>
References: <1209832169.6929.42.camel@lappy> <20080503165511.GA21967@elte.hu>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765945AbYECRbd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080503165511.GA21967@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Guillaume Chazarain <guichaz@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Galbraith <efault@gmx.de>
List-Id: linux-arch.vger.kernel.org

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
