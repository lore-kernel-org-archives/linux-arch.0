Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:49526 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbXGISYL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2007 14:24:11 -0400
Date: Mon, 9 Jul 2007 11:22:45 -0700 (PDT)
From: Joshua Wise <jwise@google.com>
Subject: Re: - print-utsname-on-oops-on-all-architectures.patch removed from
 -mm tree
In-Reply-To: <200707062207.l66M7hQA023027@imap1.linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0707091121570.617@internets.corp.google.com>
References: <200707062207.l66M7hQA023027@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="313268086-1458176100-1184005365=:617"
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: ak@suse.de, benh@kernel.crashing.org, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org, paulus@samba.org, rmk@arm.linux.org.uk, rth@twiddle.net, mm-commits@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--313268086-1458176100-1184005365=:617
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 6 Jul 2007, akpm@linux-foundation.org wrote:
> The patch titled
>      Print utsname on Oops on all architectures
> has been removed from the -mm tree.  Its filename was
>      print-utsname-on-oops-on-all-architectures.patch
> 
> This patch was dropped because an updated version will be merged

OK, how's this:

--

From: Joshua Wise <jwise@google.com>

Background:
 This patch is a follow-on to "Info dump on Oops or panic()" [1].
 
 On some architectures, the kernel printed some information on the running
 kernel, but not on all architectures. The information printed was generally
 the version and build number, but it was not located in a consistant place,
 and some architectures did not print it at all.

Description:
 This patch uses the already-existing die_chain to print utsname information
 on Oops. This patch also removes the architecture-specific utsname
 printers. To avoid crashing the system further (and hence not printing the
 Oops) in the case where the system is so hopelessly smashed that utsname
 might be destroyed, we vsprintf the utsname data into a static buffer
 first, and then just print that on crash.

Testing:
 I wrote a module that does a *(int*)0 = 0; and observed that I got my
 utsname data printed.

Potential impact:
 This adds another line to the Oops output, causing the first few lines to
 potentially scroll off the screen. This also adds a few more pointer
 dereferences in the Oops path, because it adds to the die_chain notifier
 chain, reducing the likelihood that the Oops will be printed if there is
 very bad memory corruption.

Version: 2

Changelog:
 v2 -- Removed the delete of the printk on ARM, as per RMK's request.

Patch:
 This patch is against git 0471448f4d017470995d8a2272dc8c06dbed3b77.

[1] http://lkml.org/lkml/2007/6/28/316

--

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 92b6162..13f342e 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -20,7 +20,6 @@ #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/utsname.h>
 #include <linux/time.h>
 #include <linux/major.h>
 #include <linux/stat.h>
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index 06dfa65..1703243 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -27,7 +27,6 @@ #include <linux/vmalloc.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
-#include <linux/utsname.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
@@ -308,10 +307,8 @@ void show_regs(struct pt_regs * regs)
 
 	if (user_mode_vm(regs))
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
-	printk(" EFLAGS: %08lx    %s  (%s %.*s)\n",
-	       regs->eflags, print_tainted(), init_utsname()->release,
-	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
+	printk(" EFLAGS: %08lx    %s\n",
+	       regs->eflags, print_tainted());
 	printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6e2f035..04c4abd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -32,7 +32,6 @@ #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
-#include <linux/utsname.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -414,8 +413,8 @@ void show_regs(struct pt_regs * regs)
 
 	printk("NIP: "REG" LR: "REG" CTR: "REG"\n",
 	       regs->nip, regs->link, regs->ctr);
-	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
-	       regs, regs->trap, print_tainted(), init_utsname()->release);
+	printk("REGS: %p TRAP: %04lx   %s\n",
+	       regs, regs->trap, print_tainted());
 	printk("MSR: "REG" ", regs->msr);
 	printbits(regs->msr, msr_bits);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 5909039..94fb7e3 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -32,7 +32,6 @@ #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/ptrace.h>
-#include <linux/utsname.h>
 #include <linux/random.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
@@ -310,11 +309,8 @@ void __show_regs(struct pt_regs * regs)
 
 	printk("\n");
 	print_modules();
