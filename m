Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbeISCVM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:21:12 -0400
Date: Tue, 18 Sep 2018 22:46:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 15/20] signal/x86: Don't compute pkey in
 __do_page_fault
In-Reply-To: <20180918000546.12552-15-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182246370.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-15-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <20180918204650.8UHXctrJRGmhr6J_gI02UQMFmxL-JtccjYpFgrcqWJU@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> There are no more users of the computed pkey value in __do_page_fault
> so stop computing the value.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 7ba00519fa5d..f82106578364 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1215,7 +1215,6 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  	struct mm_struct *mm;
>  	vm_fault_t fault, major = 0;
>  	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> -	u32 pkey;
>  
>  	tsk = current;
>  	mm = tsk->mm;
> @@ -1387,10 +1386,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  	 * (potentially after handling any pending signal during the return to
>  	 * userland). The return to userland is identified whenever
>  	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
> -	 * Thus we have to be careful about not touching vma after handling the
> -	 * fault, so we read the pkey beforehand.
>  	 */
> -	pkey = vma_pkey(vma);
>  	fault = handle_mm_fault(vma, address, flags);
>  	major |= fault & VM_FAULT_MAJOR;
>  
> -- 
> 2.17.1
> 
> 
