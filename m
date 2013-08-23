From: Christoph Lameter <cl@linux.com>
Subject: [guv 16/16] Remove __get_cpu_var and __raw_get_cpu_var macros
Date: Fri, 23 Aug 2013 19:02:17 +0000
Message-ID: <00000140ac8e32ea-b2fbe5aa-471f-49f4-b230-3b4e744c57e6-000000@email.amazonses.com>
References: <20130823190135.726207430@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

No user is left in the kernel source tree. Therefore we can
drop the definitions.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/include/asm-generic/percpu.h
===================================================================
--- linux.orig/include/asm-generic/percpu.h	2013-08-23 09:34:00.883602082 -0500
+++ linux/include/asm-generic/percpu.h	2013-08-23 09:34:00.879602121 -0500
@@ -65,9 +65,6 @@ extern unsigned long __per_cpu_offset[NR
 #define this_cpu_ptr(ptr) __this_cpu_ptr(ptr)
 #endif
 
-#define __get_cpu_var(var) (*this_cpu_ptr(&(var)))
-#define __raw_get_cpu_var(var) (*__this_cpu_ptr(&(var)))
-
 #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
 extern void setup_per_cpu_areas(void);
 #endif
@@ -80,8 +77,6 @@ extern void setup_per_cpu_areas(void);
 })
 
 #define per_cpu(var, cpu)	(*((void)(cpu), VERIFY_PERCPU_PTR(&(var))))
-#define __get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
-#define __raw_get_cpu_var(var)	(*VERIFY_PERCPU_PTR(&(var)))
 #define this_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
 #define __this_cpu_ptr(ptr)	this_cpu_ptr(ptr)
 
