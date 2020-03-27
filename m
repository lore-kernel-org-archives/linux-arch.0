Return-Path: <SRS0=twat=5M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44756 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0InI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 04:43:08 -0400
MIME-Version: 1.0
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com> <105f17f25e90a9a58299a7ed644bdd0f36434c87.camel@marvell.com>
In-Reply-To: <105f17f25e90a9a58299a7ed644bdd0f36434c87.camel@marvell.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Fri, 27 Mar 2020 09:42:55 +0100
Message-ID: <CAApg2=ThxqOj8a2uZbRVgXZFjHWHk9g_xY3eseobQWwHLxiREg@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] task_isolation: userspace hard isolation from kernel
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Message-ID: <20200327084255.IrdtnUX4lqABLHCCreFaiGXTZ6E7BC4NXgYFrGI6IrQ@z>

On Sun, Mar 8, 2020 at 4:48 AM Alex Belits <abelits@marvell.com> wrote:
> +/* Enable task_isolation mode for TASK_ISOLATION kernels. */
> +#define PR_TASK_ISOLATION              48
> +# define PR_TASK_ISOLATION_ENABLE      (1 << 0)
> +# define PR_TASK_ISOLATION_SET_SIG(sig)        (((sig) & 0x7f) << 8)
> +# define PR_TASK_ISOLATION_GET_SIG(bits) (((bits) >> 8) & 0x7f)
> +
Thank you for resurrecting this code!

I have a question on the UAPI: the example code is using
PR_TASK_ISOLATION_USERSIG and it seems to be removed from this
version.

To enable isolation with SIGUSR1 the task should run:
prctl(PR_SET_TASK_ISOLATION, PR_TASK_ISOLATION_ENABLE
    | PR_TASK_ISOLATION_SET_SIG(SIGUSR1), 0, 0, 0);

And to disable:
prctl(PR_SET_TASK_ISOLATION, 0, 0, 0, 0);

Is this correct?
Marta
