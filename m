Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:60938 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbbAOI6W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jan 2015 03:58:22 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 15 Jan 2015 08:58:18 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/8] x86/spinlock: Leftover conversion ACCESS_ONCE->READ_ONCE
Date: Thu, 15 Jan 2015 09:58:30 +0100
Message-ID: <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>
Message-ID: <20150115085830.Q30-iBzZ751iEs9eVVtzjrQ9fWh0J5aU4U2ubr0p_y4@z>

commit 78bff1c8684f ("x86/ticketlock: Fix spin_unlock_wait() livelock")
introduced another ACCESS_ONCE case in x86 spinlock.h.

Change that as well.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 625660f..9264f0f 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -186,7 +186,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
 
 	for (;;) {
-		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
+		struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 		/*
 		 * We need to check "unlocked" in a loop, tmp.head == head
 		 * can be false positive because of overflow.
-- 
1.9.3

