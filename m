Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:52219 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbbBPXHo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Feb 2015 18:07:44 -0500
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 31/45] asm-generic/sembuf.h: include asm/posix_types.h and asm/ipcbuf.h
Date: Tue, 17 Feb 2015 00:05:34 +0100
Message-ID: <1424127948-22484-32-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150216230534.wGmtYFODnTgS4hvGXGwgvsIabXAGitd3gfRwXxt9qJI@z>

Fixes userspace compilation errors like:

error: field ‘msg_perm’ has incomplete type
struct ipc64_perm msg_perm;
error: unknown type name ‘__kernel_ulong_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/sembuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 4cb2c13..17d523f 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -2,6 +2,8 @@
 #define __ASM_GENERIC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/posix_types.h>
+#include <asm/ipcbuf.h>
 
 /*
  * The semid64_ds structure for x86 architecture.
-- 
2.1.4

