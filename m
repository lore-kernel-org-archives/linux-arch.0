From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH] all: use compat version for preadv2 and pwritev2
Date: Mon, 2 May 2016 19:12:47 +0300
Message-ID: <1462205567-9767-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0063.outbound.protection.outlook.com ([157.56.110.63]:25212
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754321AbcEBQNH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 May 2016 12:13:07 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, andre.przywara@arm.com, hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>

Compat architectures that does not use generic unistd (mips, s390),
declare compat version in their syscall tables for preadv2 and
pwritev2. Generic unistd syscall table should do it as well.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/uapi/asm-generic/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6e0f5f0..c51afb7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -718,9 +718,9 @@ __SYSCALL(__NR_mlock2, sys_mlock2)
 #define __NR_copy_file_range 285
 __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
 #define __NR_preadv2 286
-__SYSCALL(__NR_preadv2, sys_preadv2)
+__SC_COMP(__NR_preadv2, sys_preadv2, compat_sys_preadv2)
 #define __NR_pwritev2 287
-__SYSCALL(__NR_pwritev2, sys_pwritev2)
+__SC_COMP(__NR_pwritev2, sys_pwritev2, compat_sys_pwritev2)
 
 #undef __NR_syscalls
 #define __NR_syscalls 288
-- 
2.5.0
