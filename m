From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi()
 callback in response to smp_send_reschedule()
Date: Mon, 17 Jan 2011 11:18:57 -0800
Message-ID: <4D349621.1040603@caviumnetworks.com>
References: <1295262433.30950.53.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1295262433.30950.53.camel@laptop>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-m32r-ja-rQhvJZKUsGBRYuoOT4C5/9i2O/JbrIOy@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hirokazu Takata <takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 01/17/2011 03:07 AM, Peter Zijlstra wrote:
> For future rework of try_to_wake_up() we'd like to push part of that
> onto the CPU the task is actually going to run on, in order to do so we
> need a generic callback from the existing scheduler IPI.
>
> This patch introduces such a generic callback: scheduler_ipi() and
> implements it as a NOP.
>
> I visited existing smp_send_reschedule() implementations and tried to
> add a call to scheduler_ipi() in their handler part, but esp. for MIPS
> I'm not quite sure I actually got all of them.
>
> Also, while reading through all this, I noticed the blackfin SMP code
> looks to be broken, it simply discards any IPI when low on memory.
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>
> ---
>   arch/alpha/kernel/smp.c         |    1 +
>   arch/arm/kernel/smp.c           |    1 +
>   arch/blackfin/mach-common/smp.c |    3 ++-
>   arch/cris/arch-v32/kernel/smp.c |   13 ++++++++-----
>   arch/ia64/kernel/irq_ia64.c     |    2 ++
>   arch/ia64/xen/irq_xen.c         |   10 +++++++++-
>   arch/m32r/kernel/smp.c          |    2 +-
>   arch/mips/kernel/smtc.c         |    1 +
>   arch/mips/sibyte/bcm1480/smp.c  |    7 +++----
>   arch/mips/sibyte/sb1250/smp.c   |    7 +++----
[...]

Peter,

You will also have to patch the mailbox_interrupt() function in 
arch/mips/cavium-octeon/smp.c

David Daney.
