Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:46835 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbYKDKiv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Nov 2008 05:38:51 -0500
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 4E05780C6
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2008 11:09:28 +0100 (CET)
Date: Tue, 4 Nov 2008 11:09:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] kernel/cpu.c: Section mismatch warning fix.
Message-ID: <20081104100912.GB6651@uranus.ravnborg.org>
References: <b9df5fa10810292104h38fcee68kae42cf5ab6275fbb@mail.gmail.com> <20081103153425.7282ab84.akpm@linux-foundation.org> <20081104094831.GP23790@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081104094831.GP23790@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rakib Mullick <rakib.mullick@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20081104100912.IwvLTiNqDUok1TsWRQ8REKVLwkNwRn5ZLSTSfYO04mA@z>

On Tue, Nov 04, 2008 at 10:48:31AM +0100, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Thu, 30 Oct 2008 10:04:54 +0600
> > "Rakib Mullick" <rakib.mullick@gmail.com> wrote:
> > 
> > >  LD      kernel/built-in.o
> > > WARNING: kernel/built-in.o(.text+0xb7c8): Section mismatch in
> > > reference from the function notify_cpu_starting() to the variable
> > > .cpuinit.data:cpu_chain
> > > The function notify_cpu_starting() references
> > > the variable __cpuinitdata cpu_chain.
> > > This is often because notify_cpu_starting lacks a __cpuinitdata
> > > annotation or the annotation of cpu_chain is wrong.
> > > 
> > > This patch fixes the above section mismatch warning. If anything else
> > > please notice.
> > > Thanks.
> > > 
> > > Signed-off-by: Md.Rakib H. Mullick <rakib.mullick@gmail.com>
> > > 
> > > --- linux-2.6-orig/kernel/cpu.c	2008-10-28 20:52:38.000000000 +0600
> > > +++ linux-2.6/kernel/cpu.c	2008-10-28 22:46:22.000000000 +0600
> > > @@ -462,7 +462,7 @@ out:
> > >   * It must be called by the arch code on the new cpu, before the new cpu
> > >   * enables interrupts and before the "boot" cpu returns from __cpu_up().
> > >   */
> > > -void notify_cpu_starting(unsigned int cpu)
> > > +void __cpuinit notify_cpu_starting(unsigned int cpu)
> > >  {
> > >  	unsigned long val = CPU_STARTING;
> > 
> > arch/alpha/kernel/smp.c calls notify_cpu_starting() from __init code.
> > 
> > arch/cris/arch-v32/kernel/smp.c calls notify_cpu_starting() from __init code.
> > 
> > arch/x86/mach-voyager/voyager_smp.c calls notify_cpu_starting() from
> > __init code.
> > 
> > arch/m32r/kernel/smpboot.c calls notify_cpu_starting() from __init code.
> > 
> > arch/sparc/kernel/sun4d_smp.c calls notify_cpu_starting() from __init code.
> > 
> > arch/powerpc/kernel/smp.c calls notify_cpu_starting() from __devinit
> > code.
> > 
> > arch/um/kernel/smp.c calls notify_cpu_starting() from .text code.
> > 
> > 
> > The other nine callers call notify_cpu_starting() from __cpuinit code.
> > 
> > 
> > What a mess.
> 
> __cpuinit seems safe for all but UML.
> 
> But even for UML it appears to be de-facto safe: as after bootup we 
> never return back into arch/um/kernel/smp.c::idle_proc(). (as UML's 
From the list Andrew provided powerpc needs to be looked after.
We cannot call an __init function from __devinit context.
If you already checked that then no objections.

	Sam
