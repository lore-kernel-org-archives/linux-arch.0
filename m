Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967544AbdEYUeU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 16:34:20 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv1, RFC 8/8] x86/mm: Allow to boot without la57 if CONFIG_X86_5LEVEL=y
Date: Thu, 25 May 2017 23:33:34 +0300
Message-ID: <20170525203334.867-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170525203334.W9bGqZRzT3KusqDA7ytUZi63oKgCZKgNf-aL7tynwqw@z>

All pieces of the puzzle are in place and we can now allow to boot with
CONFIG_X86_5LEVEL=y on a machine without la57 support.

Kernel will detect that la57 is missing and fold p4d at runtime.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/required-features.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index d91ba04dd007..fac9a5c0abe9 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -53,12 +53,6 @@
 # define NEED_MOVBE	0
 #endif
 
-#ifdef CONFIG_X86_5LEVEL
-# define NEED_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#else
-# define NEED_LA57	0
-#endif
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT
 /* Paravirtualized systems may not have PSE or PGE available */
@@ -104,7 +98,7 @@
 #define REQUIRED_MASK13	0
 #define REQUIRED_MASK14	0
 #define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	(NEED_LA57)
+#define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
 
-- 
2.11.0
