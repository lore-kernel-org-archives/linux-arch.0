Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57287 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbbIVKvM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Sep 2015 06:51:12 -0400
From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] generic syscalls: wire up userfaultfd syscall
Date: Tue, 22 Sep 2015 11:52:19 +0100
Message-ID: <1442919139-18027-1-git-send-email-andre.przywara@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com
Message-ID: <20150922105219.upqJQACGH7KAlUeHwc_Ga2fN487g54ojcSS0dyyWv2I@z>

Enable the new userfaultfd syscall in the generic syscall table.
Briefly tested on arm64 with the selftest from the tools directory.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8da542a..82c91bc 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -711,9 +711,11 @@ __SYSCALL(__NR_bpf, sys_bpf)
 __SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
 #define __NR_membarrier 282
 __SYSCALL(__NR_membarrier, sys_membarrier)
+#define __NR_userfaultfd 283
+__SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 
 #undef __NR_syscalls
-#define __NR_syscalls 283
+#define __NR_syscalls 284
 
 /*
  * All syscalls below here should go away really,
-- 
2.5.1

