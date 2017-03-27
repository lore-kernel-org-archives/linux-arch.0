Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:32774 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbdC0MVx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2017 08:21:53 -0400
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v11 07/12] btrfs_tree.h: fix include from userland
Date: Mon, 27 Mar 2017 14:20:12 +0200
Message-ID: <1490617217-30192-8-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1490617217-30192-1-git-send-email-nicolas.dichtel@6wind.com>
References: <CAK7LNAR_yp+O9jUZC8mKdaHgTiCkE7p2-ZbA9YZ8OGyp+uxhBQ@mail.gmail.com>
 <1490617217-30192-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yamada.masahiro@socionext.com
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, ldv@altlinux.org, nicolas.dichtel@6wind.com, herbert@gondor.apana.org.au, linux-rdma@vger.kernel.org
Message-ID: <20170327122012.5wDyLjgnViPyGPEW_qb86kwrXHtLvql3XVopU8D9YJM@z>

This patch prepares the uapi export by fixing the following errors:

.../linux/btrfs_tree.h:283:2: error: #error "UUID items require BTRFS_UUID_SIZE == 16!"
 #error "UUID items require BTRFS_UUID_SIZE == 16!"

.../linux/btrfs_tree.h:390:12: error: ‘BTRFS_UUID_SIZE’ undeclared here (not in a function)
  __u8 uuid[BTRFS_UUID_SIZE];
            ^
.../linux/btrfs_tree.h:796:16: error: ‘BTRFS_DEV_STAT_VALUES_MAX’ undeclared here (not in a function)
  __le64 values[BTRFS_DEV_STAT_VALUES_MAX];

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/uapi/linux/btrfs_tree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 6a261cb52d95..10689e1fdf11 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1,6 +1,7 @@
 #ifndef _BTRFS_CTREE_H_
 #define _BTRFS_CTREE_H_
 
+#include <linux/btrfs.h>
 #include <linux/types.h>
 
 /*
-- 
2.8.1
