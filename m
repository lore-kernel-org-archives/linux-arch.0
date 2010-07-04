From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 11/23] x86,lmb: Add lmb_x86_reserve_range/lmb_x86_free_range
Date: Sat,  3 Jul 2010 23:56:15 -0700
Message-ID: <1278226587-31213-12-git-send-email-yinghai@kernel.org>
References: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

they are wrappers for core versions.
they are taking start/end/name instead of base/size.
will make x86 conversion more easy

could add more debug print out

-v2: change get_max_mapped() to lmb.default_alloc_limit according to Michael
      Ellerman and Ben
     change to lmb_x86_reserve_range and lmb_x86_free_range according to Michael Ellerman
-v3: call check_and_double after reserve/free, so could avoid to use
      find_lmb_area. Suggested by Michael Ellerman

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/lmb.h |    3 +++
 arch/x86/mm/lmb.c          |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/lmb.h b/arch/x86/include/asm/lmb.h
index 4a1b299..a6f14c6 100644
--- a/arch/x86/include/asm/lmb.h
+++ b/arch/x86/include/asm/lmb.h
@@ -6,4 +6,7 @@
 u64 lmb_x86_find_in_range_size(u64 start, u64 *sizep, u64 align);
 void lmb_x86_to_bootmem(u64 start, u64 end);
 
+void lmb_x86_reserve_range(u64 start, u64 end, char *name);
+void lmb_x86_free_range(u64 start, u64 end);
+
 #endif
diff --git a/arch/x86/mm/lmb.c b/arch/x86/mm/lmb.c
index 61b292f..a6c2662 100644
--- a/arch/x86/mm/lmb.c
+++ b/arch/x86/mm/lmb.c
@@ -116,3 +116,25 @@ void __init lmb_x86_to_bootmem(u64 start, u64 end)
 		lmb_reserve(__pa(lmb.reserved.regions), sizeof(struct lmb_region) * lmb.reserved.max);
 }
 #endif
+
+void __init lmb_x86_reserve_range(u64 start, u64 end, char *name)
+{
+	if (start == end)
+		return;
+
+	if (WARN_ONCE(start > end, "lmb_x86_reserve_range: wrong range [%#llx, %#llx]\n", start, end))
+		return;
+
+	lmb_reserve(start, end - start);
+}
+
+void __init lmb_x86_free_range(u64 start, u64 end)
+{
+	if (start == end)
+		return;
+
+	if (WARN_ONCE(start > end, "lmb_x86_free_range: wrong range [%#llx, %#llx]\n", start, end))
+		return;
+
+	lmb_free(start, end - start);
+}
-- 
1.6.4.2
