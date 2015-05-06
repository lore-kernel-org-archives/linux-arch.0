Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:45131 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbbEFRuz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2015 13:50:55 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Wed, 6 May 2015 18:50:53 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH RFC 10/15] arm/futex: UP futex_atomic_cmpxchg_inatomic() relies on disabled preemption
Date: Wed,  6 May 2015 19:50:34 +0200
Message-ID: <1430934639-2131-11-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dahi@linux.vnet.ibm.com, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20150506175034.4zANPzvVnXgnSbCjf_hyuTFtb50lPtuWdCTSm3NlwIs@z>

The !CONFIG_SMP implementation of futex_atomic_cmpxchg_inatomic()
requires preemption to be disabled to guarantee mutual exclusion.
Let's make this explicit.

This patch is based on a patch by Sebastian Andrzej Siewior on the
-rt branch.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/arm/include/asm/futex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 4e78065..255bfd1 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -93,6 +93,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	preempt_disable();
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -104,6 +105,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "cc", "memory");
 
 	*uval = val;
+	preempt_enable();
+
 	return ret;
 }
 
-- 
2.1.4

