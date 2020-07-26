From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] arm64: stop using <asm/compat.h> directly
Date: Sun, 26 Jul 2020 18:03:58 +0200
Message-ID: <20200726160401.311569-2-hch@lst.de>
References: <20200726160401.311569-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200726160401.311569-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Jan Kara <jack@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Always use <linux/compat.h> so that we can move more declarations to
common code.  In two of the three cases the asm include was in addition
to an existing one for <linux/compat.h> anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/stat.h | 2 +-
 arch/arm64/kernel/process.c   | 1 -
 arch/arm64/kernel/ptrace.c    | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index 3b4a62f5aeb0c3..1b5ac1ef5d04cc 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -10,7 +10,7 @@
 #ifdef CONFIG_COMPAT
 
 #include <linux/time.h>
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 /*
  * struct stat64 is needed for compat tasks only. Its definition is different
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6089638c7d43f4..70381900ef9b8a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -46,7 +46,6 @@
 
 #include <asm/alternative.h>
 #include <asm/arch_gicv3.h>
-#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1e02e98e68dd37..0497aaea782451 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -30,7 +30,6 @@
 #include <linux/tracehook.h>
 #include <linux/elf.h>
 
-#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/fpsimd.h>
-- 
2.27.0
