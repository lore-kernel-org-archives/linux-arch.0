From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] TIF_NOTIFY_RESUME, arch/*/*/*signal*.c and all such
Date: Fri, 27 Apr 2012 20:34:13 +0100
Message-ID: <20120427193413.GM6871@ZenIV.linux.org.uk>
References: <20120420164239.GH6871@ZenIV.linux.org.uk>
 <CA+55aFzuTspDyyLaOA-g-dTWydaUeeWo9uVGR+rZ=ZJzPW_Ocw@mail.gmail.com>
 <20120420180748.GI6871@ZenIV.linux.org.uk>
 <20120423180150.GA6871@ZenIV.linux.org.uk>
 <20120424072617.GB6871@ZenIV.linux.org.uk>
 <20120426183742.GA324@redhat.com>
 <20120426231942.GJ6871@ZenIV.linux.org.uk>
 <20120427172444.GA30267@redhat.com>
 <20120427184528.GL6871@ZenIV.linux.org.uk>
 <CAMuHMdXTR1ug3sOyJ_PA0Yub2GsO5NCdAd71EX0Y9osq1ei5KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48863 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546Ab2D0TeS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Apr 2012 15:34:18 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXTR1ug3sOyJ_PA0Yub2GsO5NCdAd71EX0Y9osq1ei5KQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Roland McGrath <roland@hack.frob.com>, Greg Ungerer <gerg@uclinux.org>

On Fri, Apr 27, 2012 at 09:14:53PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 27, 2012 at 20:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> The only comment I have,
> >> 38671a3e831ed7327affb24d715f98bb99c80e56 m68k: add TIF_NOTIFY_RESUME and handle it
> >> forgets to unexport do_signal().
> >
> > Meh... ??The thing is, there are _two_ of them. ??signal_mm.c and signal_no.c
> > badly need merging, with common stuff moved to signal.c. ??I really hate
> 
> Greg recently posted a patch to merge them:
> http://www.spinics.net/lists/linux-m68k/msg04995.html

Nice...  BTW, could you comment on
    m68k: don't open-code block_sigmask()
    m68k: use set_current_blocked in sigreturn/rt_sigreturn
    m68k-nommu: do_signal() is only called when returning to user mode
    m68k: add TIF_NOTIFY_RESUME and handle it.
in signal.git tree?  The last one is really interesting...

Just pick the current tree - one that was there yesterday had a dumb typo
in thread_info.h part, so it wouldn't even compile (TIF_NOTIFE_RESUME
defined instead of TIF_NOTIFY_RESUME ;-/)
