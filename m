From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 0/2] Align MIPS swapper_pg_dir for faster code.
Date: Tue, 14 Aug 2012 11:07:59 -0700
Message-ID: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60312 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab2HNSII (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 14:08:08 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <david.daney@cavium.com>

From: David Daney <david.daney@cavium.com>

The MIPS swapper_pg_dir needs 64K alignment for faster TLB refills in
kernel mappings.  There are two parts to the patch set:

1) Modify generic vmlinux.lds.h to allow architectures to place
   additional sections at the start of .bss.  This allows alignment
   constraints to be met with minimal holes added for padding.
   Putting this in common code should reduce the risk of future
   changes to the linker scripts not being propagated to MIPS (or any
   other architecture that needs something like this).

2) Align the MIPS swapper_pg_dir.

Since the initial use of the code is for MIPS, perhaps both parts
could be merged by Ralf's tree (after collecting any Acked-bys).

David Daney (2):
  vmlinux.lds.h: Allow architectures to add sections to the front of
    .bss
  MIPS: Align swapper_pg_dir to 64K for better TLB Refill code.

 arch/mips/kernel/vmlinux.lds.S    |   21 +++++++++++++++++++--
 arch/mips/mm/init.c               |   17 +++++++++--------
 include/asm-generic/vmlinux.lds.h |    9 +++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.7.2.3
