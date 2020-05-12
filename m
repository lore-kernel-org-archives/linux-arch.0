From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 03/14] prctl.2: tfix mis-description of thread ID values in procfs
Date: Tue, 12 May 2020 17:36:48 +0100
Message-ID: <1589301419-24459-4-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgELQhs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:48 -0400
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Under PR_SET_NAME, the [tid] value seen in procfs as
/proc/self/task/[tid] is mistakenly described as the name of the
thread, whereas really the name is on /proc/self/task/[tid]/comm.

Fix it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index a35b748..9736434 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -808,8 +808,10 @@ and retrieved using
 The attribute is likewise accessible via
 .IR /proc/self/task/[tid]/comm ,
 where
-.I tid
-is the name of the calling thread.
+.I [tid]
+is the the thread ID of the calling thread, as returned by
+.BR gettid (2).
+.\" prctl PR_GET_NAME
 .TP
 .BR PR_GET_NAME " (since Linux 2.6.11)"
 Return the name of the calling thread,
-- 
2.1.4
