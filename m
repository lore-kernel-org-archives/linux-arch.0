From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch V5 13/15] x86/entry: Use generic interrupt entry/exit code
Date: Fri, 24 Jul 2020 16:28:48 +0200
Message-ID: <20200724142848.GB651711@gmail.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.711492752@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXO2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 10:28:52 -0400
Content-Disposition: inline
In-Reply-To: <20200722220520.711492752@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the x86 code with the generic variant. Use temporary defines for
> idtentry_* which will be cleaned up in the next step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

There was a comment that still referenced the old x86-specific API 
names - the patch below updates them.

Thanks,

	Ingo

====
 arch/x86/include/asm/idtentry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 73eb277e63ab..a9fb57f06d39 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -128,7 +128,7 @@ static __always_inline void __##func(struct pt_regs *regs,		\
  * body with a pair of curly brackets.
  *
  * Contrary to DEFINE_IDTENTRY() this does not invoke the
- * idtentry_enter/exit() helpers before and after the body invocation. This
+ * irqentry_enter/exit() helpers before and after the body invocation. This
  * needs to be done in the body itself if applicable. Use if extra work
  * is required before the enter/exit() helpers are invoked.
  */
