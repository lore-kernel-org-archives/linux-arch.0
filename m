From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [RFC] TIF_NOTIFY_RESUME, arch/*/*/*signal*.c and all such
Date: Wed, 02 May 2012 11:37:50 +0100
Message-ID: <1335955070.18999.37.camel@mfleming-mobl1.ger.corp.intel.com>
References: <CA+55aFxia+u3VAf0qN-2wv7DyAQZK-Z8=n=cqUvo--+C905aFg@mail.gmail.com>
	 <20120420160848.GG6871@ZenIV.linux.org.uk>
	 <20120420164239.GH6871@ZenIV.linux.org.uk>
	 <CA+55aFzuTspDyyLaOA-g-dTWydaUeeWo9uVGR+rZ=ZJzPW_Ocw@mail.gmail.com>
	 <20120420180748.GI6871@ZenIV.linux.org.uk>
	 <20120423180150.GA6871@ZenIV.linux.org.uk>
	 <20120424072617.GB6871@ZenIV.linux.org.uk>
	 <20120426183742.GA324@redhat.com>
	 <20120426231942.GJ6871@ZenIV.linux.org.uk>
	 <20120427172444.GA30267@redhat.com>  <20120427175434.GA31524@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:38474 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751634Ab2EBKrS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 May 2012 06:47:18 -0400
In-Reply-To: <20120427175434.GA31524@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2012-04-27 at 19:54 +0200, Oleg Nesterov wrote:
> On 04/27, Oleg Nesterov wrote:
> >
> > Not only sigreturn. Just look at sigprocmask(SIG_SETMASK) callers, almost
> > all should be converted to use set_current_blocked(). For example, pselect.
> 
> which btw doesn't need sigsaved.
> 
> > The last thing. Matt, could you please look at
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/signal.git ? It seems to me
> > you already sent some of these changes (use set_current_blocked/block_sigmask).
> > Perhaps there are alreay in -mm or linux-next?
> 
> Forgot to add Matt, sorry for noise...

Any of the changes that aren't in Linus' tree will be in -mm and
linux-next. The ones currently in linux-next are,

07d969a parisc: use set_current_blocked() and block_sigmask()
5becb45 frv: use set_current_blocked() and block_sigmask()
3608417 blackfin: use set_current_blocked() and block_sigmask()
cd21f1a unicore32: use block_sigmask()
2bb36fd h8300: use set_current_blocked() and block_sigmask()
a624f4f score: use set_current_blocked() and block_sigmask()
2326e2e score: don't mask signals if we fail to setup signal stack
b2f6181 microblaze: use set_current_blocked() and block_sigmask()
f557a56 microblaze: fix signal masking
9ff7b4a microblaze: no need to reset handler if SA_ONESHOT
6cb49f5 microblaze: don't reimplement force_sigsegv()
bd9767f ia64: use set_current_blocked() and block_sigmask()
cdbc96c cris: use set_current_blocked() and block_sigmask()
295f127 mn10300: use set_current_blocked() and block_sigmask()
524987e m68k: use set_current_blocked() and block_sigmask()
f0c96a3 m32r: use set_current_blocked() and block_sigmask()
f0f0acd avr32: use block_sigmask()
ef64059 avr32: don't mask signals in the error path

... and this one from you, Oleg, that was sent as part of my series,

3e6c120 avr32: use set_current_blocked() in handle_signal/sys_rt_sigreturn

-- 
Matt Fleming, Intel Open Source Technology Center
