From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 04/20] signal/x86: Use send_sig_mceerr as
 apropriate
Date: Tue, 18 Sep 2018 22:21:58 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182220310.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-4-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-4-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

CC+ kvm folks

> This simplifies the code making it clearer what is going on.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/kvm/mmu.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index a282321329b5..95349bfe3b59 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3114,16 +3114,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
>  
>  static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
>  {
> -	siginfo_t info;
> -
> -	clear_siginfo(&info);
> -	info.si_signo	= SIGBUS;
> -	info.si_errno	= 0;
> -	info.si_code	= BUS_MCEERR_AR;
> -	info.si_addr	= (void __user *)address;
> -	info.si_addr_lsb = PAGE_SHIFT;
> -
> -	send_sig_info(SIGBUS, &info, tsk);
> +	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
>  }
>  
>  static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> -- 
> 2.17.1
> 
> 
