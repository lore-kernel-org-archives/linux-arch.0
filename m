Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j19Dhedt069232
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 13:43:40 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j19Dhen1054190
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 14:43:40 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j19DhdmV012702
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 14:43:40 +0100
Date: Wed, 9 Feb 2005 14:43:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch] Fix shmget for ppc64, s390-64 & sparc64.
Message-ID: <20050209134342.GA5716@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, anton@samba.org, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi folks,
the patch for the shmget > 2GB problem. Please review,
Dave, Anton?

blue skies,
  Martin.

---

[patch] Fix shmget for ppc64, s390-64 & sparc64.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The second parameter of the sys_ipc system wrapper on ppc64,
s390-64 and sparc64 is an "int". sys_shmget gets called with
this 32 bit value as the size parameter. This limits the
maximum shared memory segment on these three architectures
to 2GB. To fix this the second parameter is declared as an
"unsigned long" and is then casted to the type required by the
different functions called by sys_ipc.
The same int vs. unsigned long bug is fixed for sys_msgsnd
and sys_msgrcv as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/ppc64/kernel/syscalls.c    |   40 +++++++++++++++++++++++-----------------
 arch/s390/kernel/sys_s390.c     |   29 ++++++++++++++++-------------
 arch/sparc64/kernel/sys_sparc.c |   27 +++++++++++++++------------
 3 files changed, 54 insertions(+), 42 deletions(-)

diff -urN linux-2.6/arch/ppc64/kernel/syscalls.c linux-2.6-patched/arch/ppc64/kernel/syscalls.c
--- linux-2.6/arch/ppc64/kernel/syscalls.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6-patched/arch/ppc64/kernel/syscalls.c	2005-02-09 14:21:40.000000000 +0100
@@ -57,7 +57,8 @@
  * This is really horribly ugly.
  */
 asmlinkage int 
-sys_ipc (uint call, int first, int second, long third, void __user *ptr, long fifth)
+sys_ipc (uint call, int first, unsigned long second, long third,
+	 void __user *ptr, long fifth)
 {
 	int version, ret;
 
@@ -67,15 +68,16 @@
 	ret = -ENOSYS;
 	switch (call) {
 	case SEMOP:
-		ret = sys_semtimedop (first, (struct sembuf __user *)ptr, second,
-				      NULL);
+		ret = sys_semtimedop (first, (struct sembuf __user *)ptr,
+				      (unsigned int) second, NULL);
 		break;
 	case SEMTIMEDOP:
-		ret = sys_semtimedop (first, (struct sembuf __user *)ptr, second,
+		ret = sys_semtimedop (first, (struct sembuf __user *)ptr,
+				      (unsigned int) second,
 				      (const struct timespec __user *) fifth);
 		break;
 	case SEMGET:
-		ret = sys_semget (first, second, third);
+		ret = sys_semget (first, (int) second, third);
 		break;
 	case SEMCTL: {
 		union semun fourth;
@@ -85,11 +87,12 @@
 			break;
 		if ((ret = get_user(fourth.__pad, (void __user * __user *)ptr)))
 			break;
-		ret = sys_semctl (first, second, third, fourth);
+		ret = sys_semctl (first, (int) second, third, fourth);
 		break;
 	}
 	case MSGSND:
-		ret = sys_msgsnd (first, (struct msgbuf __user *) ptr, second, third);
+		ret = sys_msgsnd (first, (struct msgbuf __user *) ptr,
+				  (size_t) second, third);
 		break;
 	case MSGRCV:
 		switch (version) {
@@ -103,27 +106,29 @@
 						(struct ipc_kludge __user *) ptr,
 						sizeof (tmp)) ? -EFAULT : 0))
 				break;
-			ret = sys_msgrcv (first, tmp.msgp, second, tmp.msgtyp,
-					  third);
+			ret = sys_msgrcv (first, tmp.msgp, (size_t) second,
+					  tmp.msgtyp, third);
 			break;
 		}
 		default:
 			ret = sys_msgrcv (first, (struct msgbuf __user *) ptr,
-					  second, fifth, third);
+					  (size_t) second, fifth, third);
 			break;
 		}
 		break;
 	case MSGGET:
