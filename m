From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] arch: Remove stub cputime.h headers
Date: Wed, 12 Mar 2014 10:44:47 +0100
Message-ID: <20140312094447.GP30956@twins.programming.kicks-ass.net>
References: <1394590202-772-1-git-send-email-fweisbec@gmail.com>
 <1394590202-772-7-git-send-email-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394590202-772-7-git-send-email-fweisbec@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Archs <linux-arch@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 12, 2014 at 03:10:02AM +0100, Frederic Weisbecker wrote:
> diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
> index a73a8e2..1a81a8b 100644
> --- a/arch/alpha/include/asm/Kbuild
> +++ b/arch/alpha/include/asm/Kbuild
> @@ -5,3 +5,4 @@ generic-y += exec.h
>  generic-y += trace_clock.h
>  generic-y += preempt.h
>  generic-y += hash.h
> +generic-y += cputime.h
> \ No newline at end of file

That's a double fail there, not sorted and no EOL.

Please run the script from commit: b119fa61d440f after you touch the
asm/Kbuild files.
