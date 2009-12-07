From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 12/19] Cut hugetlb case early for 32bit on ia64
Date: Mon, 07 Dec 2009 03:53:50 +0000
Message-ID: <E1NHUfW-0007xO-Qg@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934639AbZLGDxy@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


It won't work anyway (hugetlb addresses there are way beyond 4Gb)
and it's easier to stop it here.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/ia32/sys_ia32.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 625ed8f..e031ee8 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -858,6 +858,9 @@ ia32_do_mmap (struct file *file, unsigned long addr, unsigned long len, int prot
 
 	prot = get_prot32(prot);
 
+	if (flags & MAP_HUGETLB)
+		return -ENOMEM;
+
 #if PAGE_SHIFT > IA32_PAGE_SHIFT
 	mutex_lock(&ia32_mmap_mutex);
 	{
-- 
1.5.6.5
