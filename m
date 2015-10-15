Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:53167 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932729AbbJOF7K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Oct 2015 01:59:10 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v4 34/79] include/uapi/asm-generic/shmbuf.h: include fixes
Date: Thu, 15 Oct 2015 07:56:12 +0200
Message-ID: <1444888618-4506-35-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mikko.rapeli@iki.fi, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20151015055612.-jcL7AKCJ0n2lc-OqksYtGkNXu5Mrqg9dR9KhfVsrtY@z>

Include linux/types.h and asm/msgbuf.h and use __kernel_size_t instead
of size_t.

Fixes userspace compilation errors like:

error: field ‘shm_perm’ has incomplete type
struct ipc64_perm shm_perm; /* operation perms */
error: unknown type name ‘size_t’
error: unknown type name ‘__kernel_time_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/shmbuf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 7e9fb2f..ae867ad 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -1,7 +1,9 @@
 #ifndef __ASM_GENERIC_SHMBUF_H
 #define __ASM_GENERIC_SHMBUF_H
 
+#include <linux/types.h>
 #include <asm/bitsperlong.h>
+#include <asm/msgbuf.h>
 
 /*
  * The shmid64_ds structure for x86 architecture.
@@ -24,7 +26,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 #if __BITS_PER_LONG != 64
 	unsigned long		__unused1;
-- 
2.5.0

