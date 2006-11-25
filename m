Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:58313 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S935175AbWKYN2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 Nov 2006 08:28:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Generic compat_sys_sysinfo
Date: Sat, 25 Nov 2006 14:28:27 +0100
References: <20061125014313.GD11643@athena.road.mcmartin.ca>
In-Reply-To: <20061125014313.GD11643@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611251428.28018.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, parisc-linux@lists.parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Saturday 25 November 2006 02:43, Kyle McMartin wrote:
> +asmlinkage long
> +compat_sys_sysinfo(struct compat_sysinfo __user *info)
> +{
> +       struct sysinfo s;
> +       int ret;
> +       mm_segment_t old_fs = get_fs ();
> +       int bitcount = 0;
> +
> +       set_fs (KERNEL_DS);
> +       ret = sys_sysinfo((struct sysinfo __user *)&s);
> +       set_fs (old_fs);

Maybe we should avoid the ugly get_fs/set_fs hack at the same time
and do it more like the (untested) code below. I also noticed that
all implementations of compat_sys_sysinfo do not set the reserved
fields to zero in user space, so maybe it should also be converted
to use copy_to_user().

	Arnd <><

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 24b6111..634959a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -322,6 +322,9 @@ static inline int __attribute__ ((format
 	(void)__tmp; \
 })
 
+struct sysinfo;
+extern void do_sysinfo(struct sysinfo *);
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
diff --git a/kernel/compat.c b/kernel/compat.c
index 6952dd0..cd6e0ee 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -1016,3 +1016,66 @@ asmlinkage long compat_sys_migrate_pages
 	return sys_migrate_pages(pid, nr_bits + 1, old, new);
 }
 #endif
+
+struct compat_sysinfo {
+	s32 uptime;
+	u32 loads[3];
+	u32 totalram;
+	u32 freeram;
+	u32 sharedram;
+	u32 bufferram;
+	u32 totalswap;
+	u32 freeswap;
+	u16 procs;
+	u16 pad;
+	u32 totalhigh;
+	u32 freehigh;
+	u32 mem_unit;
+	char _f[20 - 2 * sizeof(u32) - sizeof(int)];
+};
+
+asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info)
+{
+	struct sysinfo s;
+	int bitcount = 0;
+
+	do_sysinfo(&s);
+
+	/*
+	 * Check to see if any memory value is too large for 32-bit and
+	 * scale down if needed.
+	 */
+	if ((s.totalram >> 32) || (s.totalswap >> 32)) {
+		while (s.mem_unit < PAGE_SIZE) {
+			s.mem_unit <<= 1;
+			bitcount++;
+		}
+		s.totalram >>= bitcount;
+		s.freeram >>= bitcount;
+		s.sharedram >>= bitcount;
+		s.bufferram >>= bitcount;
+		s.totalswap >>= bitcount;
+		s.freeswap >>= bitcount;
+		s.totalhigh >>= bitcount;
+		s.freehigh >>= bitcount;
+	}
+
+	if (!access_ok(VERIFY_WRITE, info, sizeof(struct compat_sysinfo))
+	    || __put_user(s.uptime, &info->uptime)
+	    || __put_user(s.loads[0], &info->loads[0])
+	    || __put_user(s.loads[1], &info->loads[1])
+	    || __put_user(s.loads[2], &info->loads[2])
+	    || __put_user(s.totalram, &info->totalram)
+	    || __put_user(s.freeram, &info->freeram)
+	    || __put_user(s.sharedram, &info->sharedram)
+	    || __put_user(s.bufferram, &info->bufferram)
+	    || __put_user(s.totalswap, &info->totalswap)
+	    || __put_user(s.freeswap, &info->freeswap)
+	    || __put_user(s.procs, &info->procs)
+	    || __put_user(s.totalhigh, &info->totalhigh)
+	    || __put_user(s.freehigh, &info->freehigh)
+	    || __put_user(s.mem_unit, &info->mem_unit))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/kernel/timer.c b/kernel/timer.c
index c1c7fbc..878568b 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1251,17 +1251,16 @@ asmlinkage long sys_gettid(void)
 }
 
 /**
- * sys_sysinfo - fill in sysinfo struct
+ * do_sysinfo - fill in sysinfo struct
  * @info: pointer to buffer to fill
- */ 
-asmlinkage long sys_sysinfo(struct sysinfo __user *info)
+ */
+void do_sysinfo(struct sysinfo *val)
 {
-	struct sysinfo val;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 	unsigned long seq;
 
-	memset((char *)&val, 0, sizeof(struct sysinfo));
+	memset(val, 0, sizeof(struct sysinfo));
 
 	do {
 		struct timespec tp;
@@ -1281,17 +1280,17 @@ asmlinkage long sys_sysinfo(struct sysin
 			tp.tv_nsec = tp.tv_nsec - NSEC_PER_SEC;
 			tp.tv_sec++;
 		}
-		val.uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
+		val->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
-		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+		val->loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
+		val->loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
+		val->loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
 
-		val.procs = nr_threads;
+		val->procs = nr_threads;
 	} while (read_seqretry(&xtime_lock, seq));
 
-	si_meminfo(&val);
-	si_swapinfo(&val);
+	si_meminfo(val);
+	si_swapinfo(val);
 
 	/*
 	 * If the sum of all the available memory (i.e. ram + swap)
@@ -1302,41 +1301,46 @@ asmlinkage long sys_sysinfo(struct sysin
 	 *  -Erik Andersen <andersee@debian.org>
 	 */
 
-	mem_total = val.totalram + val.totalswap;
-	if (mem_total < val.totalram || mem_total < val.totalswap)
-		goto out;
+	mem_total = val->totalram + val->totalswap;
+	if (mem_total < val->totalram || mem_total < val->totalswap)
+		return;
 	bitcount = 0;
-	mem_unit = val.mem_unit;
+	mem_unit = val->mem_unit;
 	while (mem_unit > 1) {
 		bitcount++;
 		mem_unit >>= 1;
 		sav_total = mem_total;
 		mem_total <<= 1;
 		if (mem_total < sav_total)
-			goto out;
+			return;
 	}
 
 	/*
 	 * If mem_total did not overflow, multiply all memory values by
-	 * val.mem_unit and set it to 1.  This leaves things compatible
+	 * val->mem_unit and set it to 1.  This leaves things compatible
 	 * with 2.2.x, and also retains compatibility with earlier 2.4.x
 	 * kernels...
 	 */
 
-	val.mem_unit = 1;
-	val.totalram <<= bitcount;
-	val.freeram <<= bitcount;
-	val.sharedram <<= bitcount;
-	val.bufferram <<= bitcount;
-	val.totalswap <<= bitcount;
-	val.freeswap <<= bitcount;
-	val.totalhigh <<= bitcount;
-	val.freehigh <<= bitcount;
+	val->mem_unit = 1;
+	val->totalram <<= bitcount;
+	val->freeram <<= bitcount;
+	val->sharedram <<= bitcount;
+	val->bufferram <<= bitcount;
+	val->totalswap <<= bitcount;
+	val->freeswap <<= bitcount;
+	val->totalhigh <<= bitcount;
+	val->freehigh <<= bitcount;
+}
+
+asmlinkage long sys_sysinfo(struct sysinfo __user *info)
+{
+	struct sysinfo val;
+
+	do_sysinfo(&val);
 
- out:
 	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
 		return -EFAULT;
-
 	return 0;
 }
 
