Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:51970 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab1HXC7Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Aug 2011 22:59:25 -0400
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
From: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
In-Reply-To: <2047151.mWElcT8jZQ@wuerfel>
References: <20110822193602.GA23301@codeaurora.org>
	 <2047151.mWElcT8jZQ@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Aug 2011 10:01:24 +0800
Message-ID: <1314151284.29738.34.camel@epip-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>, GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20110824020124.3e3tXZd7lfRbcSUNngI0JqlZFcnmiprHppQEMJiUlmk@z>

Hi, Linas,
  For unicore32, we have our own porting version of glibc, so conflict
problems are solved when one abi defined. We will modify the code of
kernel and glibc together to maintain the consistence.
  So, sadly, you must choose one to modify (patching and re-building),
otherwise you must choose old good-matched versions.
  For getdents (or other deprecated syscalls), we select getdents64 to
replace getdent, though we have not verified it on unicore32 platform. I
think it's reasonable, and perhaps modifying/rebuilding glibc is enough
for the whole file-system (there are always some applications which do
do syscalls and handle structs by themselves).
  Another words, compatibility is very important, so making the decision
with your team.

Guan Xuetao

On Mon, 2011-08-22 at 22:43 +0200, Arnd Bergmann wrote:
> On Monday 22 August 2011 14:36:02 Linas Vepstas wrote:
> > 
> > So: What's the latest on asm-generic support on glibc? 
> > I just pulled glibc-2.14 and note that Chris Metcalf's
> > generic implementation hasn't been folded in yet. 
> > It seems to work well for me, so can we expect it
> > anytime soon?
> > 
> > Another problem:  If I don't define __ARCH_WANT_SYSCALL_DEPRECATED
> > in the kernel asm/unistd.h  then glibc won't build: currently,
> > I get 
> > ../sysdeps/unix/sysv/linux/getdents.c:105: error: ‘__NR_getdents’ undeclared (first use in this function)
> > 
> > A very quick grep tells me that asm-generic defines a getdents64
> > but that is not what glibc is looking for.  Is there any chance
> > that there are glibc patches floating around somewhere that heal
> > this and any remaining __ARCH_WANT_SYSCALL_DEPRECATED issues?
> 
> I don't know the answer to your question, but I've added Mark Salter,
> Guan Xuetao and Tobias Klauser to the list, since they probably have
> the same issue on c64x, unicore32 and nios2. c64x is currently nommu,
> but there is a similar problem with uclibc and I expect that architecture
> to grow an mmu at some point.
> 
> As far as I can tell, there is now a total of six architectures using
> the generic syscalls (not counting s*core, because that relies on
> the deprecated calls) and at least two unnamed ones waiting to have
> their coming-out, plus a few stagnated ports (lm32, arc, mmix, meta, ...)
> that would need to get converted if someone wanted to push kernel
> support upstream.
> 
> 	Arnd