-		ret = sys_msgget ((key_t) first, second);
+		ret = sys_msgget ((key_t) first, (int) second);
 		break;
 	case MSGCTL:
-		ret = sys_msgctl (first, second, (struct msqid_ds __user *) ptr);
+		ret = sys_msgctl (first, (int) second,
+				  (struct msqid_ds __user *) ptr);
 		break;
 	case SHMAT:
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = do_shmat (first, (char __user *) ptr, second, &raddr);
+			ret = do_shmat (first, (char __user *) ptr,
+					(int) second, &raddr);
 			if (ret)
 				break;
 			ret = put_user (raddr, (ulong __user *) third);
@@ -133,8 +138,8 @@
 			ret = -EINVAL;
 			if (!segment_eq(get_fs(), get_ds()))
 				break;
-			ret = do_shmat (first, (char __user *) ptr, second,
-					 (ulong *) third);
+			ret = do_shmat (first, (char __user *) ptr,
+					(int) second, (ulong *) third);
 			break;
 		}
 		break;
@@ -142,10 +147,11 @@
 		ret = sys_shmdt ((char __user *)ptr);
 		break;
 	case SHMGET:
-		ret = sys_shmget (first, second, third);
+		ret = sys_shmget (first, (size_t) second, third);
 		break;
 	case SHMCTL:
-		ret = sys_shmctl (first, second, (struct shmid_ds __user *) ptr);
+		ret = sys_shmctl (first, (int) second,
+				  (struct shmid_ds __user *) ptr);
 		break;
 	}
 
diff -urN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-patched/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/sys_s390.c	2005-02-09 14:21:40.000000000 +0100
@@ -145,7 +145,7 @@
  *
  * This is really horribly ugly.
  */
-asmlinkage long sys_ipc(uint call, int first, int second,
+asmlinkage long sys_ipc(uint call, int first, unsigned long second,
 				  unsigned long third, void __user *ptr)
 {
         struct ipc_kludge tmp;
@@ -153,24 +153,25 @@
 
         switch (call) {
         case SEMOP:
-		return sys_semtimedop (first, (struct sembuf __user *) ptr, second,
-				       NULL);
+		return sys_semtimedop (first, (struct sembuf __user *) ptr,
+				       (unsigned int) second, NULL);
 	case SEMTIMEDOP:
-		return sys_semtimedop (first, (struct sembuf __user *) ptr, second,
+		return sys_semtimedop (first, (struct sembuf __user *) ptr,
+				       (unsigned int) second,
 				       (const struct timespec __user *) third);
         case SEMGET:
-                return sys_semget (first, second, third);
+                return sys_semget (first, (int) second, third);
         case SEMCTL: {
                 union semun fourth;
                 if (!ptr)
                         return -EINVAL;
                 if (get_user(fourth.__pad, (void __user * __user *) ptr))
                         return -EFAULT;
-                return sys_semctl (first, second, third, fourth);
+                return sys_semctl (first, (int) second, third, fourth);
         }
         case MSGSND:
 		return sys_msgsnd (first, (struct msgbuf __user *) ptr,
-                                   second, third);
+                                   (size_t) second, third);
 		break;
         case MSGRCV:
                 if (!ptr)
@@ -179,15 +180,17 @@
                                     sizeof (struct ipc_kludge)))
                         return -EFAULT;
                 return sys_msgrcv (first, tmp.msgp,
-                                   second, tmp.msgtyp, third);
+                                   (size_t) second, tmp.msgtyp, third);
         case MSGGET:
-                return sys_msgget ((key_t) first, second);
+                return sys_msgget ((key_t) first, (int) second);
         case MSGCTL:
