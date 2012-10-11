Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:32998 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756279Ab2JKQSO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2012 12:18:14 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3/4] s390: Automatically generate trivial UAPI headers
Date: Thu, 11 Oct 2012 17:18:04 +0100
Message-ID: <1349972285-22830-4-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
References: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20121011161804.XUrd0aQrvf_lDq8oV_k0VgkDg3cq62mGXJmZsihTzbk@z>

This patch removes several trivial UAPI headers that were simply including
the asm-generic files as they can be automatically generated.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/uapi/asm/Kbuild     | 19 ++++++++++---------
 arch/s390/include/uapi/asm/errno.h    | 11 -----------
 arch/s390/include/uapi/asm/fcntl.h    |  1 -
 arch/s390/include/uapi/asm/ioctl.h    |  1 -
 arch/s390/include/uapi/asm/mman.h     |  6 ------
 arch/s390/include/uapi/asm/param.h    |  6 ------
 arch/s390/include/uapi/asm/poll.h     |  1 -
 arch/s390/include/uapi/asm/resource.h | 13 -------------
 arch/s390/include/uapi/asm/sockios.h  |  6 ------
 arch/s390/include/uapi/asm/termbits.h |  6 ------
 10 files changed, 10 insertions(+), 60 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/errno.h
 delete mode 100644 arch/s390/include/uapi/asm/fcntl.h
 delete mode 100644 arch/s390/include/uapi/asm/ioctl.h
 delete mode 100644 arch/s390/include/uapi/asm/mman.h
 delete mode 100644 arch/s390/include/uapi/asm/param.h
 delete mode 100644 arch/s390/include/uapi/asm/poll.h
 delete mode 100644 arch/s390/include/uapi/asm/resource.h
 delete mode 100644 arch/s390/include/uapi/asm/sockios.h
 delete mode 100644 arch/s390/include/uapi/asm/termbits.h

diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm=
/Kbuild
index 7bf68ff..e364de2 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -9,23 +9,16 @@ header-y +=3D chsc.h
 header-y +=3D cmb.h
 header-y +=3D dasd.h
 header-y +=3D debug.h
-header-y +=3D errno.h
-header-y +=3D fcntl.h
-header-y +=3D ioctl.h
 header-y +=3D ioctls.h
 header-y +=3D ipcbuf.h
 header-y +=3D kvm.h
 header-y +=3D kvm_para.h
 header-y +=3D kvm_virtio.h
-header-y +=3D mman.h
 header-y +=3D monwriter.h
 header-y +=3D msgbuf.h
-header-y +=3D param.h
-header-y +=3D poll.h
 header-y +=3D posix_types.h
 header-y +=3D ptrace.h
 header-y +=3D qeth.h
-header-y +=3D resource.h
 header-y +=3D schid.h
 header-y +=3D sembuf.h
 header-y +=3D setup.h
@@ -34,15 +27,23 @@ header-y +=3D sigcontext.h
 header-y +=3D siginfo.h
 header-y +=3D signal.h
 header-y +=3D socket.h
-header-y +=3D sockios.h
 header-y +=3D stat.h
 header-y +=3D statfs.h
 header-y +=3D swab.h
 header-y +=3D tape390.h
-header-y +=3D termbits.h
 header-y +=3D termios.h
 header-y +=3D types.h
 header-y +=3D ucontext.h
 header-y +=3D unistd.h
 header-y +=3D vtoc.h
 header-y +=3D zcrypt.h
+
+generic-y +=3D errno.h
+generic-y +=3D fcntl.h
+generic-y +=3D ioctl.h
+generic-y +=3D mman.h
+generic-y +=3D param.h
+generic-y +=3D poll.h
+generic-y +=3D resource.h
+generic-y +=3D sockios.h
+generic-y +=3D termbits.h
diff --git a/arch/s390/include/uapi/asm/errno.h b/arch/s390/include/uapi/as=
m/errno.h
deleted file mode 100644
index 395e97d..0000000
--- a/arch/s390/include/uapi/asm/errno.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- *  S390 version
- *
- */
-
-#ifndef _S390_ERRNO_H
-#define _S390_ERRNO_H
-
-#include <asm-generic/errno.h>
-
-#endif
diff --git a/arch/s390/include/uapi/asm/fcntl.h b/arch/s390/include/uapi/as=
m/fcntl.h
deleted file mode 100644
index 46ab12d..0000000
--- a/arch/s390/include/uapi/asm/fcntl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/fcntl.h>
diff --git a/arch/s390/include/uapi/asm/ioctl.h b/arch/s390/include/uapi/as=
m/ioctl.h
deleted file mode 100644
index b279fe0..0000000
--- a/arch/s390/include/uapi/asm/ioctl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctl.h>
diff --git a/arch/s390/include/uapi/asm/mman.h b/arch/s390/include/uapi/asm=
/mman.h
deleted file mode 100644
index de23da1..0000000
--- a/arch/s390/include/uapi/asm/mman.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/*
- *  S390 version
- *
- *  Derived from "include/asm-i386/mman.h"
- */
-#include <asm-generic/mman.h>
diff --git a/arch/s390/include/uapi/asm/param.h b/arch/s390/include/uapi/as=
m/param.h
deleted file mode 100644
index c616821..0000000
--- a/arch/s390/include/uapi/asm/param.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASMS390_PARAM_H
-#define _ASMS390_PARAM_H
-
-#include <asm-generic/param.h>
-
-#endif /* _ASMS390_PARAM_H */
diff --git a/arch/s390/include/uapi/asm/poll.h b/arch/s390/include/uapi/asm=
/poll.h
deleted file mode 100644
index c98509d..0000000
--- a/arch/s390/include/uapi/asm/poll.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/poll.h>
diff --git a/arch/s390/include/uapi/asm/resource.h b/arch/s390/include/uapi=
/asm/resource.h
deleted file mode 100644
index ec23d1c..0000000
--- a/arch/s390/include/uapi/asm/resource.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  S390 version
- *
- *  Derived from "include/asm-i386/resources.h"
- */
-
-#ifndef _S390_RESOURCE_H
-#define _S390_RESOURCE_H
-
-#include <asm-generic/resource.h>
-
-#endif
-
diff --git a/arch/s390/include/uapi/asm/sockios.h b/arch/s390/include/uapi/=
asm/sockios.h
deleted file mode 100644
index 6f60eee..0000000
--- a/arch/s390/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_S390_SOCKIOS_H
-#define _ASM_S390_SOCKIOS_H
-
-#include <asm-generic/sockios.h>
-
-#endif
diff --git a/arch/s390/include/uapi/asm/termbits.h b/arch/s390/include/uapi=
/asm/termbits.h
deleted file mode 100644
index 71bf6ac..0000000
--- a/arch/s390/include/uapi/asm/termbits.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_S390_TERMBITS_H
-#define _ASM_S390_TERMBITS_H
-
-#include <asm-generic/termbits.h>
-
-#endif

