From: Venki Pallipadi <venki@google.com>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 16:11:56 -0700
Message-ID: <CABeCy1Y0HTtVvRC0bqaHbhqpumek+dERTY6EH_qO2neP6U8U_A@mail.gmail.com>
References: <20120420122120.097464672@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50936 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab2DTXL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2012 19:11:57 -0400
Received: by iagz16 with SMTP id z16so14029158iag.19
        for <linux-arch@vger.kernel.org>; Fri, 20 Apr 2012 16:11:57 -0700 (PDT)
In-Reply-To: <20120420122120.097464672@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On Fri, Apr 20, 2012 at 6:05 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> Dear all,
>
> I'm working on refactoring the SMP boot and CPU hotplug implementatio=
n.
>
> The current code has evolved over time into a conglomerate of
> warts. My main goals are to:
>
> =A0- reduce the architecture code by moving repeating constructs to t=
he
> =A0 core
>
> =A0- redesigning the handling of per cpu threads. There is no point t=
o
> =A0 tear down the threads just to create them again.
>
> =A0- restructuring the notifier facility into a proper tree with
> =A0 dependencies to avoid the gazillion of callbacks and moving
> =A0 setup/teardown code into the context of the upcoming/dying cpu
>
> The motivation behind this work is the cpu hotplug nightmare which we
> are facing in the RT kernel and the requests from several groups
> (e.g. ARM) to make hotplug more lightweight and faster.
>
> This first part moves the idle thread management for non-boot cpus
> into the core. fork_idle() is called in a workqueue as it is
> implemented in a few architectures already. This is necessary when no=
t
> all cpus are brought up by the early boot code as otherwise we would
> take a ref on the user task VM of the thread which brings the cpu up
> via the sysfs interface.
>

I had sent out a patchset that did this cleanup here:
https://lkml.org/lkml/2012/3/6/466

This patchset is clean and more exhaustive than what I had. So,

Acked-by: Venkatesh Pallipadi <venki@google.com>

> This converts all architectures except m32r, mn10300, tile and UM to
> the new core facility. These architecture are calling fork_idle() in
> the very early boot code in smp_prepare_cpus() for unknown reasons.
> I haven't analyzed yet, whether this is on purpose or can be moved
> over to the generic facility. It'd be nice if the responsible maintai=
ners
> could look into that as well.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
