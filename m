From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/17] UAPI: Alter the S390 asm include guards to be recognisable by the UAPI splitter
Date: Tue, 13 Dec 2011 10:04:08 +0000
Message-ID: <1323770653-19177-13-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Alter some of the S390 asm include guards to fit a pattern that the UAPI
splitter recognises.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 arch/s390/include/asm/chpid.h |    2 +-
 arch/s390/include/asm/itcw.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/chpid.h b/arch/s390/include/asm/chpid.h
index fc71d8a..8e88e22 100644
--- a/arch/s390/include/asm/chpid.h
+++ b/arch/s390/include/asm/chpid.h
@@ -6,7 +6,7 @@
  */
 
 #ifndef _ASM_S390_CHPID_H
-#define _ASM_S390_CHPID_H _ASM_S390_CHPID_H
+#define _ASM_S390_CHPID_H
 
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/arch/s390/include/asm/itcw.h b/arch/s390/include/asm/itcw.h
index a9bc5c3..fb1bedd 100644
--- a/arch/s390/include/asm/itcw.h
+++ b/arch/s390/include/asm/itcw.h
@@ -6,7 +6,7 @@
  */
 
 #ifndef _ASM_S390_ITCW_H
-#define _ASM_S390_ITCW_H _ASM_S390_ITCW_H
+#define _ASM_S390_ITCW_H
 
 #include <linux/types.h>
 #include <asm/fcx.h>
-- 
1.7.7.4
