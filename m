Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	by smtps.tip.net.au (Postfix) with ESMTP id 1EAC1368002
	for <linux-arch@vger.kernel.org>; Wed, 23 Mar 2005 15:01:24 +1100 (EST)
Date: Wed, 23 Mar 2005 15:01:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] consolidate asm/ipc.h
Message-Id: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Mar_2005_15_01_23_+1100_IjqOwxzagVz9mw+U"
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__23_Mar_2005_15_01_23_+1100_IjqOwxzagVz9mw+U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

All the asm*/ipc.h files are basically the same (for things that are used)
so I have consolidated them all into asm-generic/ipc.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Built and booted on ppc64, built on ppc.

Diffstat looks like this:
 arch/x86_64/ia32/sys_ia32.c     |    1
 arch/x86_64/kernel/sys_x86_64.c |    1
 include/asm-arm/ipc.h           |   30 -----------------------------
 include/asm-arm26/ipc.h         |   29 ----------------------------
 include/asm-cris/ipc.h          |   36 -----------------------------------
 include/asm-frv/ipc.h           |   34 ---------------------------------
 include/asm-generic/ipc.h       |   31 ++++++++++++++++++++++++++++++
 include/asm-h8300/ipc.h         |   32 -------------------------------
 include/asm-i386/ipc.h          |   33 --------------------------------
 include/asm-m32r/ipc.h          |   36 -----------------------------------
 include/asm-m68k/ipc.h          |   32 -------------------------------
 include/asm-m68knommu/ipc.h     |    2 -
 include/asm-mips/ipc.h          |   34 ---------------------------------
 include/asm-ppc/ipc.h           |   30 -----------------------------
 include/asm-ppc64/ipc.h         |   35 ----------------------------------
 include/asm-s390/ipc.h          |   41 -----------------------------------=
-----
 include/asm-sh/ipc.h            |   33 --------------------------------
 include/asm-sh64/ipc.h          |    7 ------
 include/asm-sparc/ipc.h         |   33 --------------------------------
 include/asm-sparc64/ipc.h       |   34 ---------------------------------
 include/asm-v850/ipc.h          |   32 -------------------------------
 include/asm-x86_64/ipc.h        |    6 -----
 22 files changed, 49 insertions(+), 533 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/arch/x86_64/ia32/sys_ia32.c linus-compat_sys_ipc.1/arch/x86=
_64/ia32/sys_ia32.c
--- linus/arch/x86_64/ia32/sys_ia32.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.1/arch/x86_64/ia32/sys_ia32.c	2005-03-23 12:16:30.=
000000000 +1100
@@ -65,7 +65,6 @@
 #include <asm/types.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
-#include <asm/ipc.h>
 #include <asm/atomic.h>
 #include <asm/ldt.h>
=20
diff -ruN linus/arch/x86_64/kernel/sys_x86_64.c linus-compat_sys_ipc.1/arch=
/x86_64/kernel/sys_x86_64.c
--- linus/arch/x86_64/kernel/sys_x86_64.c	2004-05-31 19:02:00.000000000 +10=
00
+++ linus-compat_sys_ipc.1/arch/x86_64/kernel/sys_x86_64.c	2005-03-23 12:17=
:49.000000000 +1100
@@ -18,7 +18,6 @@
 #include <linux/personality.h>
=20
 #include <asm/uaccess.h>
-#include <asm/ipc.h>
 #include <asm/ia32.h>
