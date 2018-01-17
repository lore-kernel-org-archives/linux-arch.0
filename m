Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753703AbeAQPZf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jan 2018 10:25:35 -0500
Subject: [PATCH 3/8] openrisc: Make THREAD_SIZE available to vmlinux.lds
From: David Howells <dhowells@redhat.com>
Date: Wed, 17 Jan 2018 15:25:22 +0000
Message-ID: <151620272282.22429.6464815290811380426.stgit@warthog.procyon.org.uk>
In-Reply-To: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
References: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180117152522._HnQN6rYwhjXHa3fDeb2eDNcrn-dUub0m5iMVLiNreo@z>

Make THREAD_SIZE available to vmlinux.lds on openrisc by including
asm/thread_info.h the linker script.

This allows init_stack to be allocated in the linker script in a subsequent
patch.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Stafford Horne <shorne@gmail.com>
cc: Jonas Bonn <jonas@southpole.se>
cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
cc: openrisc@lists.librecores.org
---

 arch/openrisc/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 00ddb7804be4..953bdcd54efe 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -28,6 +28,7 @@
 
 #include <asm/page.h>
 #include <asm/cache.h>
+#include <asm/thread_info.h>
 #include <asm-generic/vmlinux.lds.h>
 
 #ifdef __OR1K__
