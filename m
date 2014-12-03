Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:39753 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaLCWa2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Dec 2014 17:30:28 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 3 Dec 2014 22:30:27 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/9] arm64/spinlock: Replace ACCESS_ONCE READ_ONCE
Date: Wed,  3 Dec 2014 23:30:18 +0100
Message-ID: <1417645821-54731-7-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20141203223018.A55eC8tDsK2-8HmZDLigBZ25wdcVNd-eQNxaZ-wuSMc@z>

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Change the spinlock code to replace ACCESS_ONCE with READ_ONCE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/arm64/include/asm/spinlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index c45b7b1..cee1287 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -99,12 +99,12 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
+	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	arch_spinlock_t lockval = ACCESS_ONCE(*lock);
+	arch_spinlock_t lockval = READ_ONCE(*lock);
 	return (lockval.next - lockval.owner) > 1;
 }
 #define arch_spin_is_contended	arch_spin_is_contended
-- 
1.9.3

