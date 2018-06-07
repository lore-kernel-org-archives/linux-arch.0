From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 10/10] mm: Prevent munmap and remap_file_pages of shadow stack
Date: Thu,  7 Jun 2018 07:38:07 -0700
Message-ID: <20180607143807.3611-11-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/mmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index fc41c0543d7f..e7d1fcb7ec58 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2810,6 +2810,16 @@ EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
+	struct vm_area_struct *vma;
+
+	/* Do not munmap shadow stack */
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma(current->mm, addr);
+	if (vma && (vma->vm_flags & VM_SHSTK)) {
+		up_read(&current->mm->mmap_sem);
+		return -EINVAL;
+	}
+	up_read(&current->mm->mmap_sem);
 	profile_munmap(addr);
 	return vm_munmap(addr, len);
 }
@@ -2851,6 +2861,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
 
+	if (vma->vm_flags & VM_SHSTK)
+		goto out;
+
 	if (start < vma->vm_start)
 		goto out;
 
-- 
2.15.1
