Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:55340 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760765AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/13] KVM: arm: avoid binary number literals for gcc-4.2
Date: Fri, 16 Dec 2016 11:56:33 +0100
Message-ID: <20161216105634.235457-13-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105633.ISRqLT0HOo31-gmL_ssYqya0pIzC4Ffkr9ewO4wqEYU@z>

Old gcc versions prior to 4.3 don't understand the 0b... syntax for
numbers, and this seems to be the only instance in the kernel, so better
use hexadecimal instead.

arch/arm/include/asm/kvm_mmu.h:127:38: error: invalid suffix "b101" on integer constant

Fixes: 159793001d7d ("ARM: KVM: force cache clean on page fault when caches are off")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/kvm_mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 74a44727f8e1..61121300174f 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -124,7 +124,7 @@ struct kvm;
 
 static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_cp15(vcpu, c1_SCTLR) & 0b101) == 0b101;
+	return (vcpu_cp15(vcpu, c1_SCTLR) & 0x5) == 0x5;
 }
 
 static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
-- 
2.9.0

