From: Michael Kerrisk <mtk.manpages@googlemail.com>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Mon, 23 Feb 2009 16:55:03 +1300
Message-ID: <cfd18e0f0902221955habcd242m2aac2b9e5af8db90@mail.gmail.com>
References: <200902222252.45051.sf@sfritsch.de>
	 <20090222224924.GA13157@bombadil.infradead.org>
	 <20090223014224.GB13157@bombadil.infradead.org>
	 <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
	 <20090223030315.GC16891@parisc-linux.org>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:23242 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZBWDzF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 22:55:05 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1752779rvb.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2009 19:55:03 -0800 (PST)
In-Reply-To: <20090223030315.GC16891@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Carlos O'Donell <carlos@systemhalted.org>, Kyle McMartin <kyle@infradead.org>, linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

Matthew,

On 2/23/09, Matthew Wilcox <matthew@wil.cx> wrote:
> On Sun, Feb 22, 2009 at 09:43:36PM -0500, Carlos O'Donell wrote:
>> flock is not POSIX, it's an interface invented by 4.2BSD, and was
>> previously emulated by glibc. The glibc wrapper implemented flock with
>> fcntl and made sure to return EWOULDBLOCK.
>
> glibc's emulation of flock() using fcntl() really belongs to the Dark
> Ages of Linux.  According to the comments in the kernel, flock(2) was
> added in June 1995.  That's four years before parisc-linux really got
> going.
>
> The semantics of flock-locks and fcntl-locks are really, really
> different.  Emulating one with the other was a really bad idea.

Quite.

>> > +       ret = sys_flock(fd, cmd);
>> > +       if (ret == -EAGAIN)
>> > +               ret = -EWOULDBLOCK;     /* fuck you HPUX */
>>
>> A more robust solution would be?
>>
>> if ((ret == -EAGAIN) || (ret == -EWOULDBLOK))
>>         ret = -EWOULDBLOCK
>
> How would that differ from what Kyle wrote?  Why would you want to
> assign -EWOULDBLOCK to ret if ret is already -EWOULDBLOCK?
>
>> This covers our ass since POSIX says that EAGAIN and EWOULDBLOCK *may*
>> be the same.
>
> That's irrelevant.  The only thing that matters is what the kernel does.
>
>> > but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
>> > is going to reveal latent problems in this part of the kernel I would
>> > rather not delve into...
>>
>> The ABI is fixed, so all we can do is cleanup the uses in the kernel,
>> and make sure we adhere to the documented APIs.
>
> We actually can do better than this ...
>
> #ifdef __KERNEL__
> #define EWOULDBLOCK	EAGAIN
> #else
> #define EWOULDBLOCK	/* whatever the fuck HPUX uses */
> #endif
>
> Now our kernel never returns -EWOULDBLOCK, only -EAGAIN.  Correct
> applications must check for both.  Incorrect applications tend to only
> check for AGAIN, not WOULDBLOCK.  Problem solved.

I'm not sure how you define "correct" here.  An application that
follows the BSD implementation standard need only check for
EWOULDBLOCK from flock(), I believe.  (I can find no system that
documents otherwise for flock().)

If you are talking more generally, POSIX.1-2001, which doesn't specify
flock(), only refers to the use of EWOULDBLOCK in the context of
socket-related calls, where it says that a non-blocking call can fail
with either EAGAIN or EWOULDBLOCK, so I suppose that a portable
sockets application must check for both.  (In all other cases of
non-blocking calls (e.g., read()/write() from files other than
sockets, sigtimedwait(), lockf(), mq_send(), mq_receive()) that fail
in circumstances where they would otherwise block, the error is always
EAGAIN, with the exception noted earlier for fcntl(F_SETLK) (EACCES or
EWOULDBLOCK).)

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
