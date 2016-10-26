From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 2/2] thread_info: include <current.h> for THREAD_INFO_IN_TASK
Date: Wed, 26 Oct 2016 18:43:07 +0100
Message-ID: <1477503787-25537-3-git-send-email-mark.rutland@arm.com>
References: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, keescook@chromium.org, luto@kernel.org, mark.rutland@arm.com
List-Id: linux-arch.vger.kernel.org

When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
macro relies on current having been defined prior to its use. However,
not all users of current_thread_info() include <asm/current.h>, and thus
current is not guaranteed to be defined.

When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
get_current() / current are based upon current_thread_info(), and
<asm/current.h> includes <asm/thread_info.h>. Thus always including
<asm/current.h> would result in circular dependences on some platforms.

To ensure both cases work, this patch includes <asm/current.h>, but only
when CONFIG_THREAD_INFO_IN_TASK is selected.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c75c6ab..ef1f4b0 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -12,6 +12,7 @@
 #include <linux/restart_block.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
+#include <asm/current.h>
 #define current_thread_info() ((struct thread_info *)current)
 #endif
 
-- 
1.9.1
