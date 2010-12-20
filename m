From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [concept & "good taste" review] persistent store
Date: Mon, 20 Dec 2010 09:18:25 -0800
Message-ID: <AANLkTikhbxs-FU2qjpup17QDd67R78puMNvP4GNRwiKX@mail.gmail.com>
References: <AANLkTim3OpjPysjdCLDuFgFOipmcxyr2ay5cvUAu5PHi@mail.gmail.com>
 <AANLkTinpYJddhgbf7=Pw_TtGrnWaC8fwo2xv1XRsT1w7@mail.gmail.com>
 <AANLkTimA4x8oWyq71nOxB=Otp3Y0i3Kcu27DG0ajaXUG@mail.gmail.com>
 <AANLkTinCG+E6ZzpeRqsJP+-qvNDQXW4VZFgJ1c-sTryL@mail.gmail.com>
 <4D0BEE1F.7020008@zytor.com> <AANLkTinwFt+KDKNEYP9MWQ7wGb9qk=E2Xa3RJB3+MJnN@mail.gmail.com>
 <AANLkTinoV_pL=Ygqq4qt4f8c+wsdc9r9K7rcJ58aHjD1@mail.gmail.com>
 <AANLkTikhtWjFBQmA111Q+2JGRudrRNAmegGThMagr4vF@mail.gmail.com>
 <20101219091752.GA16150@liondog.tnic> <AANLkTi=9UZ5BYWo5xT=jh0upRP6PraH4S=t=tL49YRdr@mail.gmail.com>
 <20101220072632.GA28020@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59861 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932421Ab0LTRYh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Dec 2010 12:24:37 -0500
In-Reply-To: <20101220072632.GA28020@liondog.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Tony Luck <tony.luck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>lin

On Sun, Dec 19, 2010 at 11:26 PM, Borislav Petkov <bp@alien8.de> wrote:
>
> IOW, the simple (maybe too simple) algo of the pstore could be something
> like:

Simple?

> 1. Got a relevant message from kernel, log it.
>
> 2. Am I still alive?

Umm. The "am I still alive" question is traditionally called "the
stopping problem", and is considered to be the traditional example of
_least_ simple problem there is. As in "fundamentally unsolvable".

Did we kill X? Did we happen to hold some critical lock when oopsing?
Was it syslogd itself that died and caused nothing further to be
saved, even if the machine otherwise seems to be fine? Or did the
filesystem go into read-only mode due to the problem and the rest of
the system is fine, but the disk is never going to see the messages?

In other words, the problem really is that "am I still alive" thing.
That's a seriously impossible question to answer.

What _can_ be answered is "did somebody write out the oops, then
fsync, and then notify us about it?" But without explicit notification
of "yeah, it really is saved off somewhere else", we really can't
tell.

We could do heuristics, of course, and they might even work in
practice (like "flush after half an hour if there has been actual work
done and the machine is clearly making progress").

                          Linus
