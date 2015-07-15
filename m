Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from forward-corp1o.mail.yandex.net ([37.140.190.172]:59590 "EHLO
	forward-corp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754585AbbGOKAL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jul 2015 06:00:11 -0400
Subject: [PATCH v2 1/3] drivers/xen/preempt: use need_resched() instead of
 should_resched()
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Wed, 15 Jul 2015 12:52:01 +0300
Message-ID: <20150715095201.12246.49283.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20150715095201.rGGkqma2UIFLO5Hol-3F0H80wxmB0gT-Zqd7doKOUnQ@z>

This code is used only when CONFIG_PREEMPT=n and only in non-atomic context:
xen_in_preemptible_hcall is set only in privcmd_ioctl_hypercall().
Thus preempt_count is zero and should_resched() is equal to need_resched().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/xen/preempt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/preempt.c b/drivers/xen/preempt.c
index a1800c150839..08cb419eb4e6 100644
--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
 asmlinkage __visible void xen_maybe_preempt_hcall(void)
 {
 	if (unlikely(__this_cpu_read(xen_in_preemptible_hcall)
-		     && should_resched())) {
+		     && need_resched())) {
 		/*
 		 * Clear flag as we may be rescheduled on a different
 		 * cpu.

