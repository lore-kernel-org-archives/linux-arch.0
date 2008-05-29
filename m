From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/10] x86: convert to generic helpers for IPI function  calls
Date: Thu, 29 May 2008 14:17:05 +0200
Message-ID: <20080529121704.GD25504@kernel.dk>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com> <1212051504-12561-3-git-send-email-jens.axboe@oracle.com> <483E9D9B.9030202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:27178 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbYE2MRH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 08:17:07 -0400
Content-Disposition: inline
In-Reply-To: <483E9D9B.9030202@goop.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

On Thu, May 29 2008, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> >@@ -122,6 +109,17 @@ static int xen_smp_intr_init(unsigned int cpu)
> > 		goto fail;
> > 	per_cpu(debug_irq, cpu) = rc;
> > 
> >+	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", 
> >cpu);
> >+	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
> >+				    cpu,
> >+				    
> >xen_call_function_single_interrupt,
> >+				    
> >IRQF_DISABLED|IRQF_PERCPU|IRQF_NOBALANCING,
> >+				    callfunc_name,
> >+				    NULL);
> >+	if (rc < 0)
> >+		goto fail;
> >+	per_cpu(callfuncsingle_irq, cpu) = rc;
> >  
> 
> Tiny nit: could you shift this up below the other callfunc 
> registration, so they appear next to each other in /proc?

Certainly, will do.

> >+void xen_smp_send_call_function_ipi(cpumask_t mask)
> >+{
> >+	int cpu;
> >+
> >+	xen_send_IPI_mask(mask, XEN_CALL_FUNCTION_VECTOR);
> >+
> >+	/* Make sure other vcpus get a chance to run if they need to. 
> >*/
> >+	for_each_cpu_mask(cpu, mask) {
> >+		if (xen_vcpu_stolen(cpu)) {
> >+			HYPERVISOR_sched_op(SCHEDOP_yield, 0);
> >+			break;
> >+		}
> >+	}
> >  
> 
> I think you should just drop this loop for now; I want to do some 
> measurements before putting it in.

If you don't mind, I'd like to keep it as-is. Then the patch should
not have a functional change (there, at least), which I think is
important. I can add a later patch removing this stolen bit, it would
be even better if you send me such a patch :-)

-- 
Jens Axboe
