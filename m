From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Fri, 19 Feb 2016 05:45:55 -0800
Message-ID: <1455889559-9428-4-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-arch.vger.kernel.org

This ports built-in firmware to use linker tables,
this replaces the custom section solution with a
generic solution.

This also demos the use of the .rodata (SECTION_RO)
linker tables.

Tested with 0 built-in firmware, 1 and 2 built-in
firmwares successfully.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/kernel/cpu/microcode/core.c |  7 +++----
 drivers/base/firmware_class.c        | 11 +++++------
 firmware/Makefile                    |  2 +-
 include/asm-generic/vmlinux.lds.h    |  7 -------
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index faec7120c508..7ee73cd64c95 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -99,15 +99,14 @@ static bool __init check_loader_disabled_bsp(void)
 	return *res;
 }
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
+DECLARE_LINKTABLE_RO(struct builtin_fw, builtin_fw);
 
 bool get_builtin_firmware(struct cpio_data *cd, const char *name)
 {
 #ifdef CONFIG_FW_LOADER
-	struct builtin_fw *b_fw;
+	const struct builtin_fw *b_fw;
 
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
+	LINKTABLE_FOR_EACH(b_fw, builtin_fw) {
 		if (!strcmp(name, b_fw->name)) {
 			cd->size = b_fw->size;
 			cd->data = b_fw->data;
diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index b9250e564ebf..50b9cf3d0294 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -42,14 +42,13 @@ MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_FW_LOADER
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
+DEFINE_LINKTABLE_RO(struct builtin_fw, builtin_fw);
 
 static bool fw_get_builtin_firmware(struct firmware *fw, const char *name)
 {
-	struct builtin_fw *b_fw;
+	const struct builtin_fw *b_fw;
 
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
+	LINKTABLE_FOR_EACH(b_fw, builtin_fw) {
 		if (strcmp(name, b_fw->name) == 0) {
 			fw->size = b_fw->size;
 			fw->data = b_fw->data;
@@ -62,9 +61,9 @@ static bool fw_get_builtin_firmware(struct firmware *fw, const char *name)
 
 static bool fw_is_builtin_firmware(const struct firmware *fw)
 {
-	struct builtin_fw *b_fw;
+	const struct builtin_fw *b_fw;
 
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++)
+	LINKTABLE_FOR_EACH(b_fw, builtin_fw)
 		if (fw->data == b_fw->data)
 			return true;
 
diff --git a/firmware/Makefile b/firmware/Makefile
index e297e1b52636..e13549362577 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -164,7 +164,7 @@ quiet_cmd_fwbin = MK_FW   $@
 		  echo "    .p2align $${ASM_ALIGN}"			>>$@;\
 		  echo "_fw_$${FWSTR}_name:"				>>$@;\
 		  echo "    .string \"$$FWNAME\""			>>$@;\
-		  echo "    .section .builtin_fw,\"a\",$${PROGBITS}"	>>$@;\
+		  echo "    .section .rodata.tbl.builtin_fw.all,\"a\",$${PROGBITS}"	>>$@;\
 		  echo "    .p2align $${ASM_ALIGN}"			>>$@;\
 		  echo "    $${ASM_WORD} _fw_$${FWSTR}_name"		>>$@;\
 		  echo "    $${ASM_WORD} _fw_$${FWSTR}_bin"		>>$@;\
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eb23738ef4bd..91815fb1f2fa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -302,13 +302,6 @@
 		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
 	}								\
 									\
-	/* Built-in firmware blobs */					\
-	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
-		*(.builtin_fw)						\
-		VMLINUX_SYMBOL(__end_builtin_fw) = .;			\
-	}								\
-									\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-- 
2.7.0
