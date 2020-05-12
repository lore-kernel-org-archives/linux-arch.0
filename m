Return-Path: <SRS0=WvJP=62=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgELQhs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:48 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 02/14] prctl.2: Add health warning
Date: Tue, 12 May 2020 17:36:47 +0100
Message-ID: <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200512163647.UlihfrNVSdGSJCIY5NcDROg9VbyGdWahC9s9sEXwMZU@z>

In reality, almost every prctl interferes with assumptions that the
compiler and C library / runtime rely on.  prctl() can therefore
make userspace explode in a variety ways that are likely to be hard
to debug.

This is not obvious to the uninitiated, so add a warning.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7932ada..a35b748 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -66,6 +66,11 @@ prctl \- operations on a process or thread
 manipulates various aspects of the behavior
 of the calling thread or process.
 .PP
+Note that careless use of
+.BR prctl ()
+can confuse the userspace run-time environment,
+so these operations should be used with care (if at all).
+.PP
 .BR prctl ()
 is called with a first argument describing what to do
 (with values defined in \fI<linux/prctl.h>\fP), and further
-- 
2.1.4
