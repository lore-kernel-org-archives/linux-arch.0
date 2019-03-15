From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v11 12/14] bpf,
 arm64: untag user pointers in stack_map_get_build_id_offset
Date: Fri, 15 Mar 2019 20:51:36 +0100
Message-ID: <0e1bd7fbde338061ea54234b3b1bd5ab6102381e.1552679409.git.andreyknvl__14384.5328175061$1552679677$gmane$org@google.com>
References: <cover.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@k
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
List-Id: linux-arch.vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

stack_map_get_build_id_offset() uses provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag the user pointer in this function for doing the lookup and
calculating the offset, but save as is into the bpf_stack_build_id
struct.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/bpf/stackmap.c |  6 ++++--
 p                     | 45 -------------------------------------------
 2 files changed, 4 insertions(+), 47 deletions(-)
 delete mode 100644 p

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 950ab2f28922..bb89341d3faf 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -320,7 +320,9 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		vma = find_vma(current->mm, ips[i]);
+		u64 untagged_ip = untagged_addr(ips[i]);
+
+		vma = find_vma(current->mm, untagged_ip);
 		if (!vma || stack_map_get_build_id(vma, id_offs[i].build_id)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
@@ -328,7 +330,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
 			continue;
 		}
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + untagged_ip
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 	}
diff --git a/p b/p
deleted file mode 100644
index 9d6fa5386e55..000000000000
--- a/p
+++ /dev/null
@@ -1,45 +0,0 @@
-commit 1fa6fadf644859e8a6a8ecce258444b49be8c7ee
-Author: Andrey Konovalov <andreyknvl@google.com>
-Date:   Mon Mar 4 17:20:32 2019 +0100
-
-    kasan: fix coccinelle warnings in kasan_p*_table
-    
-    kasan_p4d_table, kasan_pmd_table and kasan_pud_table are declared as
-    returning bool, but return 0 instead of false, which produces a coccinelle
-    warning. Fix it.
-    
-    Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
-    Reported-by: kbuild test robot <lkp@intel.com>
-    Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
-
-diff --git a/mm/kasan/init.c b/mm/kasan/init.c
-index 45a1b5e38e1e..fcaa1ca03175 100644
---- a/mm/kasan/init.c
-+++ b/mm/kasan/init.c
-@@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
- #else
- static inline bool kasan_p4d_table(pgd_t pgd)
- {
--	return 0;
-+	return false;
- }
- #endif
- #if CONFIG_PGTABLE_LEVELS > 3
-@@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
- #else
- static inline bool kasan_pud_table(p4d_t p4d)
- {
--	return 0;
-+	return false;
- }
- #endif
- #if CONFIG_PGTABLE_LEVELS > 2
-@@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
- #else
- static inline bool kasan_pmd_table(pud_t pud)
- {
--	return 0;
-+	return false;
- }
- #endif
- pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
-- 
2.21.0.360.g471c308f928-goog
