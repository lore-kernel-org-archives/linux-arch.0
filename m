From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4/4] sparc: Automatically generate trivial UAPI headers
Date: Thu, 11 Oct 2012 17:18:05 +0100
Message-ID: <1349972285-22830-5-git-send-email-catalin.marinas@arm.com>
References: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33015 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab2JKQSO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2012 12:18:14 -0400
In-Reply-To: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>

This patch removes several trivial UAPI headers that were simply including
the asm-generic files as they can be automatically generated.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/Kbuild     | 5 +++--
 arch/sparc/include/uapi/asm/kvm_para.h | 1 -
 arch/sparc/include/uapi/asm/statfs.h   | 6 ------
 3 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/sparc/include/uapi/asm/statfs.h

diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/a=
sm/Kbuild
index ce175af..c7a460f 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -17,7 +17,6 @@ header-y +=3D ioctl.h
 header-y +=3D ioctls.h
 header-y +=3D ipcbuf.h
 header-y +=3D jsflash.h
-header-y +=3D kvm_para.h
 header-y +=3D mman.h
 header-y +=3D msgbuf.h
 header-y +=3D openpromio.h
@@ -39,7 +38,6 @@ header-y +=3D signal.h
 header-y +=3D socket.h
 header-y +=3D sockios.h
 header-y +=3D stat.h
-header-y +=3D statfs.h
 header-y +=3D swab.h
 header-y +=3D termbits.h
 header-y +=3D termios.h
@@ -49,3 +47,6 @@ header-y +=3D uctx.h
 header-y +=3D unistd.h
 header-y +=3D utrap.h
 header-y +=3D watchdog.h
+
+generic-y +=3D kvm_para.h
+generic-y +=3D statfs.h
diff --git a/arch/sparc/include/uapi/asm/kvm_para.h b/arch/sparc/include/ua=
pi/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/sparc/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
diff --git a/arch/sparc/include/uapi/asm/statfs.h b/arch/sparc/include/uapi=
/asm/statfs.h
deleted file mode 100644
index 55e607a..0000000
--- a/arch/sparc/include/uapi/asm/statfs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef ___ASM_SPARC_STATFS_H
-#define ___ASM_SPARC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
-#endif
