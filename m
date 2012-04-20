From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [patch 03/18] smp: Add generic smpboot facility
Date: Fri, 20 Apr 2012 13:07:16 -0700
Message-ID: <CAE9FiQWpcD_GAtmnowTpAEW+6hRqxjokHKf4Nb2K92sm=SUGNQ@mail.gmail.com>
References: <20120420122120.097464672@linutronix.de>
	<20120420124557.035417523@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:56396 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab2DTUHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2012 16:07:17 -0400
In-Reply-To: <20120420124557.035417523@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>Richard

On Fri, Apr 20, 2012 at 6:05 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> Start a new file, which will hold SMP and CPU hotplug related generic
> infrastructure.
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/cpu.c
> +++ linux-2.6/kernel/cpu.c
> @@ -17,6 +17,8 @@
> =A0#include <linux/gfp.h>
> =A0#include <linux/suspend.h>
>
> +#include "smpboot.h"
> +
> =A0#ifdef CONFIG_SMP
> =A0/* Serializes the updates to cpu_online_mask, cpu_present_mask */
> =A0static DEFINE_MUTEX(cpu_add_remove_lock);
> @@ -300,6 +302,11 @@ static int __cpuinit _cpu_up(unsigned in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0cpu_hotplug_begin();
> +
> + =A0 =A0 =A0 ret =3D smpboot_prepare(cpu);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> =A0 =A0 =A0 =A0ret =3D __cpu_notify(CPU_UP_PREPARE | mod, hcpu, -1, &=
nr_calls);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nr_calls--;
> @@ -320,6 +327,7 @@ static int __cpuinit _cpu_up(unsigned in
> =A0out_notify:
> =A0 =A0 =A0 =A0if (ret !=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__cpu_notify(CPU_UP_CANCELED | mod, hc=
pu, nr_calls, NULL);
> +out:
> =A0 =A0 =A0 =A0cpu_hotplug_done();
>
> =A0 =A0 =A0 =A0return ret;
> Index: linux-2.6/kernel/smpboot.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/kernel/smpboot.c
> @@ -0,0 +1,12 @@
> +/*
> + * Common SMP CPU bringup/teardown functions
> + */
> +
> +#include "smpboot.h"
> +
> +/**
> + * smpboot_prepare - generic smpboot preparation
> + */
> +int __cpuinit smpboot_prepare(unsigned int cpu)
> +{
         return 0;
> +}
