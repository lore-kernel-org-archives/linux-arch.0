From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: sys_recvmmsg: wire up or not?
Date: Sat, 26 Dec 2009 12:12:13 +0100
Message-ID: <200912261212.14264.arnd@arndb.de>
References: <10f740e80912260239n17bbbd08w6c3065c12bde9c95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63808 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZLZLNK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2009 06:13:10 -0500
In-Reply-To: <10f740e80912260239n17bbbd08w6c3065c12bde9c95@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>

On Saturday 26 December 2009, Geert Uytterhoeven wrote:
> <stdin>:1523:2: warning: #warning syscall recvmmsg not implemented
> 
> so I started to wire up sys_recvmmsg.
> Then I noticed it's already accessible, through sys_socketcall, as m68k defines
> __ARCH_WANT_SYS_SOCKETCALL. So I guess this is a false positive?

Yes.

> Surprisingly, several architectures have both defined __ARCH_WANT_SYS_SOCKETCALL
> and wired up sys_recvmmsg. Is this intentional?

It's also rather inconsistent with the last socket call that was added, sys_accept4.
Some architectures that normally define socket calls (parisc, sh) are missing both
accept4 and recvmmsg, while others that don't have recvmsg now get recvmmsg.

In particular, i386 has recvmmsg now, which caused the warning that you saw.
I guess that one should be removed, and maybe we need a better logic for
determining which syscalls you actually want. Deriving it from asm-generic/unistd.h
instead of arch/x86/include/asm/unistd_32.h is probably better, but would still
give the wrong answer for multiplexed system calls like socketcall or ipc on 
existing architectures.

	Arnd
