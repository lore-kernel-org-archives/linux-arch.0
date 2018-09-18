From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 14/20] signal/x86: Remove pkey parameter from
 mm_fault_error
Date: Tue, 18 Sep 2018 22:46:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182246030.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-14-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-14-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> After the previous cleanups to do_sigbus and and bad_area_nosemaphore
> mm_fault_error no now longer uses it's pkey parameter.  Therefore
> remove the unused parameter.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 6886866c072d..7ba00519fa5d 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -999,7 +999,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  
>  static noinline void
>  mm_fault_error(struct pt_regs *regs, unsigned long error_code,
> -	       unsigned long address, u32 *pkey, vm_fault_t fault)
> +	       unsigned long address, vm_fault_t fault)
>  {
>  	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
>  		no_context(regs, error_code, address, 0, 0);
> @@ -1419,7 +1419,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  
>  	up_read(&mm->mmap_sem);
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> -		mm_fault_error(regs, error_code, address, &pkey, fault);
> +		mm_fault_error(regs, error_code, address, fault);
>  		return;
>  	}
>  
> -- 
> 2.17.1
> 
> 
