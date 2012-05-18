Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34111 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab2ERS5N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 14:57:13 -0400
Date: Fri, 18 May 2012 19:57:12 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Message-ID: <20120518185712.GT22082@ZenIV.linux.org.uk>
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
Message-ID: <20120518185712.Fe0e1LqQRG4R4SW4pwmYCxZAruUCMQy0D3_rNNTS_Ac@z>

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

In any case, it doesn't look like something that might be HPUX-related -
there r28 is not used for arguments or syscall number either, as far
as I can tell...

That's a side story, in any case; whatever the reason for restoring
r28, it only masks the bug with double restarts.  If you enter syscall
with r28 equal to e.g. -ERESTARTNOINTR, get the same value from sys_whatever()
and have a couple of pending signals, you will have syscall_restart()
called twice, each time seeing regs->gr[28] == -ERESTARTNOINTR and leaving
it unchanged.  regs->gr[31] will be decremented by 8 on each of those
calls, first time back to your syscall (correctly), then to the entry point
of the first handler minus 8.
