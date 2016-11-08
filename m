From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][ATCH 1/3] ptrace: Remove maxargs from
 task_current_syscall()
Date: Tue, 8 Nov 2016 14:48:51 -0500
Message-ID: <20161108144851.7a35c37d@gandalf.local.home>
References: <20161107212634.529267342@goodmis.org>
        <20161107213233.466776454@goodmis.org>
        <CA+55aFyMVXRt2PPifWwVW9oP6+4Cpc4B01t2S1840ZbHk7d1Dg@mail.gmail.com>
        <CALCETrUBLL+2bU+A03sEns=ESjTXModxwuxiH1EHj__SDp2hgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:51259 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752512AbcKHTsz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 14:48:55 -0500
In-Reply-To: <CALCETrUBLL+2bU+A03sEns=ESjTXModxwuxiH1EHj__SDp2hgA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Tue, 8 Nov 2016 08:20:48 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Tue, Nov 8, 2016 at 8:16 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > So I definitely approve of the change, but I wonder if we should go
> > one step further:
> >
> > On Mon, Nov 7, 2016 at 1:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:  
> >>
> >>  extern int task_current_syscall(struct task_struct *target, long *callno,
> >> -                               unsigned long args[6], unsigned int maxargs,
> >> -                               unsigned long *sp, unsigned long *pc);
> >> +                               unsigned long args[6], unsigned long *sp,
> >> +                               unsigned long *pc);  
> >
> > The thing is, in C, having an array in a function declaration is
> > pretty much exactly the same as just having a pointer, so from a type
> > checking standpoint it doesn't really help all that much (but from a
> > "human documentation" side the "args[6]" is much better than "*args").
> >
> > However, what would really help type checking is making it a
> > structure. And maybe that structure could just contain "callno", "sp"
> > and "pc" too? That would not only fix the type checking, it would make
> > the calling convention even cleaner. Just have one single structure
> > that contains all the relevant data.  
> 
> I would propose calling this 'struct seccomp_data'.

I'm assuming you mean to use the existing seccomp_data? But isn't that
already defined as a user structure? Thus, we can't add sp and pc to it.

I can change syscall_get_arguments() to take the seccomp_data as an
input, and just fill in the arguments directly.

-- Steve
