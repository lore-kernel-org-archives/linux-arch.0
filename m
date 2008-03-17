From: =?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar-caicS1wCkhO6A22drWdTBw@public.gmane.org>
Subject: [PATCH] fs/binfmt_aout.c: Use printk_ratelimit()
Date: Mon, 17 Mar 2008 11:36:32 +0200
Message-ID: <1205746593-24820-10-git-send-email-caglar@pardus.org.tr>
References: <>
 <1205746593-24820-1-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-2-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-3-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-4-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-5-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-6-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-7-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-8-git-send-email-caglar@pardus.org.tr>
 <1205746593-24820-9-git-send-email-caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1205746593-24820-9-git-send-email-caglar-caicS1wCkhO6A22drWdTBw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Use printk_ratelimit() instead of jiffies based arithmetic, suggested b=
y Geert Uytterhoeven

Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: S.=C3=87a=C4=9Flar Onur <caglar-caicS1wCkhO6A22drWdTBw@public.gmane.org>
---
 fs/binfmt_aout.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index a1bb224..ba4cddb 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -372,21 +372,17 @@ static int load_aout_binary(struct linux_binprm *=
 bprm, struct pt_regs * regs)
 			=20
 		flush_icache_range(text_addr, text_addr+ex.a_text+ex.a_data);
 	} else {
-		static unsigned long error_time, error_time2;
 		if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
-		    (N_MAGIC(ex) !=3D NMAGIC) && (jiffies-error_time2) > 5*HZ)
+		    (N_MAGIC(ex) !=3D NMAGIC) && printk_ratelimit())
 		{
 			printk(KERN_NOTICE "executable not page aligned\n");
-			error_time2 =3D jiffies;
 		}
=20
-		if ((fd_offset & ~PAGE_MASK) !=3D 0 &&
-		    (jiffies-error_time) > 5*HZ)
+		if ((fd_offset & ~PAGE_MASK) !=3D 0 && printk_ratelimit())
 		{
 			printk(KERN_WARNING=20
 			       "fd_offset is not page aligned. Please convert program: %s\n=
",
 			       bprm->file->f_path.dentry->d_name.name);
-			error_time =3D jiffies;
 		}
=20
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) !=3D 0)) {
@@ -495,15 +491,13 @@ static int load_aout_library(struct file *file)
 	start_addr =3D  ex.a_entry & 0xfffff000;
=20
 	if ((N_TXTOFF(ex) & ~PAGE_MASK) !=3D 0) {
-		static unsigned long error_time;
 		loff_t pos =3D N_TXTOFF(ex);
=20
-		if ((jiffies-error_time) > 5*HZ)
+		if (printk_ratelimit())
 		{
 			printk(KERN_WARNING=20
 			       "N_TXTOFF is not page aligned. Please convert library: %s\n"=
,
 			       file->f_path.dentry->d_name.name);
-			error_time =3D jiffies;
 		}
 		down_write(&current->mm->mmap_sem);
 		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
--=20
1.5.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
