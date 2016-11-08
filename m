From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC][ATCH 1/3] ptrace: Remove maxargs from task_current_syscall()
Date: Tue, 8 Nov 2016 08:20:48 -0800
Message-ID: <CALCETrUBLL+2bU+A03sEns=ESjTXModxwuxiH1EHj__SDp2hgA@mail.gmail.com>
References: <20161107212634.529267342@goodmis.org> <20161107213233.466776454@goodmis.org>
 <CA+55aFyMVXRt2PPifWwVW9oP6+4Cpc4B01t2S1840ZbHk7d1Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33979 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbcKHQVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 11:21:10 -0500
Received: by mail-vk0-f52.google.com with SMTP id x186so152938191vkd.1
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2016 08:21:10 -0800 (PST)
In-Reply-To: <CA+55aFyMVXRt2PPifWwVW9oP6+4Cpc4B01t2S1840ZbHk7d1Dg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Tue, Nov 8, 2016 at 8:16 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I definitely approve of the change, but I wonder if we should go
> one step further:
>
> On Mon, Nov 7, 2016 at 1:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>  extern int task_current_syscall(struct task_struct *target, long *callno,
>> -                               unsigned long args[6], unsigned int maxargs,
>> -                               unsigned long *sp, unsigned long *pc);
>> +                               unsigned long args[6], unsigned long *sp,
>> +                               unsigned long *pc);
>
> The thing is, in C, having an array in a function declaration is
> pretty much exactly the same as just having a pointer, so from a type
> checking standpoint it doesn't really help all that much (but from a
> "human documentation" side the "args[6]" is much better than "*args").
>
> However, what would really help type checking is making it a
> structure. And maybe that structure could just contain "callno", "sp"
> and "pc" too? That would not only fix the type checking, it would make
> the calling convention even cleaner. Just have one single structure
> that contains all the relevant data.

I would propose calling this 'struct seccomp_data'.

>
> For example, kernel/seccomp.c does this instead:
>
>         sd->nr = syscall_get_nr(task, regs);
>         sd->arch = syscall_get_arch();
>         syscall_get_arguments(task, regs, 0, 6, args);
>         sd->args[0] = args[0];
>         sd->args[1] = args[1];
>         sd->args[2] = args[2];
>         sd->args[3] = args[3];
>         sd->args[4] = args[4];
>         sd->args[5] = args[5];
>         sd->instruction_pointer = KSTK_EIP(task);

It's a bit hard to tell from seccomp.c, but x86 carefully arranges for
that code to never get run -- instead the entry code supplies a struct
seccomp_data.  Other arches could follow suit for a nice speedup.

--Andy
