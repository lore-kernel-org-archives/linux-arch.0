Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbeISCUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:20:08 -0400
Date: Tue, 18 Sep 2018 22:45:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 13/20] signal/x86: Remove the pkey parameter from
 do_sigbus
In-Reply-To: <20180918000546.12552-13-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182245260.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-13-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <20180918204546.BPbdyboT6aSkjaq20Kd2YMBDBbbbh2rOcQfXxKkXzMQ@z>



On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The function do_sigbus never sets si_code to PKUERR so it can never
> return a pkey to userspace.  Therefore remove the unusable pkey
> parameter from do_sigbus.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index cfc88920716f..6886866c072d 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -962,7 +962,7 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  
>  static void
>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> -	  u32 *pkey, unsigned int fault)
> +	  unsigned int fault)
>  {
>  	struct task_struct *tsk = current;
>  
> @@ -994,7 +994,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  		return;
>  	}
>  #endif
> -	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, pkey);
> +	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, NULL);
>  }
>  
>  static noinline void
> @@ -1023,7 +1023,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>  	} else {
>  		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
>  			     VM_FAULT_HWPOISON_LARGE))
> -			do_sigbus(regs, error_code, address, pkey, fault);
> +			do_sigbus(regs, error_code, address, fault);
>  		else if (fault & VM_FAULT_SIGSEGV)
>  			bad_area_nosemaphore(regs, error_code, address);
>  		else
> -- 
> 2.17.1
> 
> 
