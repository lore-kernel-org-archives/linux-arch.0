Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35571 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbbGIR4K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:10 -0400
Message-ID: <20150709175308.637859771@infradead.org>
Date: Thu, 09 Jul 2015 19:29:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 07/24] hexagon: Provide atomic_{or,xor,and}
References: <20150709172855.564686637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-hexagon-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150709172902.RKHFIaENQL0XbNqWCEYrM2grmtZ8-GM8ajH939XTr5g@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/hexagon/include/asm/atomic.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -131,6 +131,9 @@ static inline int atomic_##op##_return(i
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN


