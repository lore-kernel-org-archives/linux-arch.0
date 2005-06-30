Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42C33A01.4000302@yahoo.com.au>
Date: Thu, 30 Jun 2005 10:17:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Remaining arch problems in cpu_idle
References: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B84D@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B84D@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, David Mosberger <davidm@hpl.hp.com>
List-ID: <linux-arch.vger.kernel.org>

Luck, Tony wrote:
>>I don't suppose safe_halt can be called with interrupts off
>>safely, like the i386 function of the same name?
> 
> 
> Yes.  Looking at the code for safe_halt() [chasing through
> ia64_do_halt_light() to PAL_CALL() to ia64_pal_call_static] I see
> that we disable interrupts before calling into the PAL, and restore
> the state after we return.  So somewhere in the depths of the PAL
> code the cpu is checking to see whether an external interrupt is
> pending, even though we have interrupts blocked.
> 

OK, in which case we should be able to disable interrupts before
checking need_resched() ?

Something like the following:

  void
  default_idle (void)
  {
-       while (!need_resched())
-               if (can_do_pal_halt)
-                       safe_halt();
-               else
+       if (can_do_pal_halt) {
+               while (!need_resched()) {
+                       local_irq_disable();
+                       if (!need_resched())
+                               safe_halt();
+                       local_irq_enable();
+       } else {
+               while (!need_resched())
                         cpu_relax();
+       }
  }



-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
