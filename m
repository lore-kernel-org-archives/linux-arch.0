From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/39] lmb: Move lmb.c to mm/
Date: Thu,  8 Apr 2010 23:03:33 -0700
Message-ID: <1270793048-23796-5-git-send-email-yinghai@kernel.org>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

lmb.c is memory related, so move it to mm/. It is suggested by Ingo

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 lib/Makefile      |    2 --
 mm/Makefile       |    2 ++
 {lib => mm}/lmb.c |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {lib => mm}/lmb.c (100%)

diff --git a/lib/Makefile b/lib/Makefile
index 2e152ae..a463a4d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -85,8 +85,6 @@ obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
-obj-$(CONFIG_HAVE_LMB) += lmb.o
-
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
diff --git a/mm/Makefile b/mm/Makefile
index 6c2a73a..52492f9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -15,6 +15,8 @@ obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   $(mmu-y)
 obj-y += init-mm.o
 
+obj-$(CONFIG_HAVE_LMB) += lmb.o
+
 obj-$(CONFIG_BOUNCE)	+= bounce.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
diff --git a/lib/lmb.c b/mm/lmb.c
similarity index 100%
rename from lib/lmb.c
rename to mm/lmb.c
-- 
1.6.4.2
