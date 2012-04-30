From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 00/29] init_task: Use a generic init_task variant
Date: Mon, 30 Apr 2012 22:37:43 +0200
Message-ID: <20120430203743.GA8934@merkur.ravnborg.org>
References: <20120430194725.763322463@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120430194725.763322463@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 30, 2012 at 08:15:50PM -0000, Thomas Gleixner wrote:
> All architectures do roughly the same to initialize init_task. The
> only architecture which deviates is ia64, but I could not figure out
> why it couldn't use the same setup as all other architectures.
> 
> The following series converts all archs to a generic version.
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/um/kernel/init_task.c          |   38 -------------------
>  arch/unicore32/kernel/init_task.c   |   44 ----------------------
>  arch/x86/kernel/init_task.c         |   42 ---------------------
>  arch/xtensa/kernel/init_task.c      |   31 ---------------
>  tip/arch/um/kernel/um_arch.c        |    5 ++
>  tip/arch/unicore32/Makefile         |    1 
>  tip/arch/unicore32/kernel/Makefile  |    2 -
>  tip/arch/x86/Makefile               |    1 
>  tip/arch/x86/kernel/Makefile        |    2 -
>  tip/arch/x86/kernel/process.c       |    9 ++++
>  tip/arch/xtensa/kernel/Makefile     |    2 -
>  tip/kernel/sched/Makefile           |    4 --
>  tip/kernel/sched/init_task.c        |   24 ++++++++++++

Diffstat looks funny. Some tip stuff sneaked in.
Also I am missing patch 1..

	Sam
