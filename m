From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/6] prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
Date: Wed, 27 May 2020 22:17:35 +0100
Message-ID: <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1590614258-24728-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Add the PR_SPEC_DISABLE_NOEXEC mode added in Linux 5.1
for the PR_SPEC_STORE_BYPASS "misfeature" of
PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 man2/prctl.2 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index b6fb51c..cab9915 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1187,6 +1187,12 @@ The speculation feature is disabled, mitigation is enabled.
 Same as
 .B PR_SPEC_DISABLE
 but cannot be undone.
+.TP
+.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
+Same as
+.BR PR_SPEC_DISABLE ,
+but but the state will be cleared on
+.BR execve (2).
 .RE
 .IP
 If all bits are 0,
@@ -1251,6 +1257,17 @@ with the same value for
 .I arg2
 will fail with the error
 .BR EPERM .
+.\" commit 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
+.TP
+.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
+Same as
+.BR PR_SPEC_DISABLE ,
+but but the state will be cleared on
+.BR execve (2).
+Currently only supported for
+.I arg2
+equal to
+.B PR_SPEC_STORE_BYPASS.
 .RE
 .IP
 Any unsupported value in
@@ -1899,11 +1916,12 @@ was
 .BR PR_SET_SPECULATION_CTRL
 and
 .IR arg3
-is neither
+is not
 .BR PR_SPEC_ENABLE ,
 .BR PR_SPEC_DISABLE ,
+.BR PR_SPEC_FORCE_DISABLE ,
 nor
-.BR PR_SPEC_FORCE_DISABLE .
+.BR PR_SPEC_DISABLE_NOEXEC .
 .SH VERSIONS
 The
 .BR prctl ()
-- 
2.1.4
