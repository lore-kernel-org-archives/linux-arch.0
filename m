From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 09/14] prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
Date: Tue, 12 May 2020 17:36:54 +0100
Message-ID: <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Fix a few very minor bits of punctuation in
PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
---
 man2/prctl.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 1e04859..e8eaf95 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1175,13 +1175,13 @@ The return value uses bits 0-3 with the following meaning:
 .TP
 .BR PR_SPEC_PRCTL
 Mitigation can be controlled per thread by
-.B PR_SET_SPECULATION_CTRL
+.BR PR_SET_SPECULATION_CTRL .
 .TP
 .BR PR_SPEC_ENABLE
 The speculation feature is enabled, mitigation is disabled.
 .TP
 .BR PR_SPEC_DISABLE
-The speculation feature is disabled, mitigation is enabled
+The speculation feature is disabled, mitigation is enabled.
 .TP
 .BR PR_SPEC_FORCE_DISABLE
 Same as
@@ -1228,11 +1228,11 @@ which is one of the following:
 The speculation feature is enabled, mitigation is disabled.
 .TP
 .BR PR_SPEC_DISABLE
-The speculation feature is disabled, mitigation is enabled
+The speculation feature is disabled, mitigation is enabled.
 .TP
 .BR PR_SPEC_FORCE_DISABLE
 Same as
-.B PR_SPEC_DISABLE
+.BR PR_SPEC_DISABLE ,
 but cannot be undone.
 A subsequent
 .B
-- 
2.1.4
