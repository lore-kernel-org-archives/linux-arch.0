From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC patch 07/15] LTTng timestamp
Date: Fri, 17 Oct 2008 17:15:13 +0900 (JST)
Message-ID: <20081017171212.E230.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20081016232729.699004293@polymtl.ca> <20081016234656.542407833@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35847 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbYJQIPR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Oct 2008 04:15:17 -0400
In-Reply-To: <20081016234656.542407833@polymtl.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: kosaki.motohiro@jp.fujitsu.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, Ingo Molnar <mingo@redhat.com>


more nit.

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +#include <linux/workqueue.h>
> +#include <linux/cpu.h>
> +#include <linux/timex.h>
> +#include <linux/bitops.h>
> +#include <linux/ltt.h>

ltt.h is created by 08/15. then following build error happend.

make[1]: `include/asm-ia64/nr-irqs.h' is up to date.
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  GZIP    kernel/config_data.gz
  IKCFG   kernel/config_data.h
  CC      kernel/configs.o
  LD      kernel/built-in.o
  CC      ltt/ltt-timestamp.o
ltt/ltt-timestamp.c:23:23: error: linux/ltt.h: No such file or directory
ltt/ltt-timestamp.c: In function 'ltt_update_synthetic_tsc':
ltt/ltt-timestamp.c:75: error: implicit declaration of function 'ltt_get_timestamp32'
ltt/ltt-timestamp.c: In function 'precalc_stsc_interval':
ltt/ltt-timestamp.c:157: error: implicit declaration of function 'ltt_frequency'
ltt/ltt-timestamp.c:157: error: implicit declaration of function 'ltt_freq_scale'
make[1]: *** [ltt/ltt-timestamp.o] Error 1
make: *** [ltt] Error 2


> +#include <linux/smp.h>
> +#include <linux/sched.h> /* FIX for m68k local_irq_enable in on_each_cpu */
