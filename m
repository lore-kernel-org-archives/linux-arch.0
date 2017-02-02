From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v5 6/8] uapi: includes linux/types.h before exporting files
Date: Thu,  2 Feb 2017 14:25:08 +0100
Message-ID: <1486041910-2665-7-git-send-email-nicolas.dichtel@6wind.com>
References: <20170131162133.GA8258@gmail.com>
 <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
List-Id: linux-arch.vger.kernel.org

Some files will be exported after the next patch. 0-day tests report the
following warning/error:
./usr/include/linux/bcache.h:8: include of <linux/types.h> is preferred over <asm/types.h>
./usr/include/linux/bcache.h:11: found __[us]{8,16,32,64} type without #include <linux/types.h>
./usr/include/linux/qrtr.h:8: found __[us]{8,16,32,64} type without #include <linux/types.h>
./usr/include/linux/cryptouser.h:39: found __[us]{8,16,32,64} type without #include <linux/types.h>
./usr/include/linux/media.h:29: included file 'linux/version.h' is not exported
./usr/include/linux/pr.h:14: found __[us]{8,16,32,64} type without #include <linux/types.h>
./usr/include/linux/btrfs_tree.h:337: found __[us]{8,16,32,64} type without #include <linux/types.h>
./usr/include/linux/seg6.h:21: found __[us]{8,16,32,64} type without #include <linux/types.h>
./usr/include/linux/seg6_hmac.h:11: found __[us]{8,16,32,64} type without #include <linux/types.h>

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/uapi/linux/bcache.h     | 2 +-
 include/uapi/linux/btrfs_tree.h | 2 ++
 include/uapi/linux/cryptouser.h | 2 ++
 include/uapi/linux/media.h      | 1 -
 include/uapi/linux/pr.h         | 2 ++
 include/uapi/linux/seg6.h       | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 22b6ad31c706..e3bb0635e94a 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -5,7 +5,7 @@
  * Bcache on disk data structures
  */
 
-#include <asm/types.h>
+#include <linux/types.h>
 
 #define BITMASK(name, type, field, offset, size)		\
 static inline __u64 name(const type *k)				\
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d5ad15a106a7..6a261cb52d95 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1,6 +1,8 @@
 #ifndef _BTRFS_CTREE_H_
 #define _BTRFS_CTREE_H_
 
+#include <linux/types.h>
+
 /*
  * This header contains the structure definitions and constants used
  * by file system objects that can be retrieved using
diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
index 11d21fce14d6..c6a09c5261e7 100644
--- a/include/uapi/linux/cryptouser.h
+++ b/include/uapi/linux/cryptouser.h
@@ -18,6 +18,8 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include <linux/types.h>
+
 /* Netlink configuration messages.  */
 enum {
 	CRYPTO_MSG_BASE = 0x10,
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 4890787731b8..27c972903b3f 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -28,7 +28,6 @@
 #endif
 #include <linux/ioctl.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 #define MEDIA_API_VERSION	KERNEL_VERSION(0, 1, 0)
 
diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
index 57d7c0f916b6..645ef3cf3dd0 100644
--- a/include/uapi/linux/pr.h
+++ b/include/uapi/linux/pr.h
@@ -1,6 +1,8 @@
 #ifndef _UAPI_PR_H
 #define _UAPI_PR_H
 
+#include <linux/types.h>
+
 enum pr_type {
 	PR_WRITE_EXCLUSIVE		= 1,
 	PR_EXCLUSIVE_ACCESS		= 2,
diff --git a/include/uapi/linux/seg6.h b/include/uapi/linux/seg6.h
index c396a8052f73..33496595064c 100644
--- a/include/uapi/linux/seg6.h
+++ b/include/uapi/linux/seg6.h
@@ -14,6 +14,8 @@
 #ifndef _UAPI_LINUX_SEG6_H
 #define _UAPI_LINUX_SEG6_H
 
+#include <linux/types.h>
+
 /*
  * SRH
  */
-- 
2.8.1
