From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: s390: appldata: using strncpy() instead of sprintf()
Date: Mon, 27 May 2013 10:59:19 +0800
Message-ID: <51A2CC07.5010100@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:28943 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab3E0DAK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 23:00:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>


'buf[2]' is 2 bytes length, and sprintf() will append '\0' at the end
of string "?\n", so original implementation is memory overflow.

Need use strncpy() instead of sprintf().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/s390/appldata/appldata_base.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index bae0f40..566ea87 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -212,7 +212,8 @@ appldata_timer_handler(ctl_table *ctl, int write,
 		return 0;
 	}
 	if (!write) {
-		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
+		len = strncpy(buf, appldata_timer_active ? "1\n" : "0\n",
+								sizeof(buf));
 		if (len > *lenp)
 			len = *lenp;
 		if (copy_to_user(buffer, buf, len))
@@ -317,7 +318,7 @@ appldata_generic_handler(ctl_table *ctl, int write,
 		return 0;
 	}
 	if (!write) {
-		len = sprintf(buf, ops->active ? "1\n" : "0\n");
+		len = strncpy(buf, ops->active ? "1\n" : "0\n", sizeof(buf));
 		if (len > *lenp)
 			len = *lenp;
 		if (copy_to_user(buffer, buf, len)) {
-- 
1.7.7.6
