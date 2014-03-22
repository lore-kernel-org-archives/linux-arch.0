From: behanw@converseincode.com
Subject: [PATCH v3] LLVMLinux: Remove warning about returning an uninitialized variable
Date: Sat, 22 Mar 2014 09:35:36 -0700
Message-ID: <1395506136-1621-1-git-send-email-behanw@converseincode.com>
References: <20140322162147.GA9034@ravnborg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140322162147.GA9034@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Behan Webster <behanw@converseincode.com>, Mark Charlebois <charlebm@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: Behan Webster <behanw@converseincode.com>

Fix uninitialized return code in default case in cmpxchg-local.h

This patch fixes the code to prevent an uninitialized return value that is detected
when compiling with clang. The bug produces numerous warnings when compiling the
Linux kernel with clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
---
 include/asm-generic/cmpxchg-local.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index d8d4c89..a4f5882 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -41,6 +41,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
 		break;
 	default:
 		wrong_size_cmpxchg(ptr);
+		unreachable();
 	}
 	raw_local_irq_restore(flags);
 	return prev;
-- 
1.8.3.2
