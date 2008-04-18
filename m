From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
Date: Fri, 18 Apr 2008 16:56:18 +1000
Message-ID: <20080418065728.31AF4DE255@ozlabs.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Use the __weak macro instead of the longer __attribute__ ((weak)) form

Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
--

 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/init/main.c	2008-04-18 16:44:32.000000000 +1000
+++ linux-work/init/main.c	2008-04-18 16:44:37.000000000 +1000
@@ -500,7 +500,7 @@ static void __init boot_cpu_init(void)
 	cpu_set(cpu, cpu_possible_map);
 }
 
-void __init __attribute__((weak)) smp_setup_processor_id(void)
+void __init __weak smp_setup_processor_id(void)
 {
 }
 
