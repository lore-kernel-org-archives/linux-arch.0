From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 10/14] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
Date: Tue, 12 May 2020 17:36:55 +0100
Message-ID: <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 man2/prctl.2 | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index e8eaf95..66417cf 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1213,11 +1213,20 @@ arguments must be specified as 0; otherwise the call fails with the error
 .\" commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee
 Sets the state of the speculation misfeature specified in
 .IR arg2 .
-Currently, the only permitted value for this argument is
+Currently, this argument must be one of:
+.RS
+.TP
 .B PR_SPEC_STORE_BYPASS
-(otherwise the call fails with the error
+speculative store bypass control, or
+.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
+.TP
+.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
+indirect branch speculation control.
+.RE
+.IP
+(Otherwise the call fails with the error
 .BR ENODEV ).
-This setting is a per-thread attribute.
+These settings are per-thread attributes.
 The
 .IR arg3
 argument is used to hand in the control value,
@@ -1235,13 +1244,16 @@ Same as
 .BR PR_SPEC_DISABLE ,
 but cannot be undone.
 A subsequent
-.B
-prctl(..., PR_SPEC_ENABLE)
+.BR prctl (\c
+.IR arg2 ,
+.BR PR_SPEC_ENABLE )
+with the same value for
+.I arg2
 will fail with the error
 .BR EPERM .
 .RE
 .IP
-Any other value in
+Any unsupported value in
 .IR arg3
 will result in the call failing with the error
 .BR ERANGE .
-- 
2.1.4
