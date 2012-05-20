Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57269 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2ETIkv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 May 2012 04:40:51 -0400
Date: Sun, 20 May 2012 09:40:42 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Message-ID: <20120520084042.GA25447@ZenIV.linux.org.uk>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
 <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
 <20120518195610.GV22082@ZenIV.linux.org.uk>
 <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
 <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
 <20120518222422.GX22082@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120518222422.GX22082@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Grant Grundler <grantgrundler@gmail.com>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20120520084042.KkyIQ0j7erOnxaigLA7oXUjbWzS_RIWE9ckxrDriIiQ@z>

	BTW, after looking through the asm glue there, I've noticed something
rather odd.  *All* architectures other than parisc have the following thing
done on syscall entry:
	* check if we have TIF_SYSCALL_TRACE in flags; bugger off to slow
path if we do.
	* there check if we have PT_PTRACED in current->ptrace and if so
do the standard song and dance with raising SIGTRAP or SIGTRAP | 0x80,
etc.

parisc does that in the opposite order - it goes to slow path if
current->ptrace & PT_PTRACED is true.  The same actions with raising
SIGTRAP, etc. are done only if TIF_SYSCALL_TRACE is there as well,
but by that point we'd already plonked a bunch of registers on the
stack and we actually stay on the slow path even in absense of SYSCALL_TRACE.

The thing is, other architectures have a good reason for looking at
SYSCALL_TRACE first and not bothering with all that fun if it's not set.
PT_PTRACED is set when the task is being traced; it does *not* imply
stopping on every syscall entry.  E.g. a perfectly normal situation is
when in gdb you've said
break foo.c:69
cont
and let the process run until it hits that breakpoint.  It has PT_PTRACED
all along.  It will be stopped when it gets a signal, including SIGTRAP
we'll get when it steps on that breakpoint.  But by that time it's very
likely to have passed through tons of syscalls without stopping on any of
them.  SYSCALL_TRACE is set *only* when we want the process to stop on the
next syscall.  That's what strace(1) and friends are using.  So it doesn't
make sense to get overhead for all processes that have PT_PTRACED;
SYSCALL_TRACE is less likely, so checking it first is an obvious approach.

Moreover, checking PT_TRACED first is not even cheaper in the common case
(i.e. when branch to .Ltracesys is not taken at all).  As it is, parisc does
        mfctl   %cr30, %r1
        LDREG   TI_TASK(%r1),%r1
        ldw     TASK_PTRACE(%r1), %r1
        bb,<,n  %r1,31,.Ltracesys
and that's actually an extra dereference compared to
        mfctl   %cr30, %r1
        LDREG   TI_FLAGS(%r1),%r1
        bb,<,n  %r1,31 - TIF_SYSCALL_TRACE,.Ltracesys
Note that tracehook_report_syscall_entry/tracehook_report_syscall_exit
are checking PT_PTRACED, so it's not like we needed to change anything
other than that spot - resulting logics will be equivalent to what we
have right now.  Looks like a fairly straightforward optimisation...
Am I missing something subtle and parisc-specific here?
