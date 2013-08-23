From: Frantisek Hrbata <fhrbata@redhat.com>
Subject: [RFC PATCH 4/4] kernel: add support for init_array constructors
Date: Fri, 23 Aug 2013 10:39:36 +0200
Message-ID: <1377247176-13537-5-git-send-email-fhrbata@redhat.com>
References: <1377247176-13537-1-git-send-email-fhrbata@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377247176-13537-1-git-send-email-fhrbata@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com
List-Id: linux-arch.vger.kernel.org

This adds the .init_array section as yet another section with constructors. This
is needed because gcc is adding __gcov_init calls to .init_array.

Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/module.h            | 2 ++
 kernel/module.c                   | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 69732d2..c55d8d9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -468,6 +468,7 @@
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			VMLINUX_SYMBOL(__ctors_start) = .; \
 			*(.ctors)			   \
+			*(.init_array)			   \
 			VMLINUX_SYMBOL(__ctors_end) = .;
 #else
 #define KERNEL_CTORS()
diff --git a/include/linux/module.h b/include/linux/module.h
index 46f1ea0..89ff829 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -374,6 +374,8 @@ struct module
 	/* Constructor functions. */
 	ctor_fn_t *ctors;
 	unsigned int num_ctors;
+	ctor_fn_t *init_array;
+	unsigned int num_init_array;
 #endif
 };
 #ifndef MODULE_ARCH_INIT
diff --git a/kernel/module.c b/kernel/module.c
index 2069158..581ae89 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2760,6 +2760,9 @@ static void find_module_sections(struct module *mod, struct load_info *info)
 #ifdef CONFIG_CONSTRUCTORS
 	mod->ctors = section_objs(info, ".ctors",
 				  sizeof(*mod->ctors), &mod->num_ctors);
+	mod->init_array = section_objs(info, ".init_array",
+				  sizeof(*mod->init_array),
+				  &mod->num_init_array);
 #endif
 
 #ifdef CONFIG_TRACEPOINTS
@@ -3024,6 +3027,9 @@ static void do_mod_ctors(struct module *mod)
 
 	for (i = 0; i < mod->num_ctors; i++)
 		mod->ctors[i]();
+
+	for (i = 0; i < mod->num_init_array; i++)
+		mod->init_array[i]();
 #endif
 }
 
-- 
1.8.3.1
