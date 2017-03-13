Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdCMFvo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Mar 2017 01:51:44 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 25/26] x86: enable 5-level paging support
Date: Mon, 13 Mar 2017 08:50:19 +0300
Message-ID: <20170313055020.69655-26-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170313055019.SbzBBYuTBfvrL9xlekopVRhPK0TlZhCZ_51xSLERhsk@z>

Most of things are in place and we can enable support of 5-level paging.

Enabling XEN with 5-level paging requires more work. The patch makes XEN
dependent on !X86_5LEVEL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig     | 5 +++++
 arch/x86/xen/Kconfig | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 747f06f00a22..43b3343402f5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -317,6 +317,7 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
+	default 5 if X86_5LEVEL
 	default 4 if X86_64
 	default 3 if X86_PAE
 	default 2
@@ -1381,6 +1382,10 @@ config X86_PAE
 	  has the cost of more pagetable lookup overhead, and also
 	  consumes more pagetable space per process.
 
+config X86_5LEVEL
+	bool "Enable 5-level page tables support"
+	depends on X86_64
+
 config ARCH_PHYS_ADDR_T_64BIT
 	def_bool y
 	depends on X86_64 || X86_PAE
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 76b6dbd627df..b90d481ce5a1 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -5,6 +5,7 @@
 config XEN
 	bool "Xen guest support"
 	depends on PARAVIRT
+	depends on !X86_5LEVEL
 	select PARAVIRT_CLOCK
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
-- 
2.11.0
