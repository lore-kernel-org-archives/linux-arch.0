Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46509 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932454AbeDWTLZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Apr 2018 15:11:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so10092378pfe.13
        for <linux-arch@vger.kernel.org>; Mon, 23 Apr 2018 12:11:25 -0700 (PDT)
Date: Mon, 23 Apr 2018 12:11:23 -0700 (PDT)
Subject: Re: [REVIEW][PATCH 14/22] signal/riscv: Use force_sig_fault where appropriate
In-Reply-To: <20180420143811.9994-14-ebiederm@xmission.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-77d5b15b-866b-464a-a256-6c7b84726ce3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, albert@sifive.com, linux-riscv@lists.infradead.org
Message-ID: <20180423191123.Ur832GTSpTAtnhGbFQ-HvpbdnnxT7SXsXfMYaBqUfDA@z>

On Fri, 20 Apr 2018 07:38:03 PDT (-0700), ebiederm@xmission.com wrote:
> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
>
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
>
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <albert@sifive.com>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/riscv/kernel/traps.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 48aa6471cede..3087940008f4 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -66,14 +66,7 @@ void die(struct pt_regs *regs, const char *str)
>  static inline void do_trap_siginfo(int signo, int code,
>  	unsigned long addr, struct task_struct *tsk)
>  {
> -	siginfo_t info;
> -
> -	clear_siginfo(&info);
> -	info.si_signo = signo;
> -	info.si_errno = 0;
> -	info.si_code = code;
> -	info.si_addr = (void __user *)addr;
> -	force_sig_info(signo, &info, tsk);
> +	force_sig_fault(signo, code, (void __user *)addr, tsk);
>  }
>
>  void do_trap(struct pt_regs *regs, int signo, int code,

If I understand this correctly, any change in behavior this causes would have 
been a bug on our end not filling out siginfo correctly?  In that case then 
feel free to add an

    Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
