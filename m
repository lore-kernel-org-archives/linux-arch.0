From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 08/10] mm: Prevent mremap of shadow stack
Date: Thu,  7 Jun 2018 07:38:05 -0700
Message-ID: <20180607143807.3611-9-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/mremap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 049470aa1e3e..70f20edb248e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -525,7 +525,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		unsigned long, new_addr)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = find_vma(mm, addr);
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
 	bool locked = false;
@@ -533,6 +533,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	if (vma->vm_flags & VM_SHSTK)
+		return ret;
+
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
 
-- 
2.15.1
