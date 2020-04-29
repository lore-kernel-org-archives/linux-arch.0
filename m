Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 16/20] mm: remove early_pfn_in_nid() and CONFIG_NODES_SPAN_OTHER_NODES
Date: Wed, 29 Apr 2020 15:11:22 +0300
Message-ID: <20200429121126.17989-17-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121122.Gu6jWVv2WtV1YRG3pFQA-_-yW6ts42-x0bmjG8womrw@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The commit f47ac088c406 ("mm: memmap_init: iterate over memblock regions
rather that check each PFN") made early_pfn_in_nid() obsolete and since
CONFIG_NODES_SPAN_OTHER_NODES is only used to pick a stub or a real
implementation of early_pfn_in_nid() it is also not needed anymore.

Remove both early_pfn_in_nid() and the CONFIG_NODES_SPAN_OTHER_NODES.

Co-developed-by: Hoan Tran <Hoan@os.amperecomputing.com>
Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/Kconfig |  9 ---------
 arch/sparc/Kconfig   |  9 ---------
 arch/x86/Kconfig     |  9 ---------
 mm/page_alloc.c      | 20 --------------------
 4 files changed, 47 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5f86b22b7d2c..74f316deeae1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -685,15 +685,6 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
=20
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on NEED_MULTIPLE_NODES
-
 config STDBINUTILS
 	bool "Using standard binutils settings"
 	depends on 44x
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 795206b7b552..0e4f3891b904 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -286,15 +286,6 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
=20
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on NEED_MULTIPLE_NODES
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y if SPARC64
 	select SPARSEMEM_VMEMMAP_ENABLE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f8bf218a169c..1ec2a5e2fef6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1581,15 +1581,6 @@ config X86_64_ACPI_NUMA
 	---help---
 	  Enable ACPI SRAT based node topology detection.
=20
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on X86_64_ACPI_NUMA
-
 config NUMA_EMU
 	bool "NUMA emulation"
 	depends on NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8d112defaead..d35ca0996a09 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1541,26 +1541,6 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 }
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
=20
-#ifdef CONFIG_NODES_SPAN_OTHER_NODES
-/* Only safe to use early in boot when initialisation is single-threaded=
 */
-static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int nod=
e)
-{
-	int nid;
-
-	nid =3D __early_pfn_to_nid(pfn, &early_pfnnid_cache);
-	if (nid >=3D 0 && nid !=3D node)
-		return false;
-	return true;
-}
-
-#else
-static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int nod=
e)
-{
-	return true;
-}
-#endif
-
-
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
--=20
2.26.1
