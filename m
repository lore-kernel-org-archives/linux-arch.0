From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 2/10] x86: convert to generic helpers for IPI function
 calls
Date: Tue, 29 Apr 2008 13:35:49 -0700
Message-ID: <481786A5.7010604@goop.org>
References: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com> <1209453990-7735-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209453990-7735-3-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org

Jens Axboe wrote:
> -int xen_smp_call_function_mask(cpumask_t mask, void (*func)(void *),
> -			       void *info, int wait)
>   
[...]
> -	/* Send a message to other CPUs and wait for them to respond */
> -	xen_send_IPI_mask(mask, XEN_CALL_FUNCTION_VECTOR);
> -
> -	/* Make sure other vcpus get a chance to run if they need to. */
> -	yield = false;
> -	for_each_cpu_mask(cpu, mask)
> -		if (xen_vcpu_stolen(cpu))
> -			yield = true;
> -
> -	if (yield)
> -		HYPERVISOR_sched_op(SCHEDOP_yield, 0);
>   

I added this to deal with the case where you're sending an IPI to 
another VCPU which isn't currently running on a real cpu.  In this case 
you could end up spinning while the other VCPU is waiting for a real CPU 
to run on.  (Basically the same problem that spinlocks have in a virtual 
environment.)

However, this is at best a partial solution to the problem, and I never 
benchmarked if it really makes a difference.  Since any other virtual 
environment would have the same problem, its best if we can solve it 
generically.  (Of course a synchronous single-target cross-cpu call is a 
simple cross-cpu rpc, which could be implemented very efficiently in the 
host/hypervisor by simply doing a vcpu context switch...)

    J
