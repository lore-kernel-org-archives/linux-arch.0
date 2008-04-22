From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 0/11] Generic smp_call_function() and friends
Date: Tue, 22 Apr 2008 10:48:53 +0200
Message-ID: <1208854133.7115.214.camel@twins>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208851058-8500-1-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

On Tue, 2008-04-22 at 09:57 +0200, Jens Axboe wrote:
> Hi,
> 
> While working on the more scalable and faster
> smp_call_function_single(), the amount of arch duplicated code in there
> botherered me. So I started adding a generic kernel/smp.c helper that
> the archs could use instead.
> 
> Arch code exports two helper functions:
> 
> arch_send_call_function_single_ipi(cpu)
> 	Send call function single ipi to given cpu
> arch_send_call_function_ipi(cpumask)
> 	Send call function ipi to cpus in cpumask
> 
> and then use the generic ipi interrupt helpers to execute the code. I
> converted most of the archs capable of SMP, I think only sparc and
> sparc64 are still missing. Archs set CONFIG_GENERIC_SMP_HELPERS if they
> wish to use the generic helpers for this.
> 
> The end result is that we have unified code for handling ipi for
> function calls. Even with adding special handling for the single cpu
> function call, the diffstat is pretty nice (see below.

Real nice work Jens!
