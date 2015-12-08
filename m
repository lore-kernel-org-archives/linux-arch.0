From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Tue, 8 Dec 2015 05:36:49 +0100
Message-ID: <20151208043648.GA2182@gmail.com>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38486 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbbLHEgx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 23:36:53 -0500
Content-Disposition: inline
In-Reply-To: <11525805.FykVOSlruZ@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 07 December 2015 15:12:59 Andy Lutomirski wrote:
> > Hi all-
> > 
> > Every time I look at is_compat_task, I cringe.  That function
> > determines whether we're in a compat syscall, not whether we're in a
> > compat task.  There are probably architectures (arm64?) under which
> > these are the same conditions, but they are definitely *not* the same
> > thing on x86.
> > 
> > Can we just fix it?  I propose the following patch:
> > 
> > $ find -type f |xargs sed -i -e 's/is_compat_task/in_compat_syscall/g'
> > 
> > If there's general agreement, can we do that at the end of the next
> > merge window?
> > 
> > I could also send a patch series to add in_compat_syscall, change all
> > the users, then delete the old stuff, but that seems overcomplicated
> > for something that's literally just renaming a token.
> 
> As far as I know, x86 is the special case here, on all other architectures, this 
> actually checks the task, and it's impossible to call a system call of the other 
> kind.

Well, even on architectures that don't allow mixed mode system calls for the same 
task the name 'in_compat_syscall()' is still correct: it just happens to also be a 
permanent condition for the life time of a task.

On architectures that allow mixed mode syscalls the assumption and confusion 
carried by the 'is_compat_task()' misnomer has resulted in real security bugs, 
hence Andy's suggestion for a rename.

So without my x86 hat on I'd still argue that 'is_compat_syscall()' is the more 
expressive (and hence more robust, safer) name. On architectures that don't care 
the change carries zero costs.

So are there any deep objections to doing this rename in a single, quick, 
pain-minimized fashion right at the end of the next merge window, when the amount 
of pending patches in various maintainer trees is at a cyclical minimum? We can 
also keep an is_compat_task() migratory define for one more cycle just in case.

Thanks,

	Ingo
