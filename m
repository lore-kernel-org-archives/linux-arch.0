From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: using IS_ENABLED(CONFIG_xyz) effectively
Date: Mon, 16 Nov 2015 10:03:44 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44D19C5@IN01WEMBXA.internal.synopsys.com>
References: <5613F3DE.4010406@suse.cz>
 <CAMuHMdVEK041TFY3JJ1kvYE_e_C72+FcRu3ewDipLPi-kN-h=A@mail.gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44D1969@IN01WEMBXA.internal.synopsys.com>
 <4200245.e01Ct9ua6M@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:38691 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbKPKDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 05:03:50 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>

On Monday 16 November 2015 02:22 PM, Arnd Bergmann wrote:
> On Monday 16 November 2015 08:35:05 Vineet Gupta wrote:
>> Hi Geert,
>>
>> On Monday 16 November 2015 01:58 PM, Geert Uytterhoeven wrote:
>>> Hi Vineet,
>>>
>>> On Mon, Nov 16, 2015 at 9:00 AM, Vineet Gupta
>>> <Vineet.Gupta1@synopsys.com> wrote:
>>>> I've been using IS_ENABLED for some time and once in a while run into an issue
>>>> which prevents seamless use. Hence posing this question to experts in the area.
>>>>
>>>> C macro processor evaluates the ensuing control block even if IS_ENABLED evaluates
>>>> to false. This requires dummy #defines or worse still removing usage of IS_ENABLED
>>>> altogether.
>>>>
>>>> e.g. In example below even for ARCOMPACT builds, we need the ARCV2 specific define
>>>> ARCV2_IRQ_DEF_PRIO.
>>>>
>>>> void arch_cpu_idle(void)
>>>> {
>>>>         if (is_isa_arcompact()) {    <---- IS_ENABLED(CONFIG_ISA_ARCOMPACT)
>>>>                 __asm__("sleep 0x3");
>>>>         } else {
>>>>                 const int arg = 0x10 | ARCV2_IRQ_DEF_PRIO;
>>>>                __asm__("sleep 0x10");
>>>>         }
>>>> }
>>>>
>>>> One could argue that the interface needs to be cleanly defined to not have such
>>>> specific #defines in common code in first place. However sometime that becomes
>>>> just too tedious.
>>>>
>>>> Is there a way to get around by this ?
>>> Use #ifdef CONFIG_...?
>>>
>>> The advantage of IS_ENABLED() over #ifdef is that it allows compile-testing of
>>> the disabled code path. Of course it should only be compiled if it makes
>>> sense. And that's exactly what you're running into.
>> And I thought it was to de-uglify the code with same semantics - which doesn't
>> seem to be the case !
> I would still try to do this with if(IS_ENABLED()) or another macro
> like you have above. The problem you ran into with the macro definitions
> is that you have conflicting header files:
>
> #ifdef CONFIG_ISA_ARCOMPACT
> #include <asm/irqflags-compact.h>
> #else
> #include <asm/irqflags-arcv2.h>
> #endif
>
> This has other (small) problems too, because you get possibly conflicting
> symbols (e.g. arch_local_irq_enable but also the register names) that
> make it harder to follow what's going on when reading the code.
> If you prefix all the defines in the two headers with the respective name,
> you can just include both headers and avoid this:
>
> static inline void arch_local_irq_enable(void)
> {
> 	if (IS_ENABLED(CONFIG_ISA_ARCCOMPACT))
> 		return arccompact_local_irq_enable();
> 	else
> 		return arcv2_local_irq_enable();
> }
>
> 	Arnd

So my approach was different - I felt it was cleaner to export same "interface"
from ISA specific code to ISA common code. It seemed more readable vs. the
explicit if check above in each function which was dependent on ISA.

Plus given that the ISA are not compatible, I wanted to ensure we were not mixing
(even by accident) any code for one into a build for other. This ofcourse means
that my original question / request is wrong in first place. With current
structuring of code, I need to make sure that such ISA specific #defines don't end
in ISA common code anyways.

So something like below

------------->
diff --git a/arch/arc/include/asm/irqflags-arcv2.h
b/arch/arc/include/asm/irqflags-arcv2.h
index ad481c24070d..f7c8d3cbeaa1 100644
--- a/arch/arc/include/asm/irqflags-arcv2.h
+++ b/arch/arc/include/asm/irqflags-arcv2.h
@@ -37,6 +37,8 @@
 #define ISA_INIT_STATUS_BITS    (STATUS_IE_MASK | STATUS_AD_MASK | \
                     (ARCV2_IRQ_DEF_PRIO << 1))
 
+#define ISA_SLEEP_ARG        0x10
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arc/include/asm/irqflags-compact.h
b/arch/arc/include/asm/irqflags-compact.h
index d8c608174617..c1d36458bfb7 100644
--- a/arch/arc/include/asm/irqflags-compact.h
+++ b/arch/arc/include/asm/irqflags-compact.h
@@ -43,6 +43,8 @@
 
 #define ISA_INIT_STATUS_BITS    STATUS_IE_MASK
 
+#define ISA_SLEEP_ARG        0x3
+
 #ifndef __ASSEMBLY__
 
 /******************************************************************
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 91d5a0f1f3f7..a3f750e76b68 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -44,11 +44,10 @@ SYSCALL_DEFINE0(arc_gettls)
 void arch_cpu_idle(void)
 {
     /* sleep, but enable all interrupts before committing */
-    if (is_isa_arcompact()) {
-        __asm__("sleep 0x3");
-    } else {
-        __asm__("sleep 0x10");
-    }
+    __asm__ __volatile__(
+        "sleep %0    \n"
+        :
+        :"I"(ISA_SLEEP_ARG)); /* can't be "r" has to be embedded const */
 }
 
 asmlinkage void ret_from_fork(void);
-- 


-Vineet
