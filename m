From: Christoph Lameter <cl@linux.com>
Subject: Re: [guv 04/16] core: Convert __get_cpu_var uses
Date: Mon, 26 Aug 2013 15:20:09 +0000
Message-ID: <00000140bb35f38a-99d5d8ab-6672-42e8-9e91-55cb231c693d-000000@email.amazonses.com>
References: <20130823190135.726207430@linux.com> <00000140ac8e2bdd-f0151a00-88ca-4d0b-adbc-007c514b6856-000000@email.amazonses.com> <20130826141849.GA6276@home.goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from b232-35.smtp-out.amazonses.com ([199.127.232.35]:11953 "EHLO
	b232-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751857Ab3HZP3r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Aug 2013 11:29:47 -0400
In-Reply-To: <20130826141849.GA6276@home.goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 26 Aug 2013, Steven Rostedt wrote:

> As Tejun said, each commit needs its own change log. Never expect a
> change lgo from another commit to be read for changes in this commit.

I can copy the intro into each of the patches?

> > Index: linux/kernel/time/tick-oneshot.c
> > Index: linux/kernel/trace/ftrace.c
> > Index: linux/kernel/user-return-notifier.c
> > Index: linux/kernel/watchdog.c
> > Index: linux/lib/radix-tree.c
> > Index: linux/mm/memcontrol.c
> > Index: linux/mm/memory-failure.c
> > Index: linux/mm/page-writeback.c
> > Index: linux/mm/swap.c
> > Index: linux/mm/vmalloc.c
> > Index: linux/mm/vmstat.c
> > Index: linux/net/core/dev.c
> > Index: linux/net/core/drop_monitor.c
> > Index: linux/net/core/skbuff.c
> > Index: linux/net/ipv4/tcp_output.c
> > Index: linux/net/rds/ib_rdma.c
> > Index: linux/kernel/timer.c
> > Index: linux/kernel/trace/trace.c
>
> This patch needs to be broken up per subsystem. Or are you just looking
> for acks from all the maintainers here and you'll pull it in. If that's
> the case, you should have Cc'd each of the maintainers of the files that
> this touches.

I did a breakout by arch, then core and drivers. How fine grained do you
want them? This touches a significant portion of the kernel source.
There could be quite a number of maintainers involved.
