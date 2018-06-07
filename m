From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 09/10] mm: Prevent madvise from changing shadow stack
Date: Thu,  7 Jun 2018 07:38:06 -0700
Message-ID: <20180607143807.3611-10-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922ea1a1..2a6988badd6b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -839,6 +839,14 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
+	/*
+	 * Don't do anything on shadow stack.
+	 */
+	if (vma->vm_flags & VM_SHSTK) {
+		error = -EINVAL;
+		goto out_no_plug;
+	}
+
 	blk_start_plug(&plug);
 	for (;;) {
 		/* Still start < end. */
@@ -876,6 +884,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	}
 out:
 	blk_finish_plug(&plug);
+out_no_plug:
 	if (write)
 		up_write(&current->mm->mmap_sem);
 	else
-- 
2.15.1
