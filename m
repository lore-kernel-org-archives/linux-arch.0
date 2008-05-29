From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 30/37] acorn: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:01 -0700
Message-ID: <1212092341.28403.132.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:41560 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbYE2UTE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:04 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083442wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:02 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/partitions/acorn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/partitions/acorn.c b/fs/partitions/acorn.c
index 3d3e166..cf4c1be 100644
--- a/fs/partitions/acorn.c
+++ b/fs/partitions/acorn.c
@@ -344,7 +344,7 @@ static inline int valid_ics_sector(const unsigned char *data)
 	for (i = 0, sum = 0x50617274; i < 508; i++)
 		sum += data[i];
 
-	sum -= le32_to_cpu(*(__le32 *)(&data[508]));
+	sum -= get_le32((__le32 *)&data[508]);
 
 	return sum == 0;
 }
-- 
1.5.6.rc0.277.g804cf
