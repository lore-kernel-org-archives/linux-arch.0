From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 11/28] ARCv2: extable: Enable sorting at build time
Date: Tue, 9 Jun 2015 17:18:11 +0530
Message-ID: <1433850508-26317-12-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:51814 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbbFILuQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:16 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 scripts/sortextable.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index 1052d4834a44..c2423d913b46 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -47,6 +47,10 @@
 #define EM_MICROBLAZE	189
 #endif
 
+#ifndef EM_ARCV2
+#define EM_ARCV2	195
+#endif
+
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static void *ehdr_curr; /* current ElfXX_Ehdr *  for resource cleanup */
@@ -281,6 +285,7 @@ do_file(char const *const fname)
 		custom_sort = sort_relative_table;
 		break;
 	case EM_ARCOMPACT:
+	case EM_ARCV2:
 	case EM_ARM:
 	case EM_AARCH64:
 	case EM_MICROBLAZE:
-- 
1.9.1
