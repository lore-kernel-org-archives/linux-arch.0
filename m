Return-Path: <SRS0=lDRc=3L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:32856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbgAVVW0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jan 2020 16:22:26 -0500
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 12/12] arm64: mm: Display guarded pages in ptdump
Date: Wed, 22 Jan 2020 21:21:44 +0000
Message-ID: <20200122212144.6409-13-broonie@kernel.org>
In-Reply-To: <20200122212144.6409-1-broonie@kernel.org>
References: <20200122212144.6409-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Message-ID: <20200122212144.WfBzL8Djc3vgpFiiDc7QLFmMTyHi6XQYVn6RPs9dMKk@z>

v8.5-BTI introduces the GP field in stage 1 translation tables which
indicates that blocks and pages with it set are guarded pages for which
branch target identification checks should be performed. Decode this
when dumping the page tables to aid debugging.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 0a920b538a89..880bd5160dc2 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -143,6 +143,11 @@ static const struct prot_bits pte_bits[] = {
 		.val	= PTE_UXN,
 		.set	= "UXN",
 		.clear	= "   ",
+	}, {
+		.mask	= PTE_GP,
+		.val	= PTE_GP,
+		.set	= "GP",
+		.clear	= "  ",
 	}, {
 		.mask	= PTE_ATTRINDX_MASK,
 		.val	= PTE_ATTRINDX(MT_DEVICE_nGnRnE),
-- 
2.20.1
