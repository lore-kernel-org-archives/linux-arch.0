Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Feb 2005 10:44:28 +0100
From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix compat shmget overflow
Message-ID: <20050209094428.GB23943@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: akpm@osdl.org, linux-arch@vger.kernel.org
Cc: corryk@us.ibm.com
List-ID: <linux-arch.vger.kernel.org>


This fixes an incorrect sign extension in the compat layer that 
breaks 32bit shmget that are >2GB. sys_shmget has a signed size_t size
argument, and the int size argument comming from 32bit user space would get 
sign extended to 64bit, which is wrong.

I fixed it on all compat architectures, except PPC64 which was already
ok. 

It was originally debugged and fixed by Karl Rister @ IBM for SLES9 on x86-64.

Signed-off-by: Andi Kleen <ak@suse.de>


diff -u linux-2.6.11rc3/arch/sparc64/kernel/sys_sparc32.c-X linux-2.6.11rc3/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.6.11rc3/arch/sparc64/kernel/sys_sparc32.c-X	2005-02-04 09:12:50.000000000 +0100
+++ linux-2.6.11rc3/arch/sparc64/kernel/sys_sparc32.c	2005-02-09 10:39:52.000000000 +0100
@@ -835,7 +835,7 @@
 			err = sys_shmdt(ptr);
 			goto out;
 		case SHMGET:
-			err = sys_shmget(first, second, third);
+			err = sys_shmget(first, (unsigned)second, third);
 			goto out;
 		case SHMCTL:
 			err = do_sys32_shmctl(first, second, ptr);
diff -u linux-2.6.11rc3/arch/ia64/ia32/sys_ia32.c-X linux-2.6.11rc3/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.11rc3/arch/ia64/ia32/sys_ia32.c-X	2005-02-04 09:12:42.000000000 +0100
+++ linux-2.6.11rc3/arch/ia64/ia32/sys_ia32.c	2005-02-09 10:39:03.000000000 +0100
@@ -1415,7 +1415,7 @@
 	      case SHMDT:
 		return sys_shmdt(compat_ptr(ptr));
 	      case SHMGET:
-		return sys_shmget(first, second, third);
+		return sys_shmget(first, (unsigned)second, third);
 	      case SHMCTL:
 		return compat_sys_shmctl(first, second, compat_ptr(ptr));
 
diff -u linux-2.6.11rc3/arch/mips/kernel/linux32.c-X linux-2.6.11rc3/arch/mips/kernel/linux32.c
--- linux-2.6.11rc3/arch/mips/kernel/linux32.c-X	2005-02-04 09:12:45.000000000 +0100
+++ linux-2.6.11rc3/arch/mips/kernel/linux32.c	2005-02-09 10:39:03.000000000 +0100
@@ -1115,7 +1115,7 @@
 		err = sys_shmdt ((char *)A(ptr));
 		break;
 	case SHMGET:
-		err = sys_shmget (first, second, third);
+		err = sys_shmget (first, (unsigned)second, third);
 		break;
 	case SHMCTL:
 		err = do_sys32_shmctl (first, second, (void *)AA(ptr));
diff -u linux-2.6.11rc3/arch/x86_64/ia32/ipc32.c-X linux-2.6.11rc3/arch/x86_64/ia32/ipc32.c
--- linux-2.6.11rc3/arch/x86_64/ia32/ipc32.c-X	2004-04-06 13:12:04.000000000 +0200
+++ linux-2.6.11rc3/arch/x86_64/ia32/ipc32.c	2005-02-09 10:39:03.000000000 +0100
@@ -49,7 +49,7 @@
 	      case SHMDT:
 		return sys_shmdt(compat_ptr(ptr));
 	      case SHMGET:
-		return sys_shmget(first, second, third);
+		return sys_shmget(first, (unsigned)second, third);
 	      case SHMCTL:
 		return compat_sys_shmctl(first, second, compat_ptr(ptr));
 	}
diff -u linux-2.6.11rc3/arch/s390/kernel/compat_linux.c-X linux-2.6.11rc3/arch/s390/kernel/compat_linux.c
--- linux-2.6.11rc3/arch/s390/kernel/compat_linux.c-X	2005-02-04 09:12:49.000000000 +0100
+++ linux-2.6.11rc3/arch/s390/kernel/compat_linux.c	2005-02-09 10:39:28.000000000 +0100
@@ -331,7 +331,7 @@
 	case SHMDT:
 		return sys_shmdt(compat_ptr(ptr));
 	case SHMGET:
-		return sys_shmget(first, second, third);
+		return sys_shmget(first, (unsigned)second, third);
 	case SHMCTL:
 		return compat_sys_shmctl(first, second, compat_ptr(ptr));
 	}
