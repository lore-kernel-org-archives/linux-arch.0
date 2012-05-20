Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from blu0-omc4-s10.blu0.hotmail.com ([65.55.111.149]:2696 "EHLO
	blu0-omc4-s10.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756741Ab2ETSqb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 May 2012 14:46:31 -0400
Message-ID: <BLU0-SMTP98435C9101767076C00E7A971C0@phx.gbl>
From: John David Anglin <dave.anglin@bell.net>
In-Reply-To: <20120520090444.GA26841@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
References: <20120518175833.GQ22082@ZenIV.linux.org.uk> <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com> <20120518195610.GV22082@ZenIV.linux.org.uk> <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com> <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com> <20120518222422.GX22082@ZenIV.linux.org.uk> <20120520084042.GA25447@ZenIV.linux.org.uk> <20120520090444.GA26841@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0 (Apple Message framework v936)
Date: Sun, 20 May 2012 14:46:21 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Carlos O'Donell <carlos@systemhalted.org>, Grant Grundler <grantgrundler@gmail.com>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20120520184621.tjQ63UQIGH8aU0JnwpQ6GjFEFzFCM4sGndCKJdESTjw@z>

On 20-May-12, at 5:04 AM, Al Viro wrote:

> Actually, looks like I am missing something, but it's not  
> particulary subtle.
> SYSCALL_TRACE is needed for do_syscall_trace_enter() to do anything;
> any of SYSCALL_TRACE/SINGLESTEP/BLOCKSTEP is makes  
> do_syscall_trace_leave()
> do things.  So checking one bit in flags is not enough - any of  
> those 3 is
> a reason for taking the slow path.  The point still stands, though -
> 	mfctl   %cr30, %r1
> 	LDREG   TI_FLAGS(%r1),%r1
> 	ldi	(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | _TIF_BLOCKSTEP), %r19
>        and,COND(=) %r19, %r1, %r0
> 	b,n	.Ltracesys
> would still be no worse on the fast path and would not hit the slow  
> path in
> a lot of cases when the current code does it for no apparent reason.
>
> Comments?

This looks good to me.  There is similar code in entry.S.

I added the above change to my patch set for stable 3.3.6.  System still
boots.  I singled stepped /bin/ls through a directory listing and it  
seemed
to work.

Dave
--
John David Anglin	dave.anglin@bell.net



