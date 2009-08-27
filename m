From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL, v4] S+core architecture (arch/score) support
Date: Thu, 27 Aug 2009 16:00:37 +0200
Message-ID: <200908271600.37569.arnd@arndb.de>
References: <1251266324.16454.10.camel@ad3ser01> <200908261931.52645.arnd@arndb.de> <1251343739.23810.24.camel@ad3ser01>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59382 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbZH0OB0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2009 10:01:26 -0400
In-Reply-To: <1251343739.23810.24.camel@ad3ser01>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Liqin <liqin.chen@sunplusct.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Thursday 27 August 2009, Chen Liqin wrote:
> On Wed, 2009-08-26 at 19:31 +0200, Arnd Bergmann wrote:
> >
> I will remove these changelog from repository.

ok.

> > What is missing OTOH is a description of changes you made since
> > the last version you posted, which would be needed to help
> > people that have already reviewed your code before.
> > Also, you have dropped the descriptions of changes that I
> > contributed, committing the changed files as your own. If you
> > see a need to do that next time, please ask before you do it,
> > or find a way to keep the original commit logs.
> 
> How can I add old commit logs to our repository?
> Or add people's contribute to the log?

If you got a patch, use 'git am -s' to add that patch with it's
original changelog and signoff, plus your own signoff to the
git tree.

If something is already part of a git repository, the best way
is to use git to merge that tree with your own, using 'git pull'.
That will leave all the change history intact. It would be
good to start with the git tree in the way that is in my
repository, merge that with 2.6.31-rc6, and add your changes
on top of that, with proper change descriptions.

> > What is the status of the port now? Do you have a working glibc
> > and LTP test results, or are do you still need to fix more
> > bugs that got introduced in the 2.6.30 port?
> 
> In fact, we still need define 
> __ARCH_WANT_SYSCALL_NO_AT,
> __ARCH_WANT_SYSCALL_NO_FLAGS,
> __ARCH_WANT_SYSCALL_OFF_T,
> __ARCH_WANT_SYSCALL_DEPRECATED
> to make linux/score running, glibc and applictions 
> need old syscall API.
> And now it's really have some problems
> in syscall interface part.

ok.

> But if we use our old syscall interface replace the new one,
> score platform will run well.
> I am a little confused, whether or not I should commit
> score code use new or old syscall part?

I understand your problem here, and I think it would be good
to have second opinion from someone else here. The four
#defines you mention are roughly in reverse order of importance.

I think you really need to remove __ARCH_WANT_SYSCALL_DEPRECATED
and get that working. Please tell us if some system call is
giving you problems and we can find a solution together.

Removing __ARCH_WANT_SYSCALL_OFF_T should not be too hard, because
glibc uses the loff_t versions by default anyway. I have not tried
it though, so it may be more complicated than I thought.

Now, removing __ARCH_WANT_SYSCALL_NO_AT and __ARCH_WANT_SYSCALL_NO_FLAGS
is a lot of work that I think we need to do, but I understand that you
might not want to touch all the common glibc code that is involved.
Ulrich Drepper recommended that new architectures should not have
these, and I believe that is the correct way forward. You are unfortunate
because glibc is not at all prepared for that. Nobody else is using
the generic system call table right now, so I think that if you
can't find a way to work without __ARCH_WANT_SYSCALL_NO_AT and
__ARCH_WANT_SYSCALL_NO_FLAGS, we should integrate them into the
main set of syscalls.

	Arnd <><
