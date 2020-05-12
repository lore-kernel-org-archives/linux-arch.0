Return-Path: <SRS0=WvJP=62=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgELQh5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:57 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 12/14] prctl.2: Clarify the unsupported hardware case of EINVAL
Date: Tue, 12 May 2020 17:36:57 +0100
Message-ID: <1589301419-24459-13-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200512163657.yzMUQfN7Rhwyph2g5-hEFzLLZ5PH05TQrc-mu1goFcQ@z>

prctls that are architecture-specific won't work on other
architectures, and arch-specific prctls that manipulate optional
hardware features likewise won't work if that hardware feature is
not present.

The established pattern seems to be to treat such prctls as if they
are unimplemented, when attempted on the wrong hardware.

Cover these cases with some generic weasel words in the closet
existing EINVAL clause.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
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
