From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][ATCH 3/3] syscalls: Remove start and number from
 syscall_get_arguments() args
Date: Tue, 8 Nov 2016 14:21:57 -0500
Message-ID: <20161108142157.68c7db7c@gandalf.local.home>
References: <20161107212634.529267342@goodmis.org>
        <20161107213233.754809394@goodmis.org>
        <CALCETrVt-tPAFOx5wMvA51pjO51VyNwN5cP821WsagDGdjM36Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrVt-tPAFOx5wMvA51pjO51VyNwN5cP821WsagDGdjM36Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 7 Nov 2016 15:54:14 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Mon, Nov 7, 2016 at 1:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >  
> 
> > diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> > index e3c95e8e61c5..050891169b51 100644
> > --- a/arch/x86/include/asm/syscall.h
> > +++ b/arch/x86/include/asm/syscall.h  
> 
> x86 part is:
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> 
> Although I wonder why this takes a task argument.

Thanks, although kbuild bot discovered a slight mistake:

	} else {
# endif
		*args++ = regs->di;

Should be:

	} else
# endif
	{
		*args++ = regs->di;

I'll update, and also look at making it a struct.

-- Steve
