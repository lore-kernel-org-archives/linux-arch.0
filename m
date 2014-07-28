Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:39696 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaG1UXf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2014 16:23:35 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so5912496lab.36
        for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2014 13:23:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140728173723.GA20993@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 28 Jul 2014 13:23:13 -0700
Message-ID: <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20140728202313.ZNDGMgyUD7_8KWUg3LYQfGy926YyuwZHpLmnd0yUm4E@z>

On Mon, Jul 28, 2014 at 10:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> Hi Andy,
>
> I am really sorry for delay.
>
> This is on top of the recent change from Kees, right? Could me remind me
> where can I found the tree this series based on? So that I could actually
> apply these changes...

https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath

The first four patches are already applied there.

>
> On 07/21, Andy Lutomirski wrote:
>>
>> +long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
>> +                             unsigned long phase1_result)
>>  {
>>       long ret = 0;
>> +     u32 work = ACCESS_ONCE(current_thread_info()->flags) &
>> +             _TIF_WORK_SYSCALL_ENTRY;
>> +
>> +     BUG_ON(regs != task_pt_regs(current));
>>
>>       user_exit();
>>
>> @@ -1458,17 +1562,20 @@ long syscall_trace_enter(struct pt_regs *regs)
>>        * do_debug() and we need to set it again to restore the user
>>        * state.  If we entered on the slow path, TF was already set.
>>        */
>> -     if (test_thread_flag(TIF_SINGLESTEP))
>> +     if (work & _TIF_SINGLESTEP)
>>               regs->flags |= X86_EFLAGS_TF;
>
> This looks suspicious, but perhaps I misread this change.
>
> If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
> But we should always call user_exit() unconditionally?

Damnit.  I read that every function called by user_exit, and none of
them give any indication of why they're needed for traced syscalls but
not for untraced syscalls.  On a second look, it seems that TIF_NOHZ
controls it.  I'll update the code to call user_exit iff TIF_NOHZ is
set.  If that's still wrong, then I don't see how the current code is
correct either.

>
> And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
> actually cleared on a 32bit kernel if we step over sysenter insn?

I don't follow.  If TIF_SINGLESTEP, then phase1 will return a nonzero
value, and phase2 will set TF.

I admit I don't really understand all the TF machinations.

--Andy
