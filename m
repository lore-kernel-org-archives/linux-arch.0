Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 6 Feb 2005 13:19:47 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050206131947.6524ece9.davem@davemloft.net>
In-Reply-To: <20050206105047.GB6819@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
	<20050205090619.C30866@flint.arm.linux.org.uk>
	<20050205154448.1cc89ee9.davem@davemloft.net>
	<20050206105047.GB6819@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 6 Feb 2005 11:50:48 +0100
Andi Kleen <ak@suse.de> wrote:

> > First, "set_fs(KERNEL_DS)" allows kernel mode access, but it absolutely
> > must not allow user mode accesses.  It seems to suggest we might need
> > some "addr_min" value for access_ok() checking purposes...
> 
> That's an unreasonable requirement which no architecture other than
> those with truly separate address spaces follow.

If you allow userspace accesses to succeed during KERNEL_DS, so
much bad stuff can happen.  We've demonstrated that several times
with the compat layer bugs.

Why not make it trap on all platforms, instead of until someone hits
it on sparc64 or similar?

Do you like finding bugs immediately, or at some random time
in the future?  I like my bugs to jump up and down quickly
saying "I'm a bug" instead of "try and find me sucker" :-)

The x86 access_ok() already checks the address against a base
stored in the current_thread_info(), all I'm proposing is
to add a low value to the range as well and to adjust it at
set_fs() time, which set_fs() is already effectively doing on x86.
