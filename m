Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:60230 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfEWAnK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:10 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:12 -0500
Message-ID: <20190523003916.20726-23-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 22/26] signal: Properly set TRACE_SIGNAL_LOSE_INFO in __send_signal
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003912.0JKKQqUqrerQfdVnIi1g1q2gsrKFjgP0kQVlj9Qm6TA@z>

Any time siginfo is not stored in the signal queue information is
lost.  Therefore set TRACE_SIGNAL_LOSE_INFO every time the code does
not allocate a signal queue entry, and a queue overflow abort is not
triggered.

Fixes: ba005e1f4172 ("tracepoint: Add signal loss events")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d92b636b4e9d..b2f0cf3a68aa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1131,23 +1131,22 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			copy_siginfo(&q->info, info);
 			break;
 		}
-	} else if (!is_si_special(info)) {
-		if (sig >= SIGRTMIN && info->si_code != SI_USER) {
-			/*
-			 * Queue overflow, abort.  We may abort if the
-			 * signal was rt and sent by user using something
-			 * other than kill().
-			 */
-			result = TRACE_SIGNAL_OVERFLOW_FAIL;
-			ret = -EAGAIN;
-			goto ret;
-		} else {
-			/*
-			 * This is a silent loss of information.  We still
-			 * send the signal, but the *info bits are lost.
-			 */
-			result = TRACE_SIGNAL_LOSE_INFO;
-		}
+	} else if (!is_si_special(info) &&
+		   sig >= SIGRTMIN && info->si_code != SI_USER) {
+		/*
+		 * Queue overflow, abort.  We may abort if the
+		 * signal was rt and sent by user using something
+		 * other than kill().
+		 */
+		result = TRACE_SIGNAL_OVERFLOW_FAIL;
+		ret = -EAGAIN;
+		goto ret;
+	} else {
+		/*
+		 * This is a silent loss of information.  We still
+		 * send the signal, but the *info bits are lost.
+		 */
+		result = TRACE_SIGNAL_LOSE_INFO;
 	}
 
 out_set:
-- 
2.21.0
