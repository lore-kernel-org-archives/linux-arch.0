From: Richard Weinberger <richard@nod.at>
Subject: Remove execution domain support v2
Date: Sun, 12 Apr 2015 22:57:01 +0200
Message-ID: <552ADC1D.5050206@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbbDLU53 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Apr 2015 16:57:29 -0400
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf

This is v2 of the exec domain removal series I've posted yesterday:
https://lkml.org/lkml/2015/4/11/181
I've omitted resending all patches again to lower the churn on LKML.

The whole series can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git exec_domain_rip_v2

Changes since v1:
- Fixed sparc and xtensa thread info offsets
  Special thanks to Guenter Roeck for reporting and testing!
- Fixed an unused variable on arm
  Thanks to Stephen Rothwell!
- Added David Millers ACK

Stephen, can you please add the tree to -next?

Original description:

A long time ago there was the idea to support different ABIs on Linux
Such that someone could use for example SCO UNIX binaries on Linux
without emulation. While the linux-abi project existed mostly as
out-of-tree patch it's core component, execution domains,
went mainline. An execution domain allows to specify mappings between
different ABIs, these mappings consist of signal, error, socket type,
socket options and addess familiy mappings.
Mainline has only support for signal mappings.
The signal mapping happens in the architecutre specific signal code.
Some archs support it, some not, most of them copy&pasted from i386.

While the mapping support is incomplete we have two in-kernel users of
execution domains.

1. RISC OS personality on ARM.
The Kconfig help message states that this feature is very experimental
and it is likely that it never worked as expected.
Russel is fine with the removal.

2. ia32 support on ia64.
This is a left over from:
commit 32974ad4907cdde6c9de612cd1b2ee0568fb9409 ([IA64] Remove COMPAT_IA32 support)
It registers a dummy Linux/x86 execdomain to make calls to
personality(PER_LINUX32) faster as the execution domain core code
would try to load a module.

As both users can be removed there is no user left and we can remove
execution domains support at all from the kernel.
The removal will make architecutre specific signal handling easier
and there is no need to keep execuction domains as this feature is
obviously incomplete and abandoned.

Guenter Roeck (1):
      sparc: Fix execution domain removal

Richard Weinberger (25):
      arm: Remove RISC OS personality
      ia64: Remove Linux/x86 exec domain support
      Remove execution domain support
      arm: Remove signal translation and exec_domain
      arm64: Remove signal translation and exec_domain
      blackfin: Autogenerate offsets in struct thread_info
      blackfin: Remove exec_domain usage
      frv: Remove signal translation and exec_domain
      m32r: Autogenerate offsets in struct thread_info
      m32r: Remove signal translation and exec_domain
      m68k: Remove signal translation and exec_domain
      microblaze: Remove signal translation and exec_domain
      mn10300: Remove signal translation and exec_domain
      s390: Remove signal translation and exec_domain
      sh: Remove signal translation and exec_domain
      sparc: Remove signal translation and exec_domain
      tile: Remove signal translation and exec_domain
      um: Remove signal translation and exec_domain
      unicore32: Remove signal translation and exec_domain
      x86: Remove signal translation and exec_domain
      xtensa: Autogenerate offsets in struct thread_info
      xtensa: Remove signal translation and exec_domain
      arc: Remove signal translation and exec_domain
      arch: Remove exec_domain from remaining archs
      Remove rest of exec domains.

Thanks,
//richard
