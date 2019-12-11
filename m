Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLKSkj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:39 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 01/22] mm: Reserve asm-generic prot flags 0x10 and 0x20 for arch use
Date: Wed, 11 Dec 2019 18:40:06 +0000
Message-ID: <20191211184027.20130-2-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191211184006.M2MJyBTPCozZ_POEwgsBzbbNqddi77X0CrTwQZa3dJA@z>

From: Dave Martin <Dave.Martin@arm.com>

The asm-generic/mman.h definitions are used by a few architectures that
also define arch-specific PROT flags with value 0x10 and 0x20. This
currently applies to sparc and powerpc for 0x10, while arm64 will soon
join with 0x10 and 0x20.

To help future maintainers, document the use of this flag in the
asm-generic header too.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
[catalin.marinas@arm.com: reserve 0x20 as well]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/uapi/asm-generic/mman-common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index c160a5354eb6..f94f65d429be 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -11,6 +11,8 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_SEM	0x8		/* page may be used for atomic ops */
+/*			0x10		   reserved for arch-specific use */
+/*			0x20		   reserved for arch-specific use */
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
