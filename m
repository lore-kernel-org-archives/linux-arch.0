Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbfLKSlB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:41:01 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 14/22] mm: Introduce arch_calc_vm_flag_bits()
Date: Wed, 11 Dec 2019 18:40:19 +0000
Message-ID: <20191211184027.20130-15-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20191211184019.g4QtCjY5T2bTmvsrYTs2c5uFCbTu0U_3kRBLlOj0ixY@z>

Similarly to arch_calc_vm_prot_bits(), introduce a dummy
arch_calc_vm_flag_bits() invoked from calc_vm_flag_bits(). This macro
can be overridden by architectures to insert specific VM_* flags derived
from the mmap() MAP_* flags.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/mman.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 4b08e9c9c538..c53b194c11a1 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -81,6 +81,10 @@ static inline void vm_unacct_memory(long pages)
 #define arch_calc_vm_prot_bits(prot, pkey) 0
 #endif
 
+#ifndef arch_calc_vm_flag_bits
+#define arch_calc_vm_flag_bits(flags) 0
+#endif
+
 #ifndef arch_vm_get_page_prot
 #define arch_vm_get_page_prot(vm_flags) __pgprot(0)
 #endif
@@ -131,7 +135,8 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
-	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
+	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       arch_calc_vm_flag_bits(flags);
 }
 
 unsigned long vm_commit_limit(void);
