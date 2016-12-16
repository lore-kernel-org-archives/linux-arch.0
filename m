Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:55252 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760762AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/13] fs: fix unsigned enum warning with gcc-4.2
Date: Fri, 16 Dec 2016 11:56:32 +0100
Message-ID: <20161216105634.235457-12-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105632.WD9Ol7sbS91CFlhCtf2CvseONcPFkpoDv9vTpsd8drw@z>

With arm-linux-gcc-4.2, almost every file we build in the kernel ends
up with this warning:

include/linux/fs.h:2648: warning: comparison of unsigned expression < 0 is always false

Later versions don't have this problem, but it's easy enough to
work around.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 398cf20a706d..782c2a292fd7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2645,7 +2645,7 @@ static const char * const kernel_read_file_str[] = {
 
 static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 {
-	if (id < 0 || id >= READING_MAX_ID)
+	if ((unsigned)id >= READING_MAX_ID)
 		return kernel_read_file_str[READING_UNKNOWN];
 
 	return kernel_read_file_str[id];
-- 
2.9.0

