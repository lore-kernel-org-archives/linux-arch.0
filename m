Return-Path: <SRS0=WvJP=62=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgELQhw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:52 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 07/14] prctl.2: Document removal of Intel MPX prctls
Date: Tue, 12 May 2020 17:36:52 +0100
Message-ID: <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20200512163652.1Mqkx3kIAH_A5vmOOiCw2h2hUe95bGLfaShaX-xITZs@z>

The Intel MPX API was removed from Linux 5.4.  See Linux
commit f240652b6032 ("x86/mpx: Remove MPX APIs")

Document this change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 man2/prctl.2 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7a3fc5c..a84fb1d 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -784,7 +784,7 @@ option enabled.
 .RE
 .\" prctl PR_MPX_ENABLE_MANAGEMENT
 .TP
-.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19) "
+.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19, removed in Linux 5.4; only on x86) "
 .\" commit fe3d197f84319d3bce379a9c0dc17b1f48ad358c
 .\" See also http://lwn.net/Articles/582712/
 .\" See also https://gcc.gnu.org/wiki/Intel%20MPX%20support%20in%20the%20GCC%20compiler
@@ -859,6 +859,12 @@ had been called.
 .IP
 For further information on Intel MPX, see the kernel source file
 .IR Documentation/x86/intel_mpx.txt .
+.IP
+.\" commit f240652b6032b48ad7fa35c5e701cc4c8d697c0b
+.\" See also https://lkml.kernel.org/r/20190705175321.DB42F0AD@viggo.jf.intel.com
+Due to a lack of toolchain support,
+.BR PR_MPX_ENABLE_MANAGEMENT " and " PR_MPX_DISABLE_MANAGEMENT
+are not supported by Linux 5.4 or later.
 .\" prctl PR_SET_NAME
 .TP
 .BR PR_SET_NAME " (since Linux 2.6.9)"
-- 
2.1.4
