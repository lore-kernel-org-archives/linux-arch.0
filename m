From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 1/6] prctl.2: ffix use literal hyphens when referencing kernel docs
Date: Wed, 27 May 2020 22:17:33 +0100
Message-ID: <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0VS0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 17:18:26 -0400
In-Reply-To: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

There is one case of a cross-reference to a kernel documentation
filename that uses unescaped hyphens.

To avoid misrendering, escape these as \- similarly to other
instances.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 968a75a..dc99218 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1261,7 +1261,7 @@ This parameter may enforce a read-only policy which will result in the
 call failing with the error
 .BR ENXIO .
 For further details, see the kernel source file
-.IR Documentation/admin-guide/kernel-parameters.txt .
+.IR Documentation/admin\-guide/kernel\-parameters.txt .
 .\"
 .\" prctl PR_TASK_PERF_EVENTS_DISABLE
 .TP
-- 
2.1.4
