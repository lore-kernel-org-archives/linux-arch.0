Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42999381.2070800@yahoo.com.au>
Date: Sun, 29 May 2005 20:03:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Lots of possible arch breakage in cpu_idle!!
References: <4299523F.90502@yahoo.com.au> <20050529084541.GL2057@holomorphy.com>
In-Reply-To: <20050529084541.GL2057@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III wrote:
> On Sun, May 29, 2005 at 03:25:19PM +1000, Nick Piggin wrote:
> 
>>sparc - IRQs on at this point(?), change local_irq_save to _disable.
>>      - Changed idle loop so don't go to schedule() if pm_idle is NULL!
>>      - set TIF_POLLING_NRFLAG for SMP.
>>      - TODO: needs secondary CPUs to disable preempt (See #1)
> 
> 
> I feel like fiddling with the details of the patch; which tree should I
> snarf to ship a diff against?
> 

Hmm, it is against the latest -mm, with a couple of patches
backed out and one or two others applied :P

If you are just interested in looking at the arch code, I think
that should apply to any recent tree.

Otherwise, let me know off list.
Send instant messages to your online friends http://au.messenger.yahoo.com 
