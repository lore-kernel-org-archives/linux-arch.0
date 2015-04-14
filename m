From: Andy Lutomirski <luto@kernel.org>
Subject: Re: Remove execution domain support
Date: Mon, 13 Apr 2015 18:21:41 -0700
Message-ID: <552C6BA5.4060309@kernel.org>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51285 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbbDNBVp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Apr 2015 21:21:45 -0400
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf

On 04/11/2015 01:47 PM, Richard Weinberger wrote:
> A long time ago there was the idea to support different ABIs on Linux
> Such that someone could use for example SCO UNIX binaries on Linux
> without emulation. While the linux-abi project existed mostly as
> out-of-tree patch it's core component, execution domains,
> went mainline. An execution domain allows to specify mappings between
> different ABIs, these mappings consist of signal, error, socket type,
> socket options and addess familiy mappings.
> Mainline has only support for signal mappings.
> The signal mapping happens in the architecutre specific signal code.
> Some archs support it, some not, most of them copy&pasted from i386.
>
> While the mapping support is incomplete we have two in-kernel users of
> execution domains.
>
> 1. RISC OS personality on ARM.
> The Kconfig help message states that this feature is very experimental
> and it is likely that it never worked as expected.
> Russel is fine with the removal.
>
> 2. ia32 support on ia64.
> This is a left over from:
> commit 32974ad4907cdde6c9de612cd1b2ee0568fb9409 ([IA64] Remove COMPAT_IA32 support)
> It registers a dummy Linux/x86 execdomain to make calls to
> personality(PER_LINUX32) faster as the execution domain core code
> would try to load a module.
>
> As both users can be removed there is no user left and we can remove
> execution domains support at all from the kernel.
> The removal will make architecutre specific signal handling easier
> and there is no need to keep execuction domains as this feature is
> obviously incomplete and abandoned.

I like this.

FWIW, we recently removed restart_block from thread_info, so I'm not too 
worried about fallout from removing another field.

--Andy
