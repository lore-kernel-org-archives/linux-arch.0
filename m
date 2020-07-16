From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V3 02/13] entry: Provide generic syscall exit function
Date: Thu, 16 Jul 2020 13:55:11 -0700
Message-ID: <202007161354.62030182F@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.116500611@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgGPUzO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:55:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D53C08C5C0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:55:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t6so5466149pgq.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:55:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200716185424.116500611@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:10PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Like syscall entry all architectures have similar and pointlessly different
> code to handle pending work before returning from a syscall to user space.
> 
>   1) One-time syscall exit work:
>       - rseq syscall exit
>       - audit
>       - syscall tracing
>       - tracehook (single stepping)
> 
>   2) Preparatory work
>       - Exit to user mode loop (common TIF handling).
>       - Architecture specific one time work arch_exit_to_user_mode_prepare()
>       - Address limit and lockdep checks
>      
>   3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
>      arch_exit_to_user_mode() to handle e.g. speculation mitigations
> 
> Provide a generic version based on the x86 code which has all the RCU and
> instrumentation protections right.
> 
> Provide a variant for interrupt return to user mode as well which shares
> the above #2 and #3 work items.
> 
> After syscall_exit_to_user_mode() and irqentry_exit_to_user_mode() the
> architecture code just has to return to user space. The code after
> returning from these functions must not be instrumented.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This looks correct to me. Did you happen to run the seccomp selftests
under this series?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
