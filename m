From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] vmlinux.lds.h: drop unused __vermagic
Date: Sun, 30 Dec 2018 13:40:04 +0100
Message-ID: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Rusty Russell <rusty@rustcorp.com.au>, Jessica Yu <jeyu@kernel.org>
List-Id: linux-arch.vger.kernel.org

The reference to '__vermagic' is a relict from v2.5 times. And even
there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
("Module Sanity Check") in the historic tree) to v2.5.69 (commit
67ac5b866bda ("[PATCH] complete modinfo section")).

Neither current kernels nor modules contain a '__vermagic' section any
more, so get rid of it.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..530ce1e7a1ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -332,7 +332,6 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
-		KEEP(*(__vermagic))	/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
-- 
2.19.2
