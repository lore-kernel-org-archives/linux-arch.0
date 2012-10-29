From: <gerg@snapgear.com>
Subject: [PATCH v2 10/11] m68k: switch to using the asm-generic sockios.h
Date: Mon, 29 Oct 2012 15:49:33 +1000
Message-ID: <1351489774-14263-11-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
List-Id: linux-arch.vger.kernel.org

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local sockios.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild         |    1 +
 arch/m68k/include/uapi/asm/Kbuild    |    1 -
 arch/m68k/include/uapi/asm/sockios.h |   13 -------------
 3 files changed, 1 insertions(+), 14 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/sockios.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 63ed062..2801fd5 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -28,6 +28,7 @@ generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
+generic-y += sockios.h
 generic-y += spinlock.h
 generic-y += statfs.h
 generic-y += termbits.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 19bd052..1e2314e 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -14,7 +14,6 @@ header-y += setup.h
 header-y += sigcontext.h
 header-y += signal.h
 header-y += socket.h
-header-y += sockios.h
 header-y += stat.h
 header-y += swab.h
 header-y += unistd.h
diff --git a/arch/m68k/include/uapi/asm/sockios.h b/arch/m68k/include/uapi/asm/sockios.h
deleted file mode 100644
index c04a239..0000000
--- a/arch/m68k/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ARCH_M68K_SOCKIOS__
-#define __ARCH_M68K_SOCKIOS__
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* __ARCH_M68K_SOCKIOS__ */
-- 
1.7.0.4