=20
 /*
diff -ruN linus/include/asm-arm/ipc.h linus-compat_sys_ipc.1/include/asm-ar=
m/ipc.h
--- linus/include/asm-arm/ipc.h	2005-03-17 14:08:05.000000000 +1100
+++ linus-compat_sys_ipc.1/include/asm-arm/ipc.h	2005-03-23 11:46:12.000000=
000 +1100
@@ -1,29 +1 @@
-#ifndef __ASMARM_IPC_H
-#define __ASMARM_IPC_H
-
-/*=20
- * These are used to wrap system calls on ARM.
- *
- * See arch/arm/kernel/sys-arm.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-arm26/ipc.h linus-compat_sys_ipc.1/include/asm-=
arm26/ipc.h
--- linus/include/asm-arm26/ipc.h	2003-06-04 21:14:10.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-arm26/ipc.h	2005-03-23 11:46:36.0000=
00000 +1100
@@ -1,28 +1 @@
-#ifndef __ASMARM_IPC_H
-#define __ASMARM_IPC_H
-
-/*=20
- * These are used to wrap system calls on ARM.
- *
- * See arch/arm/kernel/sys-arm.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-cris/ipc.h linus-compat_sys_ipc.1/include/asm-c=
ris/ipc.h
--- linus/include/asm-cris/ipc.h	2003-07-11 10:41:26.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-cris/ipc.h	2005-03-23 11:47:00.00000=
0000 +1100
@@ -1,35 +1 @@
-#ifndef __CRIS_IPC_H__
-#define __CRIS_IPC_H__
-
-/*=20
- * These are used to wrap system calls on CRIS.
- *
- * See arch/cris/kernel/sys_cris.c for ugly details..
- *
- * Same as x86 version.
- *
- */
-struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-frv/ipc.h linus-compat_sys_ipc.1/include/asm-fr=
v/ipc.h
--- linus/include/asm-frv/ipc.h	2005-01-05 13:48:06.000000000 +1100
+++ linus-compat_sys_ipc.1/include/asm-frv/ipc.h	2005-03-23 11:47:24.000000=
000 +1100
@@ -1,33 +1 @@
-#ifndef __ASM_IPC_H__
-#define __ASM_IPC_H__
-
-/*
- * These are used to wrap system calls on FR-V
- *
- * See arch/frv/kernel/sys_frv.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC		25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
-
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-generic/ipc.h linus-compat_sys_ipc.1/include/as=
m-generic/ipc.h
--- linus/include/asm-generic/ipc.h	1970-01-01 10:00:00.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-generic/ipc.h	2005-03-23 11:44:17.00=
0000000 +1100
@@ -0,0 +1,31 @@
+#ifndef _ASM_GENERIC_IPC_H
+#define _ASM_GENERIC_IPC_H
+/*
+ * These are used to wrap system calls.
+ *
+ * See architecture code for ugly details..
+ */
+struct ipc_kludge {
+	struct msgbuf __user *msgp;
+	long msgtyp;
+};
+
+#define SEMOP		 1
+#define SEMGET		 2
+#define SEMCTL		 3
+#define SEMTIMEDOP	 4
+#define MSGSND		11
+#define MSGRCV		12
+#define MSGGET		13
+#define MSGCTL		14
+#define SHMAT		21
+#define SHMDT		22
+#define SHMGET		23
+#define SHMCTL		24
+
+/* Used by the DIPC package, try and avoid reusing it */
+#define DIPC            25
+
+#define IPCCALL(version,op)	((version)<<16 | (op))
+
+#endif	/* _ASM_GENERIC_IPC_H */
diff -ruN linus/include/asm-h8300/ipc.h linus-compat_sys_ipc.1/include/asm-=
h8300/ipc.h
--- linus/include/asm-h8300/ipc.h	2003-02-17 11:01:58.000000000 +1100
+++ linus-compat_sys_ipc.1/include/asm-h8300/ipc.h	2005-03-23 12:04:22.0000=
00000 +1100
@@ -1,31 +1 @@
-#ifndef __H8300_IPC_H__
-#define __H8300_IPC_H__
-
-/*=20
- * These are used to wrap system calls on H8/300.
- *
- * See arch/h8300/kernel/sys_h8300.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC		25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-i386/ipc.h linus-compat_sys_ipc.1/include/asm-i=
386/ipc.h
--- linus/include/asm-i386/ipc.h	2003-05-10 14:11:11.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-i386/ipc.h	2005-03-23 12:04:47.00000=
0000 +1100
@@ -1,32 +1 @@
-#ifndef __i386_IPC_H__
-#define __i386_IPC_H__
-
-/*=20
- * These are used to wrap system calls on x86.
- *
- * See arch/i386/kernel/sys_i386.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-m32r/ipc.h linus-compat_sys_ipc.1/include/asm-m=
32r/ipc.h
--- linus/include/asm-m32r/ipc.h	2004-09-17 17:06:56.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-m32r/ipc.h	2005-03-23 12:05:13.00000=
0000 +1100
@@ -1,35 +1 @@
-#ifndef __M32R_IPC_H__
-#define __M32R_IPC_H__
-
-/* orig : i386/ipc.h 2.6.0-test3 */
-
-/*
- * These are used to wrap system calls on x86.
- *
- * See arch/i386/kernel/sys_i386.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif	/* __M32R_IPC_H__ */
-
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-m68k/ipc.h linus-compat_sys_ipc.1/include/asm-m=
68k/ipc.h
--- linus/include/asm-m68k/ipc.h	2004-05-12 07:28:09.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-m68k/ipc.h	2005-03-23 12:05:29.00000=
0000 +1100
@@ -1,31 +1 @@
-#ifndef __m68k_IPC_H__
-#define __m68k_IPC_H__
-
-/*
- * These are used to wrap system calls on m68k.
- *
- * See arch/m68k/kernel/sys_m68k.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC		25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-m68knommu/ipc.h linus-compat_sys_ipc.1/include/=
asm-m68knommu/ipc.h
--- linus/include/asm-m68knommu/ipc.h	2002-11-02 03:37:46.000000000 +1100
+++ linus-compat_sys_ipc.1/include/asm-m68knommu/ipc.h	2005-03-23 12:05:44.=
000000000 +1100
@@ -1 +1 @@
-#include <asm-m68k/ipc.h>
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-mips/ipc.h linus-compat_sys_ipc.1/include/asm-m=
ips/ipc.h
--- linus/include/asm-mips/ipc.h	2003-08-02 09:37:34.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-mips/ipc.h	2005-03-23 12:06:00.00000=
0000 +1100
@@ -1,33 +1 @@
-#ifndef _ASM_IPC_H
-#define _ASM_IPC_H
-
-/*
- * These are used to wrap system calls on MIPS.
- *
- * See arch/mips/kernel/sysmips.c for ugly details..
- * FIXME: split up into ordinary syscalls ...
- */
-struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC		25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif /* _ASM_IPC_H */
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-ppc/ipc.h linus-compat_sys_ipc.1/include/asm-pp=
c/ipc.h
--- linus/include/asm-ppc/ipc.h	2003-09-24 10:56:02.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-ppc/ipc.h	2005-03-23 12:06:13.000000=
000 +1100
@@ -1,29 +1 @@
-#ifndef __PPC_IPC_H__
-#define __PPC_IPC_H__
-
-/*
- * These are used to wrap system calls on PowerPC.
- *
- * See arch/ppc/kernel/syscalls.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif /* __PPC_IPC_H__ */
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-ppc64/ipc.h linus-compat_sys_ipc.1/include/asm-=
ppc64/ipc.h
--- linus/include/asm-ppc64/ipc.h	2004-05-30 11:50:26.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-ppc64/ipc.h	2005-03-23 12:06:27.0000=
00000 +1100
@@ -1,34 +1 @@
-#ifndef __PPC64_IPC_H__
-#define __PPC64_IPC_H__
-
-/*=20
- * These are used to wrap system calls on PowerPC.
- *
- * See arch/ppc64/kernel/syscalls.c for ugly details..
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif /* __PPC64_IPC_H__ */
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-s390/ipc.h linus-compat_sys_ipc.1/include/asm-s=
390/ipc.h
--- linus/include/asm-s390/ipc.h	2004-06-15 08:15:08.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-s390/ipc.h	2005-03-23 12:06:43.00000=
0000 +1100
@@ -1,40 +1 @@
-/*
- *  include/asm-s390/ipc.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/ipc.h"
- */
-
-#ifndef __s390_IPC_H__
-#define __s390_IPC_H__
-
-/*=20
- * These are used to wrap system calls on S390.
- *
- * See arch/s390/kernel/sys_s390.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-sh/ipc.h linus-compat_sys_ipc.1/include/asm-sh/=
ipc.h
--- linus/include/asm-sh/ipc.h	2004-01-20 08:20:27.000000000 +1100
+++ linus-compat_sys_ipc.1/include/asm-sh/ipc.h	2005-03-23 12:06:55.0000000=
00 +1100
@@ -1,32 +1 @@
-#ifndef __ASM_SH_IPC_H
-#define __ASM_SH_IPC_H
-
-/*=20
- * These are used to wrap system calls on x86.
- *
- * See arch/i386/kernel/sys_i386.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif /* __ASM_SH_IPC_H */
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-sh64/ipc.h linus-compat_sys_ipc.1/include/asm-s=
h64/ipc.h
--- linus/include/asm-sh64/ipc.h	2004-06-30 00:44:46.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-sh64/ipc.h	2005-03-23 12:07:06.00000=
0000 +1100
@@ -1,6 +1 @@
-#ifndef __ASM_SH64_IPC_H
-#define __ASM_SH64_IPC_H
-
-#include <asm-sh/ipc.h>
-
-#endif /* __ASM_SH64_IPC_H */
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-sparc/ipc.h linus-compat_sys_ipc.1/include/asm-=
sparc/ipc.h
--- linus/include/asm-sparc/ipc.h	2004-06-02 07:45:40.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-sparc/ipc.h	2005-03-23 12:07:18.0000=
00000 +1100
@@ -1,32 +1 @@
-#ifndef __SPARC_IPC_H__
-#define __SPARC_IPC_H__
-
-/*=20
- * These are used to wrap system calls on the sparc.
- *
- * See arch/sparc/kernel/sys_sparc.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-sparc64/ipc.h linus-compat_sys_ipc.1/include/as=
m-sparc64/ipc.h
--- linus/include/asm-sparc64/ipc.h	2003-07-14 13:14:56.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-sparc64/ipc.h	2005-03-23 13:18:11.00=
0000000 +1100
@@ -1,33 +1 @@
-#ifndef __SPARC64_IPC_H__
-#define __SPARC64_IPC_H__
-
-/*=20
- * These are used to wrap system calls on the sparc.
- *
- * See arch/sparc64/kernel/sys_sparc32.c for ugly details..
- */
-struct ipc_kludge {
-	u32 msgp;
-	s32 msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC            25
-
-/* We don't need to maintain backward compatibility on 64bit, we've starte=
d fresh */
-#define IPCCALL(version,op)	(op)
-
-#endif
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-v850/ipc.h linus-compat_sys_ipc.1/include/asm-v=
850/ipc.h
--- linus/include/asm-v850/ipc.h	2002-11-02 03:38:12.000000000 +1100
+++ linus-compat_sys_ipc.1/include/asm-v850/ipc.h	2005-03-23 12:08:09.00000=
0000 +1100
@@ -1,31 +1 @@
-#ifndef __V850_IPC_H__
-#define __V850_IPC_H__
-
-/*=20
- * These are used to wrap system calls on v850.
- *
- * See arch/v850/kernel/syscalls.c for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-/* Used by the DIPC package, try and avoid reusing it */
-#define DIPC		25
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif /* __V850_IPC_H__ */
+#include <asm-generic/ipc.h>
diff -ruN linus/include/asm-x86_64/ipc.h linus-compat_sys_ipc.1/include/asm=
-x86_64/ipc.h
--- linus/include/asm-x86_64/ipc.h	2002-10-17 23:29:20.000000000 +1000
+++ linus-compat_sys_ipc.1/include/asm-x86_64/ipc.h	1970-01-01 10:00:00.000=
000000 +1000
@@ -1,6 +0,0 @@
-#ifndef __x8664_IPC_H__
-#define __x8664_IPC_H__
-
-/* dummy */
-
-#endif

--Signature=_Wed__23_Mar_2005_15_01_23_+1100_IjqOwxzagVz9mw+U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCQOoT4CJfqux9a+8RAppZAJ9FRdSKRP//kkco6sL/r95yxYu33ACfYcex
qznNiSz/P6XPNL3LSsZf+EY=
=JGPg
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Mar_2005_15_01_23_+1100_IjqOwxzagVz9mw+U--