-	printk("Pid: %d, comm: %.20s %s %s %.*s\n",
-		current->pid, current->comm, print_tainted(),
-		init_utsname()->release,
-		(int)strcspn(init_utsname()->version, " "),
-		init_utsname()->version);
+	printk("Pid: %d, comm: %.20s %s\n",
+		current->pid, current->comm, print_tainted());
 	printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
 	printk_address(regs->rip); 
 	printk("RSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
diff --git a/kernel/sys.c b/kernel/sys.c
index 872271c..6e01085 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -31,6 +31,7 @@ #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/getcpu.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/kdebug.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -98,6 +99,36 @@ struct pid *cad_pid;
 EXPORT_SYMBOL(cad_pid);
 
 /*
+ * Dump out UTS info on oops / panic.  We pregenerate utsname_info so that
+ * we don't access utsname() if the machine is in a potentially bad state.
+ */
+
+static char *utsname_info;
+
+static int dump_utsname(struct notifier_block *self, unsigned long diecode,
+		void *p)
+{
+	printk(KERN_EMERG "%s\n", utsname_info);
+	return 0;
+}
+
+static struct notifier_block utsname_notifier = {
+	.notifier_call = dump_utsname
+};
+
+static int __init register_utsname_dump(void)
+{
+	utsname_info = kasprintf(GFP_KERNEL, "%s %s %s %s",
+		utsname()->sysname,
+		utsname()->release,
+		utsname()->version,
+		utsname()->machine);
+	register_die_notifier(&utsname_notifier);
+	return 0;
+}
+module_init(register_utsname_dump);
+
+/*
  *	Notifier list for kernel code which wants to be called
  *	at shutdown. This is used to stop any idling DMA operations
  *	and the like. 
--313268086-1458176100-1184005365=:617
Content-Type: TEXT/plain; charset=US-ASCII; name=utsname-on-all-arches-2.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0707091122450.617@internets.corp.google.com>
Content-Description: 
Content-Disposition: attachment; filename=utsname-on-all-arches-2.diff

RnJvbTogSm9zaHVhIFdpc2UgPGp3aXNlQGdvb2dsZS5jb20+DQoNCkJhY2tn
cm91bmQ6DQogVGhpcyBwYXRjaCBpcyBhIGZvbGxvdy1vbiB0byAiSW5mbyBk
dW1wIG9uIE9vcHMgb3IgcGFuaWMoKSIgWzFdLg0KIA0KIE9uIHNvbWUgYXJj
aGl0ZWN0dXJlcywgdGhlIGtlcm5lbCBwcmludGVkIHNvbWUgaW5mb3JtYXRp
b24gb24gdGhlIHJ1bm5pbmcNCiBrZXJuZWwsIGJ1dCBub3Qgb24gYWxsIGFy
Y2hpdGVjdHVyZXMuIFRoZSBpbmZvcm1hdGlvbiBwcmludGVkIHdhcyBnZW5l
cmFsbHkNCiB0aGUgdmVyc2lvbiBhbmQgYnVpbGQgbnVtYmVyLCBidXQgaXQg
d2FzIG5vdCBsb2NhdGVkIGluIGEgY29uc2lzdGFudCBwbGFjZSwNCiBhbmQg
c29tZSBhcmNoaXRlY3R1cmVzIGRpZCBub3QgcHJpbnQgaXQgYXQgYWxsLg0K
DQpEZXNjcmlwdGlvbjoNCiBUaGlzIHBhdGNoIHVzZXMgdGhlIGFscmVhZHkt
ZXhpc3RpbmcgZGllX2NoYWluIHRvIHByaW50IHV0c25hbWUgaW5mb3JtYXRp
b24NCiBvbiBPb3BzLiBUaGlzIHBhdGNoIGFsc28gcmVtb3ZlcyB0aGUgYXJj
aGl0ZWN0dXJlLXNwZWNpZmljIHV0c25hbWUNCiBwcmludGVycy4gVG8gYXZv
aWQgY3Jhc2hpbmcgdGhlIHN5c3RlbSBmdXJ0aGVyIChhbmQgaGVuY2Ugbm90
IHByaW50aW5nIHRoZQ0KIE9vcHMpIGluIHRoZSBjYXNlIHdoZXJlIHRoZSBz
eXN0ZW0gaXMgc28gaG9wZWxlc3NseSBzbWFzaGVkIHRoYXQgdXRzbmFtZQ0K
IG1pZ2h0IGJlIGRlc3Ryb3llZCwgd2UgdnNwcmludGYgdGhlIHV0c25hbWUg
ZGF0YSBpbnRvIGEgc3RhdGljIGJ1ZmZlcg0KIGZpcnN0LCBhbmQgdGhlbiBq
dXN0IHByaW50IHRoYXQgb24gY3Jhc2guDQoNClRlc3Rpbmc6DQogSSB3cm90
ZSBhIG1vZHVsZSB0aGF0IGRvZXMgYSAqKGludCopMCA9IDA7IGFuZCBvYnNl
cnZlZCB0aGF0IEkgZ290IG15DQogdXRzbmFtZSBkYXRhIHByaW50ZWQuDQoN
ClBvdGVudGlhbCBpbXBhY3Q6DQogVGhpcyBhZGRzIGFub3RoZXIgbGluZSB0
byB0aGUgT29wcyBvdXRwdXQsIGNhdXNpbmcgdGhlIGZpcnN0IGZldyBsaW5l
cyB0bw0KIHBvdGVudGlhbGx5IHNjcm9sbCBvZmYgdGhlIHNjcmVlbi4gVGhp
cyBhbHNvIGFkZHMgYSBmZXcgbW9yZSBwb2ludGVyDQogZGVyZWZlcmVuY2Vz
IGluIHRoZSBPb3BzIHBhdGgsIGJlY2F1c2UgaXQgYWRkcyB0byB0aGUgZGll
X2NoYWluIG5vdGlmaWVyDQogY2hhaW4sIHJlZHVjaW5nIHRoZSBsaWtlbGlo
b29kIHRoYXQgdGhlIE9vcHMgd2lsbCBiZSBwcmludGVkIGlmIHRoZXJlIGlz
DQogdmVyeSBiYWQgbWVtb3J5IGNvcnJ1cHRpb24uDQoNClZlcnNpb246IDIN
Cg0KQ2hhbmdlbG9nOg0KIHYyIC0tIFJlbW92ZWQgdGhlIGRlbGV0ZSBvZiB0
aGUgcHJpbnRrIG9uIEFSTSwgYXMgcGVyIFJNSydzIHJlcXVlc3QuDQoNClBh
dGNoOg0KIFRoaXMgcGF0Y2ggaXMgYWdhaW5zdCBnaXQgMDQ3MTQ0OGY0ZDAx
NzQ3MDk5NWQ4YTIyNzJkYzhjMDZkYmVkM2I3Ny4NCg0KWzFdIGh0dHA6Ly9s
a21sLm9yZy9sa21sLzIwMDcvNi8yOC8zMTYNCg0KLS0NCg0KZGlmZiAtLWdp
dCBhL2FyY2gvYWxwaGEva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gvYWxwaGEv
a2VybmVsL3Byb2Nlc3MuYw0KaW5kZXggOTJiNjE2Mi4uMTNmMzQyZSAxMDA2
NDQNCi0tLSBhL2FyY2gvYWxwaGEva2VybmVsL3Byb2Nlc3MuYw0KKysrIGIv
YXJjaC9hbHBoYS9rZXJuZWwvcHJvY2Vzcy5jDQpAQCAtMjAsNyArMjAsNiBA
QCAjaW5jbHVkZSA8bGludXgvcHRyYWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNlci5oPg0KICNpbmNsdWRl
IDxsaW51eC9hLm91dC5oPg0KLSNpbmNsdWRlIDxsaW51eC91dHNuYW1lLmg+
DQogI2luY2x1ZGUgPGxpbnV4L3RpbWUuaD4NCiAjaW5jbHVkZSA8bGludXgv
bWFqb3IuaD4NCiAjaW5jbHVkZSA8bGludXgvc3RhdC5oPg0KZGlmZiAtLWdp
dCBhL2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJjaC9pMzg2L2tl
cm5lbC9wcm9jZXNzLmMNCmluZGV4IDA2ZGZhNjUuLjE3MDMyNDMgMTAwNjQ0
DQotLS0gYS9hcmNoL2kzODYva2VybmVsL3Byb2Nlc3MuYw0KKysrIGIvYXJj
aC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMNCkBAIC0yNyw3ICsyNyw2IEBAICNp
bmNsdWRlIDxsaW51eC92bWFsbG9jLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Vz
ZXIuaD4NCiAjaW5jbHVkZSA8bGludXgvYS5vdXQuaD4NCiAjaW5jbHVkZSA8
bGludXgvaW50ZXJydXB0Lmg+DQotI2luY2x1ZGUgPGxpbnV4L3V0c25hbWUu
aD4NCiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcmVib290Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCkBAIC0z
MDgsMTAgKzMwNyw4IEBAIHZvaWQgc2hvd19yZWdzKHN0cnVjdCBwdF9yZWdz
ICogcmVncykNCiANCiAJaWYgKHVzZXJfbW9kZV92bShyZWdzKSkNCiAJCXBy
aW50aygiIEVTUDogJTA0eDolMDhseCIsMHhmZmZmICYgcmVncy0+eHNzLHJl
Z3MtPmVzcCk7DQotCXByaW50aygiIEVGTEFHUzogJTA4bHggICAgJXMgICgl
cyAlLipzKVxuIiwNCi0JICAgICAgIHJlZ3MtPmVmbGFncywgcHJpbnRfdGFp
bnRlZCgpLCBpbml0X3V0c25hbWUoKS0+cmVsZWFzZSwNCi0JICAgICAgIChp
bnQpc3RyY3Nwbihpbml0X3V0c25hbWUoKS0+dmVyc2lvbiwgIiAiKSwNCi0J
ICAgICAgIGluaXRfdXRzbmFtZSgpLT52ZXJzaW9uKTsNCisJcHJpbnRrKCIg
RUZMQUdTOiAlMDhseCAgICAlc1xuIiwNCisJICAgICAgIHJlZ3MtPmVmbGFn
cywgcHJpbnRfdGFpbnRlZCgpKTsNCiAJcHJpbnRrKCJFQVg6ICUwOGx4IEVC
WDogJTA4bHggRUNYOiAlMDhseCBFRFg6ICUwOGx4XG4iLA0KIAkJcmVncy0+
ZWF4LHJlZ3MtPmVieCxyZWdzLT5lY3gscmVncy0+ZWR4KTsNCiAJcHJpbnRr
KCJFU0k6ICUwOGx4IEVESTogJTA4bHggRUJQOiAlMDhseCIsDQpkaWZmIC0t
Z2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL3Bv
d2VycGMva2VybmVsL3Byb2Nlc3MuYw0KaW5kZXggNmUyZjAzNS4uMDRjNGFi
ZCAxMDA2NDQNCi0tLSBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvcHJvY2Vzcy5j
DQorKysgYi9hcmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYw0KQEAgLTMy
LDcgKzMyLDYgQEAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNs
dWRlIDxsaW51eC9rYWxsc3ltcy5oPg0KICNpbmNsdWRlIDxsaW51eC9tcXVl
dWUuaD4NCiAjaW5jbHVkZSA8bGludXgvaGFyZGlycS5oPg0KLSNpbmNsdWRl
IDxsaW51eC91dHNuYW1lLmg+DQogDQogI2luY2x1ZGUgPGFzbS9wZ3RhYmxl
Lmg+DQogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+DQpAQCAtNDE0LDggKzQx
Myw4IEBAIHZvaWQgc2hvd19yZWdzKHN0cnVjdCBwdF9yZWdzICogcmVncykN
CiANCiAJcHJpbnRrKCJOSVA6ICJSRUciIExSOiAiUkVHIiBDVFI6ICJSRUci
XG4iLA0KIAkgICAgICAgcmVncy0+bmlwLCByZWdzLT5saW5rLCByZWdzLT5j
dHIpOw0KLQlwcmludGsoIlJFR1M6ICVwIFRSQVA6ICUwNGx4ICAgJXMgICgl
cylcbiIsDQotCSAgICAgICByZWdzLCByZWdzLT50cmFwLCBwcmludF90YWlu
dGVkKCksIGluaXRfdXRzbmFtZSgpLT5yZWxlYXNlKTsNCisJcHJpbnRrKCJS
RUdTOiAlcCBUUkFQOiAlMDRseCAgICVzXG4iLA0KKwkgICAgICAgcmVncywg
cmVncy0+dHJhcCwgcHJpbnRfdGFpbnRlZCgpKTsNCiAJcHJpbnRrKCJNU1I6
ICJSRUciICIsIHJlZ3MtPm1zcik7DQogCXByaW50Yml0cyhyZWdzLT5tc3Is
IG1zcl9iaXRzKTsNCiAJcHJpbnRrKCIgIENSOiAlMDhseCAgWEVSOiAlMDhs
eFxuIiwgcmVncy0+Y2NyLCByZWdzLT54ZXIpOw0KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2XzY0L2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL3g4Nl82NC9rZXJu
ZWwvcHJvY2Vzcy5jDQppbmRleCA1OTA5MDM5Li45NGZiN2UzIDEwMDY0NA0K
LS0tIGEvYXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYw0KKysrIGIvYXJj
aC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYw0KQEAgLTMyLDcgKzMyLDYgQEAg
I2luY2x1ZGUgPGxpbnV4L2Eub3V0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2lu
dGVycnVwdC5oPg0KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KICNpbmNs
dWRlIDxsaW51eC9wdHJhY2UuaD4NCi0jaW5jbHVkZSA8bGludXgvdXRzbmFt
ZS5oPg0KICNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4NCiAjaW5jbHVkZSA8
bGludXgvbm90aWZpZXIuaD4NCiAjaW5jbHVkZSA8bGludXgva3Byb2Jlcy5o
Pg0KQEAgLTMxMCwxMSArMzA5LDggQEAgdm9pZCBfX3Nob3dfcmVncyhzdHJ1
Y3QgcHRfcmVncyAqIHJlZ3MpDQogDQogCXByaW50aygiXG4iKTsNCiAJcHJp
bnRfbW9kdWxlcygpOw0KLQlwcmludGsoIlBpZDogJWQsIGNvbW06ICUuMjBz
ICVzICVzICUuKnNcbiIsDQotCQljdXJyZW50LT5waWQsIGN1cnJlbnQtPmNv
bW0sIHByaW50X3RhaW50ZWQoKSwNCi0JCWluaXRfdXRzbmFtZSgpLT5yZWxl
YXNlLA0KLQkJKGludClzdHJjc3BuKGluaXRfdXRzbmFtZSgpLT52ZXJzaW9u
LCAiICIpLA0KLQkJaW5pdF91dHNuYW1lKCktPnZlcnNpb24pOw0KKwlwcmlu
dGsoIlBpZDogJWQsIGNvbW06ICUuMjBzICVzXG4iLA0KKwkJY3VycmVudC0+
cGlkLCBjdXJyZW50LT5jb21tLCBwcmludF90YWludGVkKCkpOw0KIAlwcmlu
dGsoIlJJUDogJTA0bHg6WzwlMDE2bHg+XSAiLCByZWdzLT5jcyAmIDB4ZmZm
ZiwgcmVncy0+cmlwKTsNCiAJcHJpbnRrX2FkZHJlc3MocmVncy0+cmlwKTsg
DQogCXByaW50aygiUlNQOiAlMDRseDolMDE2bHggIEVGTEFHUzogJTA4bHhc
biIsIHJlZ3MtPnNzLCByZWdzLT5yc3AsDQpkaWZmIC0tZ2l0IGEva2VybmVs
L3N5cy5jIGIva2VybmVsL3N5cy5jDQppbmRleCA4NzIyNzFjLi42ZTAxMDg1
IDEwMDY0NA0KLS0tIGEva2VybmVsL3N5cy5jDQorKysgYi9rZXJuZWwvc3lz
LmMNCkBAIC0zMSw2ICszMSw3IEBAICNpbmNsdWRlIDxsaW51eC9zaWduYWwu
aD4NCiAjaW5jbHVkZSA8bGludXgvY25fcHJvYy5oPg0KICNpbmNsdWRlIDxs
aW51eC9nZXRjcHUuaD4NCiAjaW5jbHVkZSA8bGludXgvdGFza19pb19hY2Nv
dW50aW5nX29wcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9rZGVidWcuaD4NCiAN
CiAjaW5jbHVkZSA8bGludXgvY29tcGF0Lmg+DQogI2luY2x1ZGUgPGxpbnV4
L3N5c2NhbGxzLmg+DQpAQCAtOTgsNiArOTksMzYgQEAgc3RydWN0IHBpZCAq
Y2FkX3BpZDsNCiBFWFBPUlRfU1lNQk9MKGNhZF9waWQpOw0KIA0KIC8qDQor
ICogRHVtcCBvdXQgVVRTIGluZm8gb24gb29wcyAvIHBhbmljLiAgV2UgcHJl
Z2VuZXJhdGUgdXRzbmFtZV9pbmZvIHNvIHRoYXQNCisgKiB3ZSBkb24ndCBh
Y2Nlc3MgdXRzbmFtZSgpIGlmIHRoZSBtYWNoaW5lIGlzIGluIGEgcG90ZW50
aWFsbHkgYmFkIHN0YXRlLg0KKyAqLw0KKw0KK3N0YXRpYyBjaGFyICp1dHNu
YW1lX2luZm87DQorDQorc3RhdGljIGludCBkdW1wX3V0c25hbWUoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICpzZWxmLCB1bnNpZ25lZCBsb25nIGRpZWNvZGUs
DQorCQl2b2lkICpwKQ0KK3sNCisJcHJpbnRrKEtFUk5fRU1FUkcgIiVzXG4i
LCB1dHNuYW1lX2luZm8pOw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGlj
IHN0cnVjdCBub3RpZmllcl9ibG9jayB1dHNuYW1lX25vdGlmaWVyID0gew0K
Kwkubm90aWZpZXJfY2FsbCA9IGR1bXBfdXRzbmFtZQ0KK307DQorDQorc3Rh
dGljIGludCBfX2luaXQgcmVnaXN0ZXJfdXRzbmFtZV9kdW1wKHZvaWQpDQor
ew0KKwl1dHNuYW1lX2luZm8gPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgIiVz
ICVzICVzICVzIiwNCisJCXV0c25hbWUoKS0+c3lzbmFtZSwNCisJCXV0c25h
bWUoKS0+cmVsZWFzZSwNCisJCXV0c25hbWUoKS0+dmVyc2lvbiwNCisJCXV0
c25hbWUoKS0+bWFjaGluZSk7DQorCXJlZ2lzdGVyX2RpZV9ub3RpZmllcigm
dXRzbmFtZV9ub3RpZmllcik7DQorCXJldHVybiAwOw0KK30NCittb2R1bGVf
aW5pdChyZWdpc3Rlcl91dHNuYW1lX2R1bXApOw0KKw0KKy8qDQogICoJTm90
aWZpZXIgbGlzdCBmb3Iga2VybmVsIGNvZGUgd2hpY2ggd2FudHMgdG8gYmUg
Y2FsbGVkDQogICoJYXQgc2h1dGRvd24uIFRoaXMgaXMgdXNlZCB0byBzdG9w
IGFueSBpZGxpbmcgRE1BIG9wZXJhdGlvbnMNCiAgKglhbmQgdGhlIGxpa2Uu
IA0K

--313268086-1458176100-1184005365=:617--
