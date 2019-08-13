Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfHMVCp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:45 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 09/27] mm/mmap: Prevent Shadow Stack VMA merges
Date: Tue, 13 Aug 2019 13:52:07 -0700
Message-ID: <20190813205225.12032-10-yu-cheng.yu@intel.com>
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20190813205207.Whp_-8QEKViLYQn_znrVoR5cM7LuHmhdW4hcjpQXV3E@z>

To prevent function call/return spills into the next shadow stack
area, do not merge shadow stack areas.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..b1a921c0de63 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1149,6 +1149,12 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	/*
+	 * Do not merge shadow stack areas.
+	 */
+	if (vm_flags & VM_SHSTK)
+		return NULL;
+
 	if (prev)
 		next = prev->vm_next;
 	else
-- 
2.17.1
