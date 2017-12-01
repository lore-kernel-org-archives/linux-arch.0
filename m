From: Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH] audit: Avoid build failures on systems without renameat
Date: Fri,  1 Dec 2017 12:49:56 -0800
Message-ID: <20171201204956.8332-1-palmer@sifive.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47055 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdLAUxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Dec 2017 15:53:52 -0500
Received: by mail-pg0-f67.google.com with SMTP id b11so4969118pgu.13
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2017 12:53:52 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Olof Johansson <olof@lixom.net>

renameat has been deprecated in favor of renameat2 for new ports.  This
allows the audit tests to build on RISC-V.

Reviewed-by: Christoph Hellwig <hch@lst.de>
CC: Olof Johansson <olof@lixom.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/asm-generic/audit_dir_write.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/audit_dir_write.h b/include/asm-generic/audit_dir_write.h
index da09fb986459..dd5a9dd7a102 100644
--- a/include/asm-generic/audit_dir_write.h
+++ b/include/asm-generic/audit_dir_write.h
@@ -27,7 +27,9 @@ __NR_mknod,
 __NR_mkdirat,
 __NR_mknodat,
 __NR_unlinkat,
+#ifdef __NR_renameat
 __NR_renameat,
+#endif
 __NR_linkat,
 __NR_symlinkat,
 #endif
-- 
2.13.6
