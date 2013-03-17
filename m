From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] tracing: syscall_regfunc() should not skip kernel
 threads
Date: Sun, 17 Mar 2013 15:36:12 -0400
Message-ID: <1363548972.25967.137.camel@gandalf.local.home>
References: <20130317182834.GA22989@redhat.com>
	 <1363546493.25967.129.camel@gandalf.local.home>
	 <20130317190438.GA24582@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:25377 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab3CQTgN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 17 Mar 2013 15:36:13 -0400
In-Reply-To: <20130317190438.GA24582@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>

On Sun, 2013-03-17 at 20:04 +0100, Oleg Nesterov wrote:

> > I'm really thinking the TIF_SYSCALL_TRACEPOINT flag is getting a bit
> > ridiculous. We really should have a "swap syscall table when tracepoints
> > enabled" that changes the syscall table that does exactly the same thing
> > as the normal table but wraps the system call with the tracepoints.
> 
> But we also need to force the slow path in system_call...

Why? If we remove the tracepoint from the slowpath and use a table swap,
then we wouldn't need to use the slowpath at all.

> 
> Anyway, do you agree with this change for now?

Well, if it's solving a bug today sure. But we should really be looking
at fixing what's there for the future.

-- Steve
