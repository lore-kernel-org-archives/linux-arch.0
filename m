Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57699 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1HVTgN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 15:36:13 -0400
Date: Mon, 22 Aug 2011 14:36:02 -0500
From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: __ARCH_WANT_SYSCALL_DEPRECATED
Message-ID: <20110822193602.GA23301@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org


Hi,

So: What's the latest on asm-generic support on glibc? 
I just pulled glibc-2.14 and note that Chris Metcalf's
generic implementation hasn't been folded in yet. 
It seems to work well for me, so can we expect it
anytime soon?

Another problem:  If I don't define __ARCH_WANT_SYSCALL_DEPRECATED
in the kernel asm/unistd.h  then glibc won't build: currently,
I get 
../sysdeps/unix/sysv/linux/getdents.c:105: error: ‘__NR_getdents’ undeclared (first use in this function)

A very quick grep tells me that asm-generic defines a getdents64
but that is not what glibc is looking for.  Is there any chance
that there are glibc patches floating around somewhere that heal
this and any remaining __ARCH_WANT_SYSCALL_DEPRECATED issues?

--linas 
