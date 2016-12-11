From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 1/3] mm: move argument checkers of mmap_pgoff() to separated routine
Date: Sun, 11 Dec 2016 18:26:40 +0530
Message-ID: <1481461003-14361-2-git-send-email-ynorov@caviumnetworks.com>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:57792
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753152AbcLKM5w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Dec 2016 07:57:52 -0500
In-Reply-To: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kerne

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 mm/mmap.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1af87c1..fc1c943 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1455,12 +1455,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	return addr;
 }
 
-SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
-		unsigned long, prot, unsigned long, flags,
-		unsigned long, fd, unsigned long, pgoff)
+static int mmap_pgoff_prepare(struct file **f, unsigned long *l,
+		unsigned long *fl, unsigned long fd)
 {
-	struct file *file = NULL;
-	unsigned long retval;
+	struct file *file = *f;
+	unsigned long flags = *fl;
+	unsigned long len = *l;
 
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
@@ -1469,9 +1469,10 @@ SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
 			return -EBADF;
 		if (is_file_hugepages(file))
 			len = ALIGN(len, huge_page_size(hstate_file(file)));
-		retval = -EINVAL;
-		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
-			goto out_fput;
+		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file))) {
+			fput(file);
+			return -EINVAL;
+		}
 	} else if (flags & MAP_HUGETLB) {
 		struct user_struct *user = NULL;
 		struct hstate *hs;
@@ -1497,8 +1498,23 @@ SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
+	*f = file;
+	*l = len;
+	*fl = flags;
+	return 0;
+}
+
+SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, pgoff)
+{
+	struct file *file = NULL;
+	unsigned long retval;
+	int err = mmap_pgoff_prepare(&file, &len, &flags, fd);
+	if (err)
+		return err;
+
 	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-out_fput:
 	if (file)
 		fput(file);
 	return retval;
-- 
2.7.4
