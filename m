From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] vfs.git: poll annotations
Date: Wed, 31 Jan 2018 04:46:20 +0000
Message-ID: <20180131044620.GF29051@ZenIV.linux.org.uk>
References: <20180130183939.GB29051@ZenIV.linux.org.uk>
 <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
 <20180131031300.GE29051@ZenIV.linux.org.uk>
 <CA+55aFyMh_cHUb37X6=8=DU2Zm8Cz=mhXYJcGGWqiC8LKLAoFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44376 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeAaEqW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jan 2018 23:46:22 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFyMh_cHUb37X6=8=DU2Zm8Cz=mhXYJcGGWqiC8LKLAoFA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jan 30, 2018 at 07:19:19PM -0800, Linus Torvalds wrote:
> On Tue, Jan 30, 2018 at 7:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > As for the place for mangle/demangle... where would you prefer them?
> 
> If we can make gcc generate ok code for the generic case and not need
> any arch-specific ones, why not just do in <linux/poll.h>?

Umm...  I'll try and see how well does that work.

> (And I guess POLLIN/OUT/ERR are standard, so it's only a couple that
> need to have potential help translating? That would make the helper
> inline smaller and simpler)

To quote a mail from last July:

||             common  bfin,frv,m68k,mips       xtensa  sparc
||WRNORM bit      8       2                       2       2
||WRBAND bit      9       8                       8       8
||MSG bit         10      10                      10      9
||REMOVE bit      12      12                      11      10
||RDHUP bit       13      13                      13      11
||
||Now, POLLREMOVE doesn't have EPOLL... equivalent, but others
||do.  As the result, blackfin, frv, m68k, mips and xtensa have
||EPOLLWRNORM matching POLLWRBAND and EPOLLWRBAND not matching
||anything.  sparc has EPOLLWRNORM matching POLLWRBAND, EPOLLWRBAND
||matching POLLMSG (and never triggered), EPOLLMSG matching POLLREMOVE
||(and also never triggered) and EPOLLRDHUP not matching anything.
||
||I don't believe that anything tries to use EPOLLMSG; EPOLLWRBAND
||and EPOLLWRNORM might be used (even though our manpage doesn't
||document either).  EPOLLRDHUP _is_ documented and flat-out does
||not work on sparc; the only way to catch POLLRDHUP via epoll
||there is to give it a value that is not any of EPOLL... constants.
||Hell knows if anything tries to do it there...

MSG and REMOVE are never triggered, so it's all down to {WR{NORM,BAND},RDHUP}.

Logics for mangle should be uniform - lower 8 bits left as is,
EPOLLWRBAND -> POLLWRBAND, EPOLLWRNORM -> POLLWRNORM, EPOLLRDHUP -> POLLRDHUP.

For demangle it's
if POLLOUT != POLLWRNORM
	pass as is
else
	lower 8 bits left as-is,
	if POLLOUT
		add EPOLLWRNORM
	POLLWRBAND -> EPOLLWRBAND
	POLLRDHUP -> EPOLLRDHUP

Frankly, it's a bloody mess - we either shouldn't have bothered with separate
POLLRDNORM and POLLWRNORM at all (they should be equivalent to POLLIN and POLLOUT
resp.) or kept them separate on all architectures.  What's more, we don't have
only one instance of POLLRDNORM that would not be a part of POLLIN | POLLRDNORM | ...
(modulo reordering).  Its definition, that is.  We do have a few instances of
->poll() that raise POLLIN without POLLRDNORM, but AFAICS they have only one
thing in common - "forgot to add POLLRDNORM or hadn't heard of it".  The set is
pretty much random...

It started in 2.1.23pre1; looks like the original braindamage came from SunOS compat
(in 1.3.93) and got propagated into generic when poll(2) was implemented.  Probably
we should've kept alpha and i386 POLL... definitions same as sparc ones...  Anyway,
it's at least 20 years too late for that.
