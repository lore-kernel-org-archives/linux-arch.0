From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 32/38] powerpc: capture the violated protection key on fault
Date: Wed,  5 Jul 2017 14:22:09 -0700
Message-ID: <1499289735-14220-33-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

Capture the protection key that got violated in paca.
This value will be used by used to inform the signal
handler.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/paca.h   |    1 +
 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/mm/fault.c           |    3 +++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index c8bd1fc..0c06188 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -94,6 +94,7 @@ struct paca_struct {
 	u64 dscr_default;		/* per-CPU default DSCR */
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	u64 paca_amr;			/* value of amr at exception */
+	u16 paca_pkey;                  /* exception causing pkey */
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 #ifdef CONFIG_PPC_STD_MMU_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 17f5d8a..7dff862 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -244,6 +244,7 @@ int main(void)
 
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	OFFSET(PACA_AMR, paca_struct, paca_amr);
+	OFFSET(PACA_PKEY, paca_struct, paca_pkey);
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a6710f5..c8674a7 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -265,6 +265,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (error_code & DSISR_KEYFAULT) {
 		code = SEGV_PKUERR;
 		get_paca()->paca_amr = read_amr();
+		get_paca()->paca_pkey = get_pte_pkey(current->mm, address);
 		goto bad_area_nosemaphore;
 	}
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
@@ -290,6 +291,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+
 	/*
 	 * We want to do this outside mmap_sem, because reading code around nip
 	 * can result in fault, which will cause a deadlock when called with
@@ -453,6 +455,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 			is_exec, 0)) {
 		get_paca()->paca_amr = read_amr();
+		get_paca()->paca_pkey = vma_pkey(vma);
 		code = SEGV_PKUERR;
 		goto bad_area;
 	}
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
