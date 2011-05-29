From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Sun, 29 May 2011 23:57:26 +0200
Message-ID: <201105292357.26883.arnd@arndb.de>
References: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com> <201105292027.10350.arnd@arndb.de> <1306704624.3001.1206.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63730 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab1E2V53 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 29 May 2011 17:57:29 -0400
In-Reply-To: <1306704624.3001.1206.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org

On Sunday 29 May 2011 23:30:24 Jonas Bonn wrote:
> > * remove all __ARCH_WANT_* from asm/unistd.h and use the generic glibc
> >   implementation.
> 
> I tried this earlier but ran into issues with uClibc, which is the only
> libc port that we currently have.  Is uClibc known to be compatible with
> the reduced set of syscalls?
> 
> A good compromise here may be to submit the patch upstream with the
> reduced set of syscalls but to maintain a separate tree locally that
> reenables these for use with our current uClibc port until we can get it
> straightened out.  It would be good to know, however, what's known to be
> working for others in this area...

I don't think that there is a port today, but you can maybe Chris Metcalf,
Guan Xuetao or Linas Vepstas know more about this, as they have all
worked on the glibc support for the generic syscall interface.

Right now, you set these five ones:

#define __ARCH_WANT_SYSCALL_NO_AT
#define __ARCH_WANT_SYSCALL_NO_FLAGS
#define __ARCH_WANT_SYSCALL_OFF_T
#define __ARCH_WANT_SYSCALL_DEPRECATED
#define __ARCH_WANT_IPC_PARSE_VERSION

I suggest that you try to get rid of them in reverse order, the last
two are the really important ones and should not cause a lot of
trouble at all. The interface impacted by this have long ago been
deprecated, so it should basically work without them, except for
possible bugs in uClibc.

__ARCH_WANT_SYSCALL_OFF_T is about the 32 bit off_t syscalls.
I don't know if they are supported in uClibc, but I would expect
that you can lose this if you hardcode uClibc to do 64 bit
off_t, but it could be a lot of work if it's not that easy.

The other three are for system calls that have been replaced by
new ones much more recently, so supporting them definitely requires
writing new libc code. You might be able to reuse the code that
Chris Metcalf wrote for glibc here.

As an intermediate solution, you can keep a private patch that
adds the hacks back in, while submitting the clean unistd.h
version without them for upstream inclusion. Just remember to
actually do the work for removing them eventually.

	Arnd
