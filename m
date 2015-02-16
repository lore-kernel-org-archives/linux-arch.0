Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:52548 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbbBPXHn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Feb 2015 18:07:43 -0500
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 30/45] include/uapi/asm-generic/shmbuf.h: include fixes
Date: Tue, 17 Feb 2015 00:05:33 +0100
Message-ID: <1424127948-22484-31-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150216230533.60-_NUmKvXZw1ee0_yD0gawAUffMfiEpjXW8OuQ73aI@z>

Fixes userspace compilation errors like:

error: field ‘shm_perm’ has incomplete type
struct ipc64_perm shm_perm; /* operation perms */
error: unknown type name ‘size_t’
error: unknown type name ‘__kernel_time_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/shmbuf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 7e9fb2f..24ef152 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -1,7 +1,13 @@
 #ifndef __ASM_GENERIC_SHMBUF_H
 #define __ASM_GENERIC_SHMBUF_H
 
+#include <linux/types.h>
 #include <asm/bitsperlong.h>
+#include <asm/msgbuf.h>
+
+#ifndef __KERNEL__
+#include <stdlib.h>
+#endif
 
 /*
  * The shmid64_ds structure for x86 architecture.
-- 
2.1.4

