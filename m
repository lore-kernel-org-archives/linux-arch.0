From: Richard Weinberger <richard@nod.at>
Subject: Remove execution domain support
Date: Sat, 11 Apr 2015 22:47:39 +0200
Message-ID: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

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

[PATCH 01/24] arm: Remove RISC OS personality
[PATCH 02/24] ia64: Remove Linux/x86 exec domain support
[PATCH 03/24] Remove execution domain support
[PATCH 04/24] arm: Remove signal translation and exec_domain
[PATCH 05/24] arm64: Remove signal translation and exec_domain
[PATCH 06/24] blackfin: Autogenerate offsets in struct thread_info
[PATCH 07/24] blackfin: Remove exec_domain usage
[PATCH 08/24] frv: Remove signal translation and exec_domain
[PATCH 09/24] m32r: Autogenerate offsets in struct thread_info
[PATCH 10/24] m32r: Remove signal translation and exec_domain
[PATCH 11/24] m68k: Remove signal translation and exec_domain
[PATCH 12/24] microblaze: Remove signal translation and exec_domain
[PATCH 13/24] mn10300: Remove signal translation and exec_domain
[PATCH 14/24] s390: Remove signal translation and exec_domain
[PATCH 15/24] sh: Remove signal translation and exec_domain
[PATCH 16/24] sparc: Remove signal translation and exec_domain
[PATCH 17/24] tile: Remove signal translation and exec_domain
[PATCH 18/24] um: Remove signal translation and exec_domain
[PATCH 19/24] unicore32: Remove signal translation and exec_domain
[PATCH 20/24] x86: Remove signal translation and exec_domain
[PATCH 21/24] xtensa: Remove signal translation and exec_domain
[PATCH 22/24] arc: Remove signal translation and exec_domain
[PATCH 23/24] arch: Remove exec_domain from remaining archs
[PATCH 24/24] Remove rest of exec domains.

git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git exec_domain_rip_v1

Thanks,
//richard
