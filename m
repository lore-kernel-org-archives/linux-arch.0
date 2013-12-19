From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH -tip v6 04/22] [BUGFIX] x86: Prohibit probing on
 native_set_debugreg/load_idt
Date: Thu, 19 Dec 2013 09:04:04 +0000
Message-ID: <20131219090404.14309.41149.stgit@kbuild-fedora.novalocal>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Prohibit probing on native_set_debugreg and native_load_idt.
Since the kprobes uses do_debug for single stepping,
functions called from do_debug before notify_die must not
be probed.
And also native_load_idt is called from paranoid_exit when
returning int3, this also must not be probed.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/paravirt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 4c785fd..abff75f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -390,8 +390,10 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 	.end_context_switch = paravirt_nop,
 };
 
-/* At this point, native_get_debugreg has real function entry */
+/* At this point, native_get/set_debugreg has real function entry */
 NOKPROBE_SYMBOL(native_get_debugreg);
+NOKPROBE_SYMBOL(native_set_debugreg);
+NOKPROBE_SYMBOL(native_load_idt);
 
 struct pv_apic_ops pv_apic_ops = {
 #ifdef CONFIG_X86_LOCAL_APIC
