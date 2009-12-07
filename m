Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51487 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934555AbZLGDxp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2009 22:53:45 -0500
Date: Mon, 07 Dec 2009 03:53:50 +0000
Subject: [PATCH 12/19] Cut hugetlb case early for 32bit on ia64
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1NHUfW-0007xO-Qg@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Message-ID: <20091207035350.9w7mGLVvC-3YANk48pg7vR9Xe7pAM7CdLKi58DEzxc0@z>


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


