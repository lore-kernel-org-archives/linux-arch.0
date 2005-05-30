Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <429AF694.4080104@yahoo.com.au>
Date: Mon, 30 May 2005 21:18:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Lots of possible arch breakage in cpu_idle!!
References: <OF7BE04D3C.BB28882F-ONC1257011.003BCCE8-C1257011.003C987D@de.ibm.com>
In-Reply-To: <OF7BE04D3C.BB28882F-ONC1257011.003BCCE8-C1257011.003C987D@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <czankel@tensilica.com>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Martin Schwidefsky wrote:
> Hi Nick,
> 
> 
>>s390 - local irq disable before checking need_resched doesn't gain
>>        anything (removed, OK?)
> 
> 
> Well, currently there seems to be only the pfault interrupt that can
> set TIF_NEED_RESCHED and pfault interrupts can't happen for idle. So
> it should work. But if there is any chance that an interrupt will ever
> set TIF_NEED_RESCHED we have to disable the interrupts before doing
> the resched check.

But other processors can set your TIF_NEED_RESCHED too,
so simply disabling local interrupts does not give any
synchronisation of TIF_NEED_RESCHED.

What it can give is a guarantee that some interrupt will
get queued and not processed. This can be used to sleep
the processor until the next interrupt (because when the
other CPU sets TIF_NEED_RESCHED it will also send an IPI).
Now it could well be that this is what you need, in which
case I'm wrong.

However:

   local_irq_disable();
   if (need_resched()) {
     local_irq_enable();
     return;
   }

   /* need_resched() can become true here */

   [... do stuff ...]

Basically you just cut your losses and pick up the
need_resched() when you get around to testing it again.

> As I implemented this I wanted to make absolutly
> sure that we don't miss any reschedule. It works the way it is and
> the additional cycles in idle() for local_irq_disable/local_irq_enable
> won't hurt. I don't see the benefit of the change. Only chances that
> it might break something we haven't thought of.
> 

No, it doesn't hurt (well, it may slightly slow down your
interrupt processing rate, but who's counting!).

However, I would like to try to tighten things up in this
area a bit if possible now that we're looking at it.

Thanks very much,
Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
