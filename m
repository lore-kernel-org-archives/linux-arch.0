Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33140 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH3T6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 15:58:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id i134-v6so2181236wmf.0
        for <linux-arch@vger.kernel.org>; Thu, 30 Aug 2018 08:56:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG48ez3uZrC-9uJ0uMoVPTtxRXRN8D+3zs5FknZD2woTT6mazg@mail.gmail.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-20-yu-cheng.yu@intel.com>
 <CAG48ez3uZrC-9uJ0uMoVPTtxRXRN8D+3zs5FknZD2woTT6mazg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 30 Aug 2018 08:55:44 -0700
Message-ID: <CALCETrW78UKt6AQJeN8GkhtxjuASnH1PV5QSpzQtDz9-2d3Asw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 19/24] x86/cet/shstk: Introduce WRUSS instruction
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20180830155544.eRvEQOslf8zWdjziMuaMpnt15BkVQQK1oWL4OVzS-MM@z>

On Thu, Aug 30, 2018 at 8:39 AM, Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 30, 2018 at 4:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> WRUSS is a new kernel-mode instruction but writes directly
>> to user shadow stack memory.  This is used to construct
>> a return address on the shadow stack for the signal
>> handler.
>>
>> This instruction can fault if the user shadow stack is
>> invalid shadow stack memory.  In that case, the kernel does
>> fixup.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> [...]
>> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
>> +{
>> +       int err = 0;
>> +
>> +       asm volatile("1: wrussq %1, (%0)\n"
>> +                    "2:\n"
>> +                    _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wruss)
>> +                    :
>> +                    : "r" (addr), "r" (val));
>> +
>> +       return err;
>> +}
>
> What's up with "err"? You set it to zero, and then you return it, but
> nothing can ever set it to non-zero, right?
>
>> +__visible bool ex_handler_wruss(const struct exception_table_entry *fixup,
>> +                               struct pt_regs *regs, int trapnr)
>> +{
>> +       regs->ip = ex_fixup_addr(fixup);
>> +       regs->ax = -1;
>> +       return true;
>> +}
>
> And here you just write into regs->ax, but your "asm volatile" doesn't
> reserve that register. This looks wrong to me.
>
> I think you probably want to add something like an explicit
> `"+&a"(err)` output to the asm statements.

We require asm goto support these days.  How about using that?  You
won't even need a special exception handler.

Also, please change the BUG to WARN in the you-did-it-wrong 32-bit
case.  And return -EFAULT.

--Andy
