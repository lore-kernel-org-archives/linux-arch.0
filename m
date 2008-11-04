From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kernel/cpu.c: Section mismatch warning fix.
Date: Tue, 4 Nov 2008 11:22:52 +0100
Message-ID: <20081104102252.GA14339@elte.hu>
References: <b9df5fa10810292104h38fcee68kae42cf5ab6275fbb@mail.gmail.com> <20081103153425.7282ab84.akpm@linux-foundation.org> <20081104094831.GP23790@elte.hu> <20081104100912.GB6651@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:47203 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924AbYKDKXJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Nov 2008 05:23:09 -0500
Content-Disposition: inline
In-Reply-To: <20081104100912.GB6651@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rakib Mullick <rakib.mullick@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> On Tue, Nov 04, 2008 at 10:48:31AM +0100, Ingo Molnar wrote:
> > 
> > * Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Thu, 30 Oct 2008 10:04:54 +0600
> > > "Rakib Mullick" <rakib.mullick@gmail.com> wrote:
> > > 
> > > >  LD      kernel/built-in.o
> > > > WARNING: kernel/built-in.o(.text+0xb7c8): Section mismatch in
> > > > reference from the function notify_cpu_starting() to the variable
> > > > .cpuinit.data:cpu_chain
> > > > The function notify_cpu_starting() references
> > > > the variable __cpuinitdata cpu_chain.
> > > > This is often because notify_cpu_starting lacks a __cpuinitdata
> > > > annotation or the annotation of cpu_chain is wrong.
> > > > 
> > > > This patch fixes the above section mismatch warning. If anything else
> > > > please notice.
> > > > Thanks.
> > > > 
> > > > Signed-off-by: Md.Rakib H. Mullick <rakib.mullick@gmail.com>
> > > > 
> > > > --- linux-2.6-orig/kernel/cpu.c	2008-10-28 20:52:38.000000000 +0600
> > > > +++ linux-2.6/kernel/cpu.c	2008-10-28 22:46:22.000000000 +0600
> > > > @@ -462,7 +462,7 @@ out:
> > > >   * It must be called by the arch code on the new cpu, before the new cpu
> > > >   * enables interrupts and before the "boot" cpu returns from __cpu_up().
> > > >   */
> > > > -void notify_cpu_starting(unsigned int cpu)
> > > > +void __cpuinit notify_cpu_starting(unsigned int cpu)
> > > >  {
> > > >  	unsigned long val = CPU_STARTING;
> > > 
> > > arch/alpha/kernel/smp.c calls notify_cpu_starting() from __init code.
> > > 
> > > arch/cris/arch-v32/kernel/smp.c calls notify_cpu_starting() from __init code.
> > > 
> > > arch/x86/mach-voyager/voyager_smp.c calls notify_cpu_starting() from
> > > __init code.
> > > 
> > > arch/m32r/kernel/smpboot.c calls notify_cpu_starting() from __init code.
> > > 
> > > arch/sparc/kernel/sun4d_smp.c calls notify_cpu_starting() from __init code.
> > > 
> > > arch/powerpc/kernel/smp.c calls notify_cpu_starting() from __devinit
> > > code.
> > > 
> > > arch/um/kernel/smp.c calls notify_cpu_starting() from .text code.
> > > 
> > > 
> > > The other nine callers call notify_cpu_starting() from __cpuinit code.
> > > 
> > > 
> > > What a mess.
> > 
> > __cpuinit seems safe for all but UML.
> > 
> > But even for UML it appears to be de-facto safe: as after bootup we 
> > never return back into arch/um/kernel/smp.c::idle_proc(). (as UML's 
> >From the list Andrew provided powerpc needs to be looked after.
> We cannot call an __init function from __devinit context.
> If you already checked that then no objections.

the patch/context in question is attached below - in that we weaken 
the persistency of notify_cpu_starting() from .text to __cpuinit. 
Which should be safe, right?

	Ingo

-------->
From 685aebb5fb26126e9be708cfed30e5ee20033c95 Mon Sep 17 00:00:00 2001
From: Rakib Mullick <rakib.mullick@gmail.com>
Date: Thu, 30 Oct 2008 10:04:54 +0600
Subject: [PATCH] kernel/cpu.c: section mismatch warning fix

Impact: small kernel .text reduction in certain configs, and fix warning

This warning:

  LD      kernel/built-in.o
 WARNING: kernel/built-in.o(.text+0xb7c8): Section mismatch in
 reference from the function notify_cpu_starting() to the variable
 .cpuinit.data:cpu_chain
 The function notify_cpu_starting() references
 the variable __cpuinitdata cpu_chain.
 This is often because notify_cpu_starting lacks a __cpuinitdata
 annotation or the annotation of cpu_chain is wrong.

Points out the fact that notify_cpu_starting() is only called
from __cpuinit sequences and itself uses a __cpuinitdata structure.

This patch fixes the above section mismatch warning.

Signed-off-by: Md.Rakib H. Mullick <rakib.mullick@gmail.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 86d4904..2e53420 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -462,7 +462,7 @@ out:
  * It must be called by the arch code on the new cpu, before the new cpu
  * enables interrupts and before the "boot" cpu returns from __cpu_up().
  */
-void notify_cpu_starting(unsigned int cpu)
+void __cpuinit notify_cpu_starting(unsigned int cpu)
 {
 	unsigned long val = CPU_STARTING;
 
