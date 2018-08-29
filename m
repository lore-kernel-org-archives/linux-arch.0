Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeH2Mze (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 08:55:34 -0400
Date: Wed, 29 Aug 2018 17:59:36 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Message-ID: <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
In-Reply-To: <20180829081147.184610-2-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-2-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180829085936.ySVcL3TTWrBetIJgRcPjIpLZJ03cFBggx48uo4H-BpU@z>

On Wed, 29 Aug 2018 01:11:42 -0700
Nadav Amit <namit@vmware.com> wrote:

> Use lockdep to ensure that text_mutex is taken when text_poke() is
> called.
> 
> Actually it is not always taken, specifically when it is called by kgdb,
> so take the lock in these cases.

Can we really take a mutex in kgdb context?

kgdb_arch_remove_breakpoint
  <- dbg_deactivate_sw_breakpoints
    <- kgdb_reenter_check
       <- kgdb_handle_exception
          <- __kgdb_notify
            <- kgdb_ll_trap
              <- do_int3
            <- kgdb_notify
              <- die notifier

kgdb_arch_set_breakpoint
  <- dbg_activate_sw_breakpoints
    <- kgdb_reenter_check
       <- kgdb_handle_exception
           ...

Both seems called in exception context, so we can not take a mutex lock.
I think kgdb needs a special path.

Thanks,

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/kernel/alternative.c | 1 +
>  arch/x86/kernel/kgdb.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 014f214da581..916c11b410c4 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -699,6 +699,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  	 * pages as they are not yet initialized.
>  	 */
>  	BUG_ON(!after_bootmem);
> +	lockdep_assert_held(&text_mutex);
>  
>  	if (!core_kernel_text((unsigned long)addr)) {
>  		pages[0] = vmalloc_to_page(addr);
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..60b99c76086c 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -768,8 +768,12 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  	 */
>  	if (mutex_is_locked(&text_mutex))
>  		return -EBUSY;
> +
> +	/* Take the mutex to avoid lockdep assertion failures. */
> +	mutex_lock(&text_mutex);
>  	text_poke((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
>  		  BREAK_INSTR_SIZE);
> +	mutex_unlock(&text_mutex);
>  	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
>  	if (err)
>  		return err;
> @@ -793,7 +797,12 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  	 */
>  	if (mutex_is_locked(&text_mutex))
>  		goto knl_write;
> +
> +	/* Take the mutex to avoid lockdep assertion failures. */
> +	mutex_lock(&text_mutex);
>  	text_poke((void *)bpt->bpt_addr, bpt->saved_instr, BREAK_INSTR_SIZE);
> +	mutex_unlock(&text_mutex);
> +
>  	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
>  	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
>  		goto knl_write;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
