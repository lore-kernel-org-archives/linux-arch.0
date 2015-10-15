Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:49736 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932733AbbJOF7L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Oct 2015 01:59:11 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v4 35/79] asm-generic/sembuf.h: include asm/posix_types.h and asm/ipcbuf.h
Date: Thu, 15 Oct 2015 07:56:13 +0200
Message-ID: <1444888618-4506-36-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mikko.rapeli@iki.fi, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20151015055613.jtL2SnN68IqRgvu0-5XeCwmWkkxrtGKO7E92EqJtkdk@z>

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
2.5.0

