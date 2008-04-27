From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function  calls
Date: Sun, 27 Apr 2008 12:23:36 +0200
Message-ID: <20080427102335.GS12774@kernel.dk>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <4812CF5B.4080902@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4812CF5B.4080902-TSDbQ3PG+2Y@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Fri, Apr 25 2008, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> >--- a/arch/x86/kernel/smp.c
> >+++ b/arch/x86/kernel/smp.c
> >  
> [...]
> >+void arch_send_call_function_single_ipi(int cpu)
> > {
> >  
> [...]
> >+void arch_send_call_function_ipi(cpumask_t mask)
> > {
> >  
> [...]
> >--- a/arch/x86/xen/smp.c
> >+++ b/arch/x86/xen/smp.c
> >+void arch_send_call_function_ipi(cpumask_t mask)
> >+{
> >  
> [...]
> >+void arch_send_call_function_single_ipi(int cpu)
> >+{
> >+	xen_send_IPI_mask(cpumask_of_cpu(cpu), 
> >XEN_CALL_FUNCTION_SINGLE_VECTOR);
> > 
> 
> Xen vs native is a runtime choice, so you can't just statically define 
> arch_send_call_function(_single)_ipi for each.  You need to define the 
> arch_* functions once, make them call via smp_ops, and call into the 
> respective native and Xen versions of the ipi functions.

Noted, I'll add it to smp_ops (like smp_call_function_mask() was
before).

> Aside from that it looks good, with a very appealing code size reduction.

Thanks!

-- 
Jens Axboe
