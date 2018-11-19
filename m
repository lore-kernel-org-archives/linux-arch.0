Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32114 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbeKTIUj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Nov 2018 03:20:39 -0500
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v6 05/11] x86/cet/ibt: ELF header parsing for IBT
Date: Mon, 19 Nov 2018 13:49:28 -0800
Message-ID: <20181119214934.6174-6-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214934.6174-1-yu-cheng.yu@intel.com>
References: <20181119214934.6174-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20181119214928.2LFipk8pdbg4D7mrkwj9hzeg0K8PZIeKz2lokYX73Kw@z>

Look in .note.gnu.property of an ELF file and check if Indirect
Branch Tracking needs to be enabled for the task.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/uapi/asm/elf_property.h | 1 +
 arch/x86/kernel/elf.c                    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/uapi/asm/elf_property.h b/arch/x86/include/uapi/asm/elf_property.h
index af361207718c..343a871b8fc1 100644
--- a/arch/x86/include/uapi/asm/elf_property.h
+++ b/arch/x86/include/uapi/asm/elf_property.h
@@ -11,5 +11,6 @@
  * Bits for GNU_PROPERTY_X86_FEATURE_1_AND
  */
 #define GNU_PROPERTY_X86_FEATURE_1_SHSTK	(0x00000002)
+#define GNU_PROPERTY_X86_FEATURE_1_IBT		(0x00000001)
 
 #endif /* _UAPI_ASM_X86_ELF_PROPERTY_H */
diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
index 60e396e2abe9..7727b9332097 100644
--- a/arch/x86/kernel/elf.c
+++ b/arch/x86/kernel/elf.c
@@ -353,6 +353,11 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
 		}
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
+		if (feature & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			err = cet_setup_ibt();
+	}
+
 out:
 	return err;
 }
-- 
2.17.1
