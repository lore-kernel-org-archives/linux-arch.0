From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 05/40] Revert some of "binfmt_elf: cleanups"
Date: Wed, 31 Oct 2012 16:13:46 +0000
Message-ID: <1351700061-7203-6-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49573 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935780Ab2JaQOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:14:50 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Mikael Pettersson <mikpe@it.uu.se>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org

The commit "binfmt_elf: cleanups"
(f670d0ecda73b7438eec9ed108680bc5f5362ad8) removed an ifndef elf_map but
this breaks compilation on metag architecture which does define elf_map.

This adds the ifndef back in as it was before, but does not affect the
other cleanups made by that patch.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/binfmt_elf.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 1b52956..14d1fbd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -314,6 +314,8 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	return 0;
 }
 
+#ifndef elf_map
+
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -348,6 +350,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+#endif /* !elf_map */
+
 static unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
 {
 	int i, first_idx = -1, last_idx = -1;
-- 
1.7.7.6
