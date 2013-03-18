From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] tracing: syscall_regfunc() should not skip kernel
	threads
Date: Mon, 18 Mar 2013 17:26:50 +0100
Message-ID: <20130318162650.GA20313@redhat.com>
References: <20130317182834.GA22989@redhat.com> <1363546493.25967.129.camel@gandalf.local.home> <20130317190438.GA24582@redhat.com> <1363548972.25967.137.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363548972.25967.137.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 03/17, Steven Rostedt wrote:
>
> On Sun, 2013-03-17 at 20:04 +0100, Oleg Nesterov wrote:
>
> > > I'm really thinking the TIF_SYSCALL_TRACEPOINT flag is getting a bit
> > > ridiculous. We really should have a "swap syscall table when tracepoints
> > > enabled" that changes the syscall table that does exactly the same thing
> > > as the normal table but wraps the system call with the tracepoints.
> >
> > But we also need to force the slow path in system_call...
>
> Why? If we remove the tracepoint from the slowpath and use a table swap,
> then we wouldn't need to use the slowpath at all.

Ah, indeed, you are right.

> > Anyway, do you agree with this change for now?
>
> Well, if it's solving a bug today sure. But we should really be looking
> at fixing what's there for the future.

OK, thanks.

Oleg.
