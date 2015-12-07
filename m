From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Tue, 08 Dec 2015 00:16:51 +0100
Message-ID: <11525805.FykVOSlruZ@wuerfel>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:55921 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbbLGXRA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 18:17:00 -0500
In-Reply-To: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Monday 07 December 2015 15:12:59 Andy Lutomirski wrote:
> Hi all-
> 
> Every time I look at is_compat_task, I cringe.  That function
> determines whether we're in a compat syscall, not whether we're in a
> compat task.  There are probably architectures (arm64?) under which
> these are the same conditions, but they are definitely *not* the same
> thing on x86.
> 
> Can we just fix it?  I propose the following patch:
> 
> $ find -type f |xargs sed -i -e 's/is_compat_task/in_compat_syscall/g'
> 
> If there's general agreement, can we do that at the end of the next
> merge window?
> 
> I could also send a patch series to add in_compat_syscall, change all
> the users, then delete the old stuff, but that seems overcomplicated
> for something that's literally just renaming a token.

As far as I know, x86 is the special case here, on all other architectures,
this actually checks the task, and it's impossible to call a system call
of the other kind.

	Arnd
