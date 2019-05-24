Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389942AbfEXK00 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 06:26:26 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 2/8] mm: Reserve asm-generic prot flag 0x10 for arch use
Date: Fri, 24 May 2019 11:25:27 +0100
Message-ID: <1558693533-13465-3-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>, "H.J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, Andrew Jones <drjones@redhat.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Sudakshina Das <sudi.das@arm.com>, Paul Elliott <paul.elliott@arm.com>
Message-ID: <20190524102527.hza_VvQmbLMSUeexYQTxgcWbQGmq8McdZxQJHtYaac0@z>

The asm-generic mman definitions are used by a few architectures
that also define an arch-specific PROT flag with value 0x10.  This
currently applies to sparc and powerpc, and arm64 will soon join
in.

To help future maintainers, document the use of this flag in the
asm-generic header too.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 include/uapi/asm-generic/mman-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d..ad3c6e5 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -11,6 +11,7 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_SEM	0x8		/* page may be used for atomic ops */
+ /*			0x10		   reserved for arch-specific use */
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-- 
2.1.4
