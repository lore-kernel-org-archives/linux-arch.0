From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [REVIEW][PATCH 09/22] signal/nds32: Use force_sig_fault where appropriate
Date: Thu, 26 Apr 2018 09:24:09 +0800
Message-ID: <CAEbi=3d69M=DB_2aDbei+a=8cRj33LTJc7v5ieD_xVnO72Kw9Q@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-9-ebiederm@xmission.com>
 <CAJsyPhy_GbfnzCNa_rJDMSRrUfVKOJKCVqrkWkDUmH6jPDGPhw@mail.gmail.com> <87wowvuvml.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87wowvuvml.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vincent Chen <deanbo422@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2018-04-25 23:57 GMT+08:00 Eric W. Biederman <ebiederm@xmission.com>:
> Vincent Chen <deanbo422@gmail.com> writes:
>
>> 2018-04-20 22:37 GMT+08:00 Eric W. Biederman <ebiederm@xmission.com>:
>>> Filling in struct siginfo before calling force_sig_info a tedious and
>>> error prone process, where once in a great while the wrong fields
>>> are filled out, and siginfo has been inconsistently cleared.
>>>
>>> Simplify this process by using the helper force_sig_fault.  Which
>>> takes as a parameters all of the information it needs, ensures
>>> all of the fiddly bits of filling in struct siginfo are done properly
>>> and then calls force_sig_info.
>>>
>>> In short about a 5 line reduction in code for every time force_sig_info
>>> is called, which makes the calling function clearer.
>>>
>>> Cc: Greentime Hu <green.hu@gmail.com>
>>> Cc: Vincent Chen <deanbo422@gmail.com>
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>  arch/nds32/kernel/traps.c | 20 ++++----------------
>>>  arch/nds32/mm/fault.c     | 19 +++++--------------
>>>  2 files changed, 9 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
>>> index 46911768f4b5..636d1c7aa895 100644
>>> --- a/arch/nds32/kernel/traps.c
>>> +++ b/arch/nds32/kernel/traps.c
>>> @@ -222,20 +222,13 @@ void die_if_kernel(const char *str, struct pt_regs *regs, int err)
>>>
>>>  int bad_syscall(int n, struct pt_regs *regs)
>>>  {
>>> -       siginfo_t info;
>>> -
>>>         if (current->personality != PER_LINUX) {
>>>                 send_sig(SIGSEGV, current, 1);
>>>                 return regs->uregs[0];
>>>         }
>>>
>>> -       clear_siginfo(&info);
>>> -       info.si_signo = SIGILL;
>>> -       info.si_errno = 0;
>>> -       info.si_code = ILL_ILLTRP;
>>> -       info.si_addr = (void __user *)instruction_pointer(regs) - 4;
>>> -
>>> -       force_sig_info(SIGILL, &info, current);
>>> +       force_sig_fault(SIGILL, ILL_ILLTRP,
>>> +                       (void __user *)instruction_pointer(regs) - 4, current);
>>>         die_if_kernel("Oops - bad syscall", regs, n);
>>>         return regs->uregs[0];
>>>  }
>>> @@ -288,16 +281,11 @@ void __init early_trap_init(void)
>>>  void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>>>                   int error_code, int si_code)
>>>  {
>>> -       struct siginfo info;
>>> -
>>>         tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
>>>         tsk->thread.error_code = error_code;
>>>
>>> -       clear_siginfo(&info);
>>> -       info.si_signo = SIGTRAP;
>>> -       info.si_code = si_code;
>>> -       info.si_addr = (void __user *)instruction_pointer(regs);
>>> -       force_sig_info(SIGTRAP, &info, tsk);
>>> +       force_sig_fault(SIGTRAP, si_code
>>> +                       (void __user *)instruction_pointer(regs), tsk);
>>>  }
>>>
>>
>> I found a comma is missing after argument si_code.
>
> Good catch.  Fixed.
>
> Unfortunately the only compiler I have for nds32 is my eyeballs so
> this slipped through.  Grr.
>
>

Sorry for that. Our nds32 toolchain upstreaming is on-going.
You may try this one. It is able to build defconfig and allnoconfig

https://lkml.org/lkml/2018/4/17/395
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/6.4.0/x86_64-gcc-6.4.0-nolibc-nds32le-linux.tar.xz

or this one with glibc support
https://github.com/andestech/build_script.git
https://github.com/greentime/prebuilt-nds32-toolchain/releases