-                return sys_msgctl (first, second, (struct msqid_ds __user *) ptr);
+                return sys_msgctl (first, (int) second,
+				   (struct msqid_ds __user *) ptr);
 
 	case SHMAT: {
 		ulong raddr;
-		ret = do_shmat (first, (char __user *) ptr, second, &raddr);
+		ret = do_shmat (first, (char __user *) ptr,
+				(int) second, &raddr);
 		if (ret)
 			return ret;
 		return put_user (raddr, (ulong __user *) third);
@@ -196,9 +199,9 @@
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
-		return sys_shmget (first, second, third);
+		return sys_shmget (first, (size_t) second, third);
 	case SHMCTL:
-		return sys_shmctl (first, second,
+		return sys_shmctl (first, (int) second,
                                    (struct shmid_ds __user *) ptr);
 	default:
 		return -ENOSYS;
diff -urN linux-2.6/arch/sparc64/kernel/sys_sparc.c linux-2.6-patched/arch/sparc64/kernel/sys_sparc.c
--- linux-2.6/arch/sparc64/kernel/sys_sparc.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6-patched/arch/sparc64/kernel/sys_sparc.c	2005-02-09 14:21:40.000000000 +0100
@@ -199,7 +199,8 @@
  * This is really horribly ugly.
  */
 
-asmlinkage long sys_ipc(unsigned int call, int first, int second, unsigned long third, void __user *ptr, long fifth)
+asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
+			unsigned long third, void __user *ptr, long fifth)
 {
 	int err;
 
@@ -207,14 +208,15 @@
 	if (call <= SEMCTL) {
 		switch (call) {
 		case SEMOP:
-			err = sys_semtimedop(first, ptr, second, NULL);
+			err = sys_semtimedop(first, ptr,
+					     (unsigned int) second, NULL);
 			goto out;
 		case SEMTIMEDOP:
-			err = sys_semtimedop(first, ptr, second,
+			err = sys_semtimedop(first, ptr, (unsigned int) second,
 				(const struct timespec __user *) fifth);
 			goto out;
 		case SEMGET:
-			err = sys_semget(first, second, (int)third);
+			err = sys_semget(first, (int) second, (int)third);
 			goto out;
 		case SEMCTL: {
 			union semun fourth;
@@ -225,7 +227,7 @@
 			if (get_user(fourth.__pad,
 				     (void __user * __user *) ptr))
 				goto out;
-			err = sys_semctl(first, second | IPC_64,
+			err = sys_semctl(first, (int) second | IPC_64,
 					 (int)third, fourth);
 			goto out;
 		}
@@ -237,17 +239,18 @@
 	if (call <= MSGCTL) {
 		switch (call) {
 		case MSGSND:
-			err = sys_msgsnd(first, ptr, second, (int)third);
+			err = sys_msgsnd(first, ptr, (size_t) second,
+					 (int)third);
 			goto out;
 		case MSGRCV:
-			err = sys_msgrcv(first, ptr, second, fifth,
+			err = sys_msgrcv(first, ptr, (size_t) second, fifth,
 					 (int)third);
 			goto out;
 		case MSGGET:
-			err = sys_msgget((key_t) first, second);
+			err = sys_msgget((key_t) first, (int) second);
 			goto out;
 		case MSGCTL:
-			err = sys_msgctl(first, second | IPC_64, ptr);
+			err = sys_msgctl(first, (int) second | IPC_64, ptr);
 			goto out;
 		default:
 			err = -ENOSYS;
@@ -258,7 +261,7 @@
 		switch (call) {
 		case SHMAT: {
 			ulong raddr;
-			err = do_shmat(first, ptr, second, &raddr);
+			err = do_shmat(first, ptr, (int) second, &raddr);
 			if (!err) {
 				if (put_user(raddr,
 					     (ulong __user *) third))
@@ -270,10 +273,10 @@
 			err = sys_shmdt(ptr);
 			goto out;
 		case SHMGET:
-			err = sys_shmget(first, second, (int)third);
+			err = sys_shmget(first, (size_t) second, (int)third);
 			goto out;
 		case SHMCTL:
-			err = sys_shmctl(first, second | IPC_64, ptr);
+			err = sys_shmctl(first, (int) second | IPC_64, ptr);
 			goto out;
 		default:
 			err = -ENOSYS;
