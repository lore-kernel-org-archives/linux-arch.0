Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 6 Feb 2005 22:31:49 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050206213148.GI18245@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org> <20050205090619.C30866@flint.arm.linux.org.uk> <20050205154448.1cc89ee9.davem@davemloft.net> <20050206105047.GB6819@wotan.suse.de> <20050206131947.6524ece9.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206131947.6524ece9.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> If you allow userspace accesses to succeed during KERNEL_DS, so
> much bad stuff can happen.  We've demonstrated that several times
> with the compat layer bugs.

These are easy to review.

> 
> Why not make it trap on all platforms, instead of until someone hits
> it on sparc64 or similar?

Because access_ok is used very often and adding anything more
to it leads to excessive binary bloat. 

> Do you like finding bugs immediately, or at some random time
> in the future?  I like my bugs to jump up and down quickly
> saying "I'm a bug" instead of "try and find me sucker" :-)

If you want you could add a check with a CONFIG option
in the kernel debug menu. But I'm not sure it's worth it,
it would probably be somewhat ugly.

-Andi
