From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][ATCH 1/3] ptrace: Remove maxargs from task_current_syscall()
Date: Tue, 8 Nov 2016 08:16:08 -0800
Message-ID: <CA+55aFyMVXRt2PPifWwVW9oP6+4Cpc4B01t2S1840ZbHk7d1Dg@mail.gmail.com>
References: <20161107212634.529267342@goodmis.org> <20161107213233.466776454@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34900 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbcKHQQK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 11:16:10 -0500
In-Reply-To: <20161107213233.466776454@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

So I definitely approve of the change, but I wonder if we should go
one step further:

On Mon, Nov 7, 2016 at 1:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  extern int task_current_syscall(struct task_struct *target, long *callno,
> -                               unsigned long args[6], unsigned int maxargs,
> -                               unsigned long *sp, unsigned long *pc);
> +                               unsigned long args[6], unsigned long *sp,
> +                               unsigned long *pc);

The thing is, in C, having an array in a function declaration is
pretty much exactly the same as just having a pointer, so from a type
checking standpoint it doesn't really help all that much (but from a
"human documentation" side the "args[6]" is much better than "*args").

However, what would really help type checking is making it a
structure. And maybe that structure could just contain "callno", "sp"
and "pc" too? That would not only fix the type checking, it would make
the calling convention even cleaner. Just have one single structure
that contains all the relevant data.

That would also allow us (later - don't do it now) to replace the odd
collection of "get registers one by one" with a single
architecture-specific routine that fills it all in.Right now we do

        *sp = user_stack_pointer(regs);
        *pc = instruction_pointer(regs);

        *callno = syscall_get_nr(target, regs);
        if (*callno != -1L && maxargs > 0)
                syscall_get_arguments(target, regs, 0, maxargs, args);

and it feels like this could/should just be a single
"syscall_get_info()" helper.

For example, kernel/seccomp.c does this instead:

        sd->nr = syscall_get_nr(task, regs);
        sd->arch = syscall_get_arch();
        syscall_get_arguments(task, regs, 0, 6, args);
        sd->args[0] = args[0];
        sd->args[1] = args[1];
        sd->args[2] = args[2];
        sd->args[3] = args[3];
        sd->args[4] = args[4];
        sd->args[5] = args[5];
        sd->instruction_pointer = KSTK_EIP(task);

and notice how it wants "pc" too, but it used a completely different
way to get them? So the ad-hoc nature of the current interfaces really
does shine through here (ok, so seccomp doesn't need the user stack
pointer, but it really won't hurt there either.

Hmm?

             Linus
