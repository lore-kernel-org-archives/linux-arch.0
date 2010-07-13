From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 38/50] x86,memblock: Add memblock_x86_reserve_range/memblock_x86_free_range
Date: Tue, 13 Jul 2010 00:10:32 -0700
Message-ID: <1279005044-24777-39-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

they are wrappers for core versions.
they are taking start/end/name instead of base/size.
will make x86 conversion more easy

could add more debug print out

-v2: change get_max_mapped() to memblock.default_alloc_limit according to Michael
      Ellerman and Ben
     change to memblock_x86_reserve_range and memblock_x86_free_range according to Michael Ellerman
-v3: call check_and_double after reserve/free, so could avoid to use
      find_memblock_area. Suggested by Michael Ellerman

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/memblock.h |    3 +++
 arch/x86/mm/memblock.c          |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/memblock.h b/arch/x86/include/asm/memblock.h
index 69cf853..e11ddf0 100644
--- a/arch/x86/include/asm/memblock.h
+++ b/arch/x86/include/asm/memblock.h
@@ -6,4 +6,7 @@
 u64 memblock_x86_find_in_range_size(u64 start, u64 *sizep, u64 align);
 void memblock_x86_to_bootmem(u64 start, u64 end);
 
+void memblock_x86_reserve_range(u64 start, u64 end, char *name);
+void memblock_x86_free_range(u64 start, u64 end);
+
 #endif
diff --git a/arch/x86/mm/memblock.c b/arch/x86/mm/memblock.c
index 7986a12..80cdcf8 100644
--- a/arch/x86/mm/memblock.c
+++ b/arch/x86/mm/memblock.c
@@ -116,3 +116,25 @@ void __init memblock_x86_to_bootmem(u64 start, u64 end)
 		memblock_reserve(__pa(memblock.reserved.regions), sizeof(struct memblock_region) * memblock.reserved.max);
 }
 #endif
+
+void __init memblock_x86_reserve_range(u64 start, u64 end, char *name)
+{
+	if (start == end)
+		return;
+
+	if (WARN_ONCE(start > end, "memblock_x86_reserve_range: wrong range [%#llx, %#llx]\n", start, end))
+		return;
+
+	memblock_reserve(start, end - start);
+}
+
+void __init memblock_x86_free_range(u64 start, u64 end)
+{
+	if (start == end)
+		return;
+
+	if (WARN_ONCE(start > end, "memblock_x86_free_range: wrong range [%#llx, %#llx]\n", start, end))
+		return;
+
+	memblock_free(start, end - start);
+}
-- 
1.6.4.2
