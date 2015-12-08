From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Tue, 8 Dec 2015 04:49:37 +0000
Message-ID: <20151208044937.GK20997@ZenIV.linux.org.uk>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel>
 <20151208043648.GA2182@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38888 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbbLHEtn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 23:49:43 -0500
Content-Disposition: inline
In-Reply-To: <20151208043648.GA2182@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>

On Tue, Dec 08, 2015 at 05:36:49AM +0100, Ingo Molnar wrote:

> So are there any deep objections to doing this rename in a single, quick, 
> pain-minimized fashion right at the end of the next merge window, when the amount 
> of pending patches in various maintainer trees is at a cyclical minimum? We can 
> also keep an is_compat_task() migratory define for one more cycle just in case.

Again, what about sparc?  There we have both 64bit and 32bit syscalls possible
to issue from the same process *and* no indication which trap had been used;
how do you implement is_compat_syscall() there?  There's a TIF_32BIT, which
is used by mmap() and friends, signal delivery, etc., but that's not a matter
of which syscall flavour had been issued.  Said that, arch/sparc doesn't use
is_compat_task(); it's open-coded everywhere...
