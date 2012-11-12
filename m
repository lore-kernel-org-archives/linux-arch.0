Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:57584 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab2KLLwY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 06:52:24 -0500
From: <Vineet.Gupta1@synopsys.com>
Subject: [RFC Patch v1 51/55] modpost: Ignore ARC specific non-alloc section
Date: Mon, 12 Nov 2012 17:19:09 +0530
Message-ID: <1352720953-24321-21-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1352720953-24321-1-git-send-email-vgupta@synopsys.com>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, arnd@arndb.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20121112114909.v7wJsLXNv9m8Jh1OBfsUjiQRJfrwrXN8LSmCp3ca0ys@z>

From: Vineet Gupta <vgupta@synopsys.com>

ARC relocatable object files contain one/more .gnu.linkonce.arcextmap.*
sections (collated into .arcextmap in final link). These sections are
used by debuggers to display the extension instructions and need-not be
loaded by target (hence !SHF_ALLOC)

This patch adds the section to modpost's ignore list to avoid the
following

======================>8========================
WARNING: vmlinux.o (.gnu.linkonce.arcextmap.inst.3.5.8): unexpected
non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.
======================>8========================

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 scripts/mod/modpost.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d93856..fbbdb8e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -830,6 +830,7 @@ static const char *section_white_list[] =
 	".toc*",
 	".xt.prop",				 /* xtensa */
 	".xt.lit",         /* xtensa */
+	".arcextmap*",     /* arc */
 	NULL
 };
 
-- 
1.7.4.1

