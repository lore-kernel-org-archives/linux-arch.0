Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50322 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030266AbaE3UFc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2014 16:05:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 06/32] isofs: fix timestamps beyond 2027
Date: Fri, 30 May 2014 22:01:30 +0200
Message-ID: <1401480116-1973111-7-git-send-email-arnd@arndb.de>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20140530200130.emFUKiPkdLhkedcYUChmcyEhNr40C7Pa2p8P_3tgrMk@z>

isofs uses a 'char' variable to load the number of years since
1900 for an inode timestamp. On architectures that use a signed
char type by default, this results in an invalid date for
anything beyond 2027.

This adds a cast to 'u8' for the year number, which should extend
the shelf life of the file system until 2155.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/isofs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index 01e1ee7..28e7ff1 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -19,7 +19,7 @@ int iso_date(char * p, int flag)
 	int year, month, day, hour, minute, second, tz;
 	int crtime, days, i;
 
-	year = p[0] - 70;
+	year = (int)(u8)p[0] - 70;
 	month = p[1];
 	day = p[2];
 	hour = p[3];
-- 
1.8.3.2

