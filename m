From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] generic syscalls: wire up preadv2 and pwritev2 syscalls
Date: Sun, 24 Apr 2016 00:16:50 +0200
Message-ID: <3816292.4K8FR7W2O1@wuerfel>
References: <1460366266-29378-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:64825 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDWWRU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 23 Apr 2016 18:17:20 -0400
In-Reply-To: <1460366266-29378-1-git-send-email-andre.przywara@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 11 April 2016 10:17:46 Andre Przywara wrote:
> These new syscalls are implemented as generic code, so enable them for
> architectures like arm64 which use the generic syscall table.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 

I've forwarded it now as a pull request. Generally speaking, I'd much prefer
anyone who adds a syscall to update asm-generic/unistd.h as well
(as documented in Documentation/adding-syscalls.txt), there is no
need for me to put those patches into the asm-generic git tree first.

On a related topic, I've been thinking (for years) about coming up with a
way to have all future syscalls just get added to a single file in the
kernel to have them appended to the tables for all architectures. There
are two basic methods that seem appropriate here for avoiding the split
between unistd.h and syscalls.S:

a) The current asm-generic method of interleaving the __NR_* macro definitions
   and the entry in a .c file array, including the header multiple times
   to get all the tables
b) generating both files from an input like x86 does with
   arch/x86/entry/syscalls/ infrastructure

I think we need something similar to b) but with some extensions to allow
extending the architecture specific tables in a nice way, rather than
having to have one file per architecture.

	Arnd
