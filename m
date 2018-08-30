Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34047 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeH3Tmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 15:42:46 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so16250190ois.1
        for <linux-arch@vger.kernel.org>; Thu, 30 Aug 2018 08:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-20-yu-cheng.yu@intel.com>
In-Reply-To: <20180830143904.3168-20-yu-cheng.yu@intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Aug 2018 17:39:35 +0200
Message-ID: <CAG48ez3uZrC-9uJ0uMoVPTtxRXRN8D+3zs5FknZD2woTT6mazg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 19/24] x86/cet/shstk: Introduce WRUSS instruction
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yu-cheng.yu@intel.com
Cc: the arch/x86 maintainers <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com, Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Message-ID: <20180830153935.S7OO4EfvnbapezM5kZCALbFyeJCqGl1YG4xfOPW6GdI@z>

On Thu, Aug 30, 2018 at 4:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> WRUSS is a new kernel-mode instruction but writes directly
> to user shadow stack memory.  This is used to construct
> a return address on the shadow stack for the signal
> handler.
>
> This instruction can fault if the user shadow stack is
> invalid shadow stack memory.  In that case, the kernel does
> fixup.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> +{
> +       int err = 0;
> +
> +       asm volatile("1: wrussq %1, (%0)\n"
> +                    "2:\n"
> +                    _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wruss)
> +                    :
> +                    : "r" (addr), "r" (val));
> +
> +       return err;
> +}

What's up with "err"? You set it to zero, and then you return it, but
nothing can ever set it to non-zero, right?

> +__visible bool ex_handler_wruss(const struct exception_table_entry *fixup,
> +                               struct pt_regs *regs, int trapnr)
> +{
> +       regs->ip = ex_fixup_addr(fixup);
> +       regs->ax = -1;
> +       return true;
> +}

And here you just write into regs->ax, but your "asm volatile" doesn't
reserve that register. This looks wrong to me.

I think you probably want to add something like an explicit
`"+&a"(err)` output to the asm statements.

> @@ -1305,6 +1305,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>                 error_code |= X86_PF_USER;
>                 flags |= FAULT_FLAG_USER;
>         } else {
> +               /*
> +                * WRUSS is a kernel instrcution and but writes

Nits: typo ("instrcution"), weird grammar ("and but writes")
