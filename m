Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <429A605B.4050503@yahoo.com.au>
Date: Mon, 30 May 2005 10:37:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Lots of possible arch breakage in cpu_idle!!
References: <4299523F.90502@yahoo.com.au> <20050529165557.GA19922@twiddle.net>
In-Reply-To: <20050529165557.GA19922@twiddle.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Richard Henderson <rth@twiddle.net>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Richard Henderson wrote:
> On Sun, May 29, 2005 at 03:25:19PM +1000, Nick Piggin wrote:
> 
>>+++ linux-2.6/arch/alpha/kernel/process.c
> 
> ...
> 
>>+	set_thread_flag(TIF_POLLING_NRFLAG);
> 
> 
> Ok.
> 

Good.

> 
>>+			cpu_relax();
>>+		preempt_enable_no_resched();
>> 		schedule();
>>+		preempt_disable();
> 
> 
> Not ok.
> 
> 
>>+++ linux-2.6/arch/s390/kernel/smp.c	2005-05-29 14:21:42.000000000 +1000
>>@@ -528,6 +528,8 @@ extern void pfault_fini(void);
>> 
>> int __devinit start_secondary(void *cpuvoid)
>> {
>>+	preempt_disable();
> 
> 
> Not ok.
> 

I'll take it you meant:
+++ linux-2.6/arch/alpha/kernel/smp.c   2005-05-29 14:21:42.000000000 +1000

> Do not add the substring "preempt" to the alpha subtree.
> 

Sure. Thanks for the feedback.


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
