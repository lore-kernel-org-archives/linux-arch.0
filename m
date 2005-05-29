Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 29 May 2005 01:45:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <20050529084541.GL2057@holomorphy.com>
References: <4299523F.90502@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4299523F.90502@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 29, 2005 at 03:25:19PM +1000, Nick Piggin wrote:
> sparc - IRQs on at this point(?), change local_irq_save to _disable.
>       - Changed idle loop so don't go to schedule() if pm_idle is NULL!
>       - set TIF_POLLING_NRFLAG for SMP.
>       - TODO: needs secondary CPUs to disable preempt (See #1)

I feel like fiddling with the details of the patch; which tree should I
snarf to ship a diff against?


-- wli
