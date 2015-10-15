Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:53582 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932681AbbJOF7J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Oct 2015 01:59:09 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v4 32/79] include/uapi/asm-generic/ipcbuf.h: include linux/posix_types.h
Date: Thu, 15 Oct 2015 07:56:10 +0200
Message-ID: <1444888618-4506-33-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mikko.rapeli@iki.fi, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20151015055610.ARbL5uDiersXbEhi0ncw3Bv6puLR3FbtF6EyI0a1wkQ@z>

Fixes userspace compilation error:

error: unknown type name ‘__kernel_key_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/ipcbuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
index 3dbcc1e..909f825 100644
--- a/include/uapi/asm-generic/ipcbuf.h
+++ b/include/uapi/asm-generic/ipcbuf.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_GENERIC_IPCBUF_H
 #define __ASM_GENERIC_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * The generic ipc64_perm structure:
  * Note extra padding because this structure is passed back and forth
-- 
2.5.0

