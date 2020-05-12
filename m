From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 12/14] prctl.2: Clarify the unsupported hardware case of EINVAL
Date: Tue, 12 May 2020 17:36:57 +0100
Message-ID: <1589301419-24459-13-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

prctls that are architecture-specific won't work on other
architectures, and arch-specific prctls that manipulate optional
hardware features likewise won't work if that hardware feature is
not present.

The established pattern seems to be to treat such prctls as if they
are unimplemented, when attempted on the wrong hardware.

Cover these cases with some generic weasel words in the closet
existing EINVAL clause.

Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
---
 man2/prctl.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 2361b44..7f511d2 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1616,7 +1616,8 @@ is an invalid address.
 .B EINVAL
 The value of
 .I option
-is not recognized.
+is not recognized,
+or not supported on this system.
 .TP
 .B EINVAL
 .I option
-- 
2.1.4
