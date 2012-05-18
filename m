Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39186 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967137Ab2ERT4M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 15:56:12 -0400
Date: Fri, 18 May 2012 20:56:10 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Message-ID: <20120518195610.GV22082@ZenIV.linux.org.uk>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
 <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Grundler <grantgrundler@gmail.com>
Cc: linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20120518195610.utOFojnoTvZSlCNkLQX8btoHCAJMjeTzp58KQeMQXlo@z>

On Fri, May 18, 2012 at 11:05:46AM -0700, Grant Grundler wrote:
> On Fri, May 18, 2012 at 10:58 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> ...
> >?Except for that mess with multiple
> > pending signals, the value we have in r28 on syscall entry doesn't
> > seem to affect the syscall behaviour... ?Some HPUX compat fun?
> 
> We stopped trying to support HPUX compat support probably 8 or so
> years ago. Since HP didn't care, no one else did either.  So no need
> to consider it now.

BTW, what should we put into the trampolines of subsequent sigframes
when we are building more that one?  I.e. suppose we are in a syscall
and see two signals.  We build a sigframe for the first one, with
r25 = 1, call rt_sigreturn() in it.  Return address of original syscall
is stored into sigcontext of that frame, our return address set to the
entry point of handler1.  Now we see the second signal and build another
sigframe.  That one will have the entry point of the first handler stored
in sigframe and we'll set the things up so that return to userland will
land us in the entry of handler2.  Fine, but... what should we have in r25
for rt_sigreturn() in the second trampoline?

We return to userland and find ourselves in the beginning of handler2.
It's executed and eventually we return from it.  We are at the beginning
of the second trampoline now.  rt_sigreturn() is called, restores the
registers from the second sigcontext and returns to userland.  We are at
the beginning of handler1.  It is executed and returns.  We are at the
beginning of the first trampoline.  rt_sigreturn() _there_ restores the
original registers from the first sigcontext and we finally return to the
insn right after the original syscall (or to the syscall itself if we
took a syscall restart).

That final rt_sigreturn() will go through syscall_exit; OK, no problem
with that.  But should the earlier one (done after return from handler2()
and landing us at the entry of handler1) go through syscall_exit or
through syscall_exit_rfi?
