From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Tue, 8 Dec 2015 05:15:05 +0000
Message-ID: <20151208051505.GL20997@ZenIV.linux.org.uk>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel>
 <20151208043648.GA2182@gmail.com>
 <20151208044937.GK20997@ZenIV.linux.org.uk>
 <20151208050148.GA3968@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38963 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbbLHFPK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2015 00:15:10 -0500
Content-Disposition: inline
In-Reply-To: <20151208050148.GA3968@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>

On Tue, Dec 08, 2015 at 06:01:48AM +0100, Ingo Molnar wrote:

> Hm, so if Sparc has no notion of compat-ness of the system call then how does it 
> implement runtime compat checks, such as AUDIT_ARCH et al?

Badly.  Things like compat_sys_ioctl() vs. ioctl() work (we use different
arrays of function pointers in 32bit and 64bit traps), but anything
dynamic assumes that things match the task.  Not that we had a lot of
such dynamic checks, actually...
