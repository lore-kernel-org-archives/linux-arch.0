From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/29] init_task: Use a generic init_task variant
Date: Mon, 30 Apr 2012 22:43:14 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204302240190.6271@ionos>
References: <20120430194725.763322463@linutronix.de> <20120430203743.GA8934@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35996 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585Ab2D3UnQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:43:16 -0400
In-Reply-To: <20120430203743.GA8934@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Mon, 30 Apr 2012, Sam Ravnborg wrote:

> On Mon, Apr 30, 2012 at 08:15:50PM -0000, Thomas Gleixner wrote:
> > All architectures do roughly the same to initialize init_task. The
> > only architecture which deviates is ia64, but I could not figure out
> > why it couldn't use the same setup as all other architectures.
> > 
> > The following series converts all archs to a generic version.
> > 
> > Thanks,
> > 
> > 	tglx
> > ---
> >  arch/um/kernel/init_task.c          |   38 -------------------
> >  arch/unicore32/kernel/init_task.c   |   44 ----------------------
> >  arch/x86/kernel/init_task.c         |   42 ---------------------
> >  arch/xtensa/kernel/init_task.c      |   31 ---------------
> >  tip/arch/um/kernel/um_arch.c        |    5 ++
> >  tip/arch/unicore32/Makefile         |    1 
> >  tip/arch/unicore32/kernel/Makefile  |    2 -
> >  tip/arch/x86/Makefile               |    1 
> >  tip/arch/x86/kernel/Makefile        |    2 -
> >  tip/arch/x86/kernel/process.c       |    9 ++++
> >  tip/arch/xtensa/kernel/Makefile     |    2 -
> >  tip/kernel/sched/Makefile           |    4 --
> >  tip/kernel/sched/init_task.c        |   24 ++++++++++++
> 
> Diffstat looks funny. Some tip stuff sneaked in.

Nah. That's diffstat madness. It does not add the prefix to the
deleted files, but for the modified ones it keeps it.

> Also I am missing patch 1..

I've got all of them sent back by vger ...

Thanks,

	tglx
