From: Nadav Amit <namit@vmware.com>
Subject: [PATCH 2/6] x86/mm: temporary mm struct
Date: Thu, 30 Aug 2018 10:32:14 -0700
Message-ID: <20180830173218.238900-3-namit@vmware.com>
References: <20180830173218.238900-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830173218.238900-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>, Nadav Amit <namit@vmware.com>
List-Id: linux-arch.vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Sometimes we want to set a temporary page-table entries (PTEs) in one of
the cores, without allowing other cores to use - even speculatively -
these mappings. There are two benefits for doing so:

(1) Security: if sensitive PTEs are set, temporary mm prevents their use
in other cores. This hardens the security as it prevents exploding a
dangling pointer to overwrite sensitive data using the sensitive PTE.

(2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
remote page-tables.

To do so a temporary mm_struct can be used. Mappings which are private
for this mm can be set in the userspace part of the address-space.
During the whole time in which the temporary mm is loaded, interrupts
must be disabled.

The first use-case for temporary PTEs, which will follow, is for poking
the kernel text.

[ Commit message was written by Nadav ]

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index eeeb9289c764..96afc8c0cf15 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
 	return cr3;
 }
 
+typedef struct {
+	struct mm_struct *prev;
+} temporary_mm_state_t;
+
+static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
+{
+	temporary_mm_state_t state;
+
+	lockdep_assert_irqs_disabled();
+	state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, mm, current);
+	return state;
+}
+
+static inline void unuse_temporary_mm(temporary_mm_state_t prev)
+{
+	lockdep_assert_irqs_disabled();
+	switch_mm_irqs_off(NULL, prev.prev, current);
+}
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
-- 
2.17.1
