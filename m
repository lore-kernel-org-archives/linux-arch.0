From: akpm@linux-foundation.org
Subject: [patch 133/160] elf coredump: make offset calculation process and writing process explicit
Date: Fri, 05 Mar 2010 13:44:09 -0800
Message-ID: <201003052144.o25Li9CW029979@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38684 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752462Ab0CEVo6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2010 16:44:58 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, d.hatayama@jp.fujitsu.com, alan@lxorguk.ukuu.org.uk, andi@firstfloor.org, dhowells@redhat.com, gerg@snapgear.com, jdike@addtoit.com, linux-arch@vger.kernel.org, mingo@elte.hu, oleg@redhat.com, roland@redhat.com, tony.luck@intel.com, viro@zeniv.linux.org.uk

From: Daisuke HATAYAMA <d.hatayama@jp.fujitsu.com>

By the next patch, elf_core_dump() and elf_fdpic_core_dump() will support
extended numbering and so will produce the corefiles with section header
table in a special case.

The problem is the process of writing a file header offset of the section
header table into e_shoff field of the ELF header.  ELF header is
positioned at the beginning of the corefile, while section header at the
end.  So, we need to take which of the following ways:

 1. Seek backward to retry writing operation for ELF header
    after writing process for a whole part

 2. Make offset calculation process and writing process
    totally sequential

The clause 1.  is not always possible: one cannot assume that file system
supports seek function.  Consider the no_llseek case.

Therefore, this patch adopts the clause 2.

Signed-off-by: Daisuke HATAYAMA <d.hatayama@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Greg Ungerer <gerg@snapgear.com>
Cc: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/binfmt_elf.c       |   27 ++++++++++++++++-----------
 fs/binfmt_elf_fdpic.c |   29 ++++++++++++++++-------------
 2 files changed, 32 insertions(+), 24 deletions(-)

diff -puN fs/binfmt_elf.c~elf-coredump-make-offset-calculation-process-and-writing-process-explicit fs/binfmt_elf.c
--- a/fs/binfmt_elf.c~elf-coredump-make-offset-calculation-process-and-writing-process-explicit
+++ a/fs/binfmt_elf.c
@@ -1856,6 +1856,7 @@ static int elf_core_dump(struct coredump
 	loff_t offset = 0, dataoff, foffset;
 	unsigned long mm_flags;
 	struct elf_note_info info;
+	struct elf_phdr *phdr4note = NULL;
 
 	/*
 	 * We no longer stop all VM operations.
@@ -1898,28 +1899,22 @@ static int elf_core_dump(struct coredump
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	size += sizeof(*elf);
-	if (size > cprm->limit || !dump_write(cprm->file, elf, sizeof(*elf)))
-		goto end_coredump;
-
 	offset += sizeof(*elf);				/* Elf header */
 	offset += (segs + 1) * sizeof(struct elf_phdr); /* Program headers */
 	foffset = offset;
 
 	/* Write notes phdr entry */
 	{
-		struct elf_phdr phdr;
 		size_t sz = get_note_info_size(&info);
 
 		sz += elf_coredump_extra_notes_size();
 
-		fill_elf_note_phdr(&phdr, sz, offset);
-		offset += sz;
-
-		size += sizeof(phdr);
-		if (size > cprm->limit
-		    || !dump_write(cprm->file, &phdr, sizeof(phdr)))
+		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
+		if (!phdr4note)
 			goto end_coredump;
+
+		fill_elf_note_phdr(phdr4note, sz, offset);
+		offset += sz;
 	}
 
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
@@ -1931,6 +1926,15 @@ static int elf_core_dump(struct coredump
 	 */
 	mm_flags = current->mm->flags;
 
+	size += sizeof(*elf);
+	if (size > cprm->limit || !dump_write(cprm->file, elf, sizeof(*elf)))
+		goto end_coredump;
+
+	size += sizeof(*phdr4note);
+	if (size > cprm->limit
+	    || !dump_write(cprm->file, phdr4note, sizeof(*phdr4note)))
+		goto end_coredump;
+
 	/* Write program headers for segments dump */
 	for (vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma)) {
@@ -2004,6 +2008,7 @@ end_coredump:
 
 cleanup:
 	free_note_info(&info);
+	kfree(phdr4note);
 	kfree(elf);
 out:
 	return has_dumped;
diff -puN fs/binfmt_elf_fdpic.c~elf-coredump-make-offset-calculation-process-and-writing-process-explicit fs/binfmt_elf_fdpic.c
--- a/fs/binfmt_elf_fdpic.c~elf-coredump-make-offset-calculation-process-and-writing-process-explicit
+++ a/fs/binfmt_elf_fdpic.c
@@ -1600,6 +1600,7 @@ static int elf_fdpic_core_dump(struct co
 	int thread_status_size = 0;
 	elf_addr_t *auxv;
 	unsigned long mm_flags;
+	struct elf_phdr *phdr4note = NULL;
 
 	/*
 	 * We no longer stop all VM operations.
@@ -1706,18 +1707,12 @@ static int elf_fdpic_core_dump(struct co
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	size += sizeof(*elf);
-	if (size > cprm->limit
-	    || !dump_write(cprm->file, elf, sizeof(*elf)))
-		goto end_coredump;
-
 	offset += sizeof(*elf);				/* Elf header */
 	offset += (segs+1) * sizeof(struct elf_phdr);	/* Program headers */
 	foffset = offset;
 
 	/* Write notes phdr entry */
 	{
-		struct elf_phdr phdr;
 		int sz = 0;
 
 		for (i = 0; i < numnote; i++)
@@ -1725,13 +1720,12 @@ static int elf_fdpic_core_dump(struct co
 
 		sz += thread_status_size;
 
-		fill_elf_note_phdr(&phdr, sz, offset);
-		offset += sz;
-
-		size += sizeof(phdr);
-		if (size > cprm->limit
-		    || !dump_write(cprm->file, &phdr, sizeof(phdr)))
+		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
+		if (!phdr4note)
 			goto end_coredump;
+
+		fill_elf_note_phdr(phdr4note, sz, offset);
+		offset += sz;
 	}
 
 	/* Page-align dumped data */
@@ -1744,6 +1738,15 @@ static int elf_fdpic_core_dump(struct co
 	 */
 	mm_flags = current->mm->flags;
 
+	size += sizeof(*elf);
+	if (size > cprm->limit || !dump_write(cprm->file, elf, sizeof(*elf)))
+		goto end_coredump;
+
+	size += sizeof(*phdr4note);
+	if (size > cprm->limit
+	    || !dump_write(cprm->file, phdr4note, sizeof(*phdr4note)))
+		goto end_coredump;
+
 	/* write program headers for segments dump */
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
 		struct elf_phdr phdr;
@@ -1815,7 +1818,7 @@ cleanup:
 		list_del(tmp);
 		kfree(list_entry(tmp, struct elf_thread_status, list));
 	}
-
+	kfree(phdr4note);
 	kfree(elf);
 	kfree(prstatus);
 	kfree(psinfo);
_
