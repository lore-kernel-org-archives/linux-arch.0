Return-Path: <SRS0=WvJP=62=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgELQhy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:54 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 09/14] prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
Date: Tue, 12 May 2020 17:36:54 +0100
Message-ID: <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200512163654.2EjcRtnMaQFD0831ofQ_g63XIGs5Jz81fOcK3DRCPDg@z>

Fix a few very minor bits of punctuation in
PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
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
