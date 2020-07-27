From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC PATCH 4/5] exec, elf: require opt-in for accepting preserved mem
Date: Mon, 27 Jul 2020 10:11:26 -0700
Message-ID: <1595869887-23307-5-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:50754 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbgG0RDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 13:03:22 -0400
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com

Don't copy preserved VMAs to the binary being exec'd unless the binary has
a "preserved-mem-ok" ELF note.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/binfmt_elf.c         | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/exec.c               | 17 +++++-----
 include/linux/binfmts.h |  7 ++++-
 3 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6445a6dbdb1d..46248b7b0a75 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -683,6 +683,81 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	return error;
 }
 
+#define NOTES_SZ			SZ_1K
+#define PRESERVED_MEM_OK_STRING		"preserved-mem-ok"
+#define SZ_PRESERVED_MEM_OK_STRING	sizeof(PRESERVED_MEM_OK_STRING)
+
+static int parse_elf_note(struct linux_binprm *bprm, const char *data, size_t *off, size_t datasz)
+{
+	const struct elf_note *nhdr;
+	const char *name;
+	size_t o;
+
+	o = *off;
+	datasz -= o;
+
+	if (datasz < sizeof(*nhdr))
+		return -ENOEXEC;
+
+	nhdr = (const struct elf_note *)(data + o);
+	o += sizeof(*nhdr);
+	datasz -= sizeof(*nhdr);
+
+	/*
+	 * Currently only the preserved-mem-ok elf note is of interest.
+	 */
+	if (nhdr->n_type != 0x07c1feed)
+		goto next;
+
+	if (nhdr->n_namesz > SZ_PRESERVED_MEM_OK_STRING)
+		return -ENOEXEC;
+
+	name =  data + o;
+	if (datasz < SZ_PRESERVED_MEM_OK_STRING ||
+	    strncmp(name, PRESERVED_MEM_OK_STRING, SZ_PRESERVED_MEM_OK_STRING))
+		return -ENOEXEC;
+
+	bprm->accepts_preserved_mem = 1;
+
+next:
+	o += roundup(nhdr->n_namesz, 4) + roundup(nhdr->n_descsz, 4);
+	*off = o;
+
+	return 0;
+}
+
+static int parse_elf_notes(struct linux_binprm *bprm, struct elf_phdr *phdr)
+{
+	char *notes;
+	size_t notes_sz;
+	size_t off = 0;
+	int ret;
+
+	if (!phdr)
+		return 0;
+
+	notes_sz = phdr->p_filesz;
+	if ((notes_sz > NOTES_SZ) || (notes_sz < sizeof(struct elf_note)))
+		return -ENOEXEC;
+
+	notes = kvmalloc(notes_sz, GFP_KERNEL);
+	if (!notes)
+		return -ENOMEM;
+
+	ret = elf_read(bprm->file, notes, notes_sz, phdr->p_offset);
+	if (ret < 0)
+		goto out;
+
+	while (off < notes_sz) {
+		ret = parse_elf_note(bprm, notes, &off, notes_sz);
+		if (ret)
+			break;
+	}
+out:
+	kvfree(notes);
+	return ret;
+}
+
 /*
  * These are the functions used to load ELF style executables and shared
  * libraries.  There is no binary dependent code anywhere else.
@@ -801,6 +876,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *elf_notes_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -909,6 +985,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 
+		case PT_NOTE:
+			elf_notes_phdata = elf_ppnt;
+			break;
+
 		case PT_LOPROC ... PT_HIPROC:
 			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
 						  bprm->file, false,
@@ -970,6 +1050,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval)
 		goto out_free_dentry;
 
+	retval = parse_elf_notes(bprm, elf_notes_phdata);
+	if (retval)
+		goto out_free_dentry;
+
 	/* Flush all traces of the currently running executable */
 	retval = begin_new_exec(bprm);
 	if (retval)
diff --git a/fs/exec.c b/fs/exec.c
index 1de09c4eef00..b2b046fec1f8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1088,10 +1088,11 @@ static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
  * On success, this function returns with the mutex
  * exec_update_mutex locked.
  */
-static int exec_mmap(struct mm_struct *mm)
+static int exec_mmap(struct linux_binprm *bprm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
+	struct mm_struct *mm = bprm->mm;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
@@ -1118,11 +1119,13 @@ static int exec_mmap(struct mm_struct *mm)
 			mutex_unlock(&tsk->signal->exec_update_mutex);
 			return -EINTR;
 		}
-		ret = vma_dup_some(old_mm, mm);
-		if (ret) {
-			mmap_read_unlock(old_mm);
-			mutex_unlock(&tsk->signal->exec_update_mutex);
-			return ret;
+		if (bprm->accepts_preserved_mem) {
+			ret = vma_dup_some(old_mm, mm);
+			if (ret) {
+				mmap_read_unlock(old_mm);
+				mutex_unlock(&tsk->signal->exec_update_mutex);
+				return ret;
+			}
 		}
 	}
 
@@ -1386,7 +1389,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Release all of the old mmap stuff
 	 */
 	acct_arg_size(bprm, 0);
-	retval = exec_mmap(bprm->mm);
+	retval = exec_mmap(bprm);
 	if (retval)
 		goto out;
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 4a20b7517dd0..6a66589454c8 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -41,7 +41,12 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+		/*
+		 * Set if the binary being exec'd will accept memory marked
+		 * for preservation by the outgoing process.
+		 */
+		accepts_preserved_mem:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
1.8.3.1
