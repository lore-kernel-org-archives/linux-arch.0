Return-Path: <linux-arch-owner@vger.kernel.org>
Message-Id: <200512100031.jBA0VqRP021369@shell0.pdx.osdl.net>
Subject: [patch 1/1] Don't attempt to power off if power off is not implemented.
From: akpm@osdl.org
Date: Fri,  9 Dec 2005 16:33:21 -0800
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org, ebiederm@xmission.com
List-ID: <linux-arch.vger.kernel.org>


From: Eric W. Biederman <ebiederm@xmission.com>

The problem.  It is expected that /sbin/halt -p works exactly like
/sbin/halt, when the kernel does not implement power off functionality.

The kernel can do a lot of work in the reboot notifiers and in
device_shutdown before we even get to machine_power_off.  Some of that
shutdown is not safe if you are leaving the power on, and it definitely
gets in the way of using sysrq or pressing ctrl-alt-del.  Since the
shutdown happens in generic code there is no way to fix this in
architecture specific code :(

Some machines are kernel oopsing today because of this.

The simple solution is to turn LINUX_REBOOT_CMD_POWER_OFF into
LINUX_REBOOT_CMD_HALT if power_off functionality is not implemented.

This has the unfortunate side effect of disabling the power off
functionality on architectures that leave pm_power_off to null and still
implement something in machine_power_off.  And it will break the build on
some architectures that don't have a pm_power_off variable at all.

On both counts I say tough.

For architectures like alpha that don't implement the pm_power_off variable
pm_power_off is declared in linux/pm.h and it is a generic part of our
power management code, and all architectures should implement it.

For architectures like parisc that have a default power off method in
machine_power_off if pm_power_off is not implemented or fails.  It is easy
enough to set the pm_power_off variable.  And nothing bad happens there,
the machines just stop powering off.

The current semantics are impossible without a flag at the top level so we
can avoid the problem code if a power off is not implemented.  pm_power_off
is as good a flag as any with the bonus that it works without modification
on at least x86, x86_64, powerpc, and ppc today.

Andrew can you pick this up and put this in the mm tree.  Kernels that
don't compile or don't power off seem saner than kernels that oops or
panic.  Until we get the arch specific patches for the problem
architectures this probably isn't smart to push into the stable kernel. 
Unfortunately I don't have the time at the moment to walk through every
architecture and make them work.  And even if I did I couldn't test it :(

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/sys.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN kernel/sys.c~dont-attempt-to-power-off-if-power-off-is-not-implemented kernel/sys.c
--- 25/kernel/sys.c~dont-attempt-to-power-off-if-power-off-is-not-implemented	Fri Dec  9 16:32:58 2005
+++ 25-akpm/kernel/sys.c	Fri Dec  9 16:32:58 2005
@@ -488,6 +488,12 @@ asmlinkage long sys_reboot(int magic1, i
 	                magic2 != LINUX_REBOOT_MAGIC2C))
 		return -EINVAL;
 
+	/* Instead of trying to make the power_off code look like
+	 * halt when pm_power_off is not set do it the easy way.
+	 */
+	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
+		cmd = LINUX_REBOOT_CMD_HALT;
+
 	lock_kernel();
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
_
