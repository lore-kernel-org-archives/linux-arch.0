From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Thu, 6 Sep 2018 11:18:05 +0200
Message-ID: <20180906091805.GF24142@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906081300.GF24082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 10:13:00AM +0200, Peter Zijlstra wrote:
> No, you got it the first time. There are in fact more fixmap abusers;
> see drivers/acpi/apei/ghes.c.  Also, as long as set_fixmap() allows
> overwriting a _PAGE_PRESENT pte and has that dodgy
> __flush_tlb_one_kernel() in it, the broken remains (and can return).
> 
> So we need to fix fixmap, to either disallow overwriting a _PAGE_PRESENT
> pte, or to issue a full TLB invalidate.
> 
> Either fix will terminally break GHES, but that's OK, they've known
> about this issue since 2015 and haven't cared, so I can't be bothered
> about them.

The below, combined with your text_poke() patches (text_poke disabled
IRQs, so the below still complains, and I was lazy) makes my machine
(mostly) happy.

There's still some complaining before the poking_mm exists. Let me see
if I can't cure that.

---

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f372169..8df85fe66332 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -259,15 +260,27 @@ static pte_t *fill_pte(pmd_t *pmd, unsigned long vaddr)
 static void __set_pte_vaddr(pud_t *pud, unsigned long vaddr, pte_t new_pte)
 {
 	pmd_t *pmd = fill_pmd(pud, vaddr);
-	pte_t *pte = fill_pte(pmd, vaddr);
+	pte_t *ptep = fill_pte(pmd, vaddr);
 
-	set_pte(pte, new_pte);
+	pte_t pte = *ptep;
 
-	/*
-	 * It's enough to flush this one mapping.
-	 * (PGE mappings get flushed as well)
-	 */
-	__flush_tlb_one_kernel(vaddr);
+	set_pte(ptep, new_pte);
+
+	if (irqs_disabled()) {
+		WARN((pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) != pte_val(new_pte)),
+				"set_fixmap(%d, %lx), was: %lx",
+				(int)__virt_to_fix(vaddr),
+				pte_val(new_pte), pte_val(pte));
+
+		/*
+		 * It is _NOT_ enough to flush just the local mapping;
+		 * it might mostly work, but there is no guarantee a remote
+		 * CPU didn't load this entry into its TLB.
+		 */
+		__flush_tlb_one_kernel(vaddr);
+	} else {
+		flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
+	}
 }
 
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte)
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 52ae5438edeb..e3c415bdbfbf 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -19,6 +19,7 @@ config ACPI_APEI
 
 config ACPI_APEI_GHES
 	bool "APEI Generic Hardware Error Source"
+	depends on BROKEN
 	depends on ACPI_APEI
 	select ACPI_HED
 	select IRQ_WORK
