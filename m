From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
Date: Fri, 25 Apr 2008 23:44:43 -0700
Message-ID: <4812CF5B.4080902@goop.org>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208890227-24808-3-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

Jens Axboe wrote:
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
>   
[...]
> +void arch_send_call_function_single_ipi(int cpu)
>  {
>   
[...]
> +void arch_send_call_function_ipi(cpumask_t mask)
>  {
>   
[...]
> --- a/arch/x86/xen/smp.c
> +++ b/arch/x86/xen/smp.c
> +void arch_send_call_function_ipi(cpumask_t mask)
> +{
>   
[...]
> +void arch_send_call_function_single_ipi(int cpu)
> +{
> +	xen_send_IPI_mask(cpumask_of_cpu(cpu), XEN_CALL_FUNCTION_SINGLE_VECTOR);
>  

Xen vs native is a runtime choice, so you can't just statically define 
arch_send_call_function(_single)_ipi for each.  You need to define the 
arch_* functions once, make them call via smp_ops, and call into the 
respective native and Xen versions of the ipi functions.

Aside from that it looks good, with a very appealing code size reduction.

    J
