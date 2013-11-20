Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.hitachi.co.jp ([133.145.228.50]:57844 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab3KTEZN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 23:25:13 -0500
Subject: [PATCH -tip v3 17/23] x86/kvm: Use NOKPROBE_SYMBOL macro in kvm.c
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date: Wed, 20 Nov 2013 04:22:31 +0000
Message-ID: <20131120042231.15296.11510.stgit@kbuild-fedora.novalocal>
In-Reply-To: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131120042231.KDN4Kv-XW35NmOrP7tU-8ocMYfnR1KZ4DUhPAdsMBs8@z>

Use NOKPROBE_SYMBOL macro for protecting functions
from kprobes instead of __kprobes annotation in kvm.c.
This also adds kvm_read_and_reset_pf_reason in
the blacklist because it can be called before
do_page_fault.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Gleb Natapov <gleb@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
---
 arch/x86/kernel/kvm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6dd802c..fb95987 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -251,8 +251,9 @@ u32 kvm_read_and_reset_pf_reason(void)
 	return reason;
 }
 EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
+NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
-dotraplinkage void __kprobes
+dotraplinkage void
 do_async_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	enum ctx_state prev_state;
@@ -276,6 +277,7 @@ do_async_page_fault(struct pt_regs *regs, unsigned long error_code)
 		break;
 	}
 }
+NOKPROBE_SYMBOL(do_async_page_fault);
 
 static void __init paravirt_ops_setup(void)
 {


