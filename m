From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2 0/3] improve wait logic of stop_machine
Date: Thu, 13 Jun 2019 15:48:58 +0200
Message-ID: <20190613134858.GL3436@hirez.programming.kicks-ass.net>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 13, 2019 at 12:35:07PM +0200, Heiko Carstens wrote:
> Heiko Carstens (2):
>   processor: remove spin_cpu_yield
>   processor: get rid of cpu_relax_yield
> 
> Martin Schwidefsky (1):
>   s390: improve wait logic of stop_machine
> 
>  arch/powerpc/include/asm/processor.h |  2 --
>  arch/s390/include/asm/processor.h    |  7 +------
>  arch/s390/kernel/processor.c         | 19 +++++++++++++------
>  arch/s390/kernel/smp.c               |  2 +-
>  include/linux/processor.h            |  9 ---------
>  include/linux/sched.h                |  4 ----
>  include/linux/stop_machine.h         |  1 +
>  kernel/stop_machine.c                | 19 ++++++++++++++-----
>  8 files changed, 30 insertions(+), 33 deletions(-)

Seems sensible to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
