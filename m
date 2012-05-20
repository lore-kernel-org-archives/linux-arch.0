Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35387 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2ETJEr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 May 2012 05:04:47 -0400
Date: Sun, 20 May 2012 10:04:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Message-ID: <20120520090444.GA26841@ZenIV.linux.org.uk>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
 <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
 <20120518195610.GV22082@ZenIV.linux.org.uk>
 <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
 <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
 <20120518222422.GX22082@ZenIV.linux.org.uk>
 <20120520084042.GA25447@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120520084042.GA25447@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Grant Grundler <grantgrundler@gmail.com>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20120520090444.JB3suovIbDsA0tiCqPfsVwkZotWU5rh0aRJzvMuwi-Y@z>

On Sun, May 20, 2012 at 09:40:42AM +0100, Al Viro wrote:
> Moreover, checking PT_TRACED first is not even cheaper in the common case
> (i.e. when branch to .Ltracesys is not taken at all).  As it is, parisc does
>         mfctl   %cr30, %r1
>         LDREG   TI_TASK(%r1),%r1
>         ldw     TASK_PTRACE(%r1), %r1
>         bb,<,n  %r1,31,.Ltracesys
> and that's actually an extra dereference compared to
>         mfctl   %cr30, %r1
>         LDREG   TI_FLAGS(%r1),%r1
>         bb,<,n  %r1,31 - TIF_SYSCALL_TRACE,.Ltracesys
> Note that tracehook_report_syscall_entry/tracehook_report_syscall_exit
> are checking PT_PTRACED, so it's not like we needed to change anything
> other than that spot - resulting logics will be equivalent to what we
> have right now.  Looks like a fairly straightforward optimisation...
> Am I missing something subtle and parisc-specific here?

Actually, looks like I am missing something, but it's not particulary subtle.
SYSCALL_TRACE is needed for do_syscall_trace_enter() to do anything;
any of SYSCALL_TRACE/SINGLESTEP/BLOCKSTEP is makes do_syscall_trace_leave()
do things.  So checking one bit in flags is not enough - any of those 3 is
a reason for taking the slow path.  The point still stands, though -
	mfctl   %cr30, %r1
	LDREG   TI_FLAGS(%r1),%r1
	ldi	(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | _TIF_BLOCKSTEP), %r19
        and,COND(=) %r19, %r1, %r0
	b,n	.Ltracesys
would still be no worse on the fast path and would not hit the slow path in
a lot of cases when the current code does it for no apparent reason.

Comments?
