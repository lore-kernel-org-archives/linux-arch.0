From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
Date: Thu, 3 Mar 2016 16:11:52 +0000
Message-ID: <20160303161151.GA2074@e104818-lin.cambridge.arm.com>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
 <20160303120227.GA2484@gmail.com>
 <20160303123809.GA19139@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38195 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbcCCQL5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 Mar 2016 11:11:57 -0500
Content-Disposition: inline
In-Reply-To: <20160303123809.GA19139@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, akpm@linux-foundation.org, aryabinin@virtuozzo.com, linux-arch@vger.kernel.org, lorenzo.pieralisi@arm.com, peterz@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com, glider@google.com, linux-arm-kernel@lists.infradead.org

On Thu, Mar 03, 2016 at 12:38:09PM +0000, Mark Rutland wrote:
> On Thu, Mar 03, 2016 at 01:02:27PM +0100, Ingo Molnar wrote:
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > > Mark Rutland (3):
> > >   kasan: add functions to clear stack poison
> > >   sched/kasan: remove stale KASAN poison after hotplug
> > >   arm64: kasan: clear stale stack poison
> > > 
> > >  arch/arm64/kernel/sleep.S |  4 ++++
> > >  include/linux/kasan.h     |  6 +++++-
> > >  kernel/sched/core.c       |  3 +++
> > >  mm/kasan/kasan.c          | 20 ++++++++++++++++++++
> > >  4 files changed, 32 insertions(+), 1 deletion(-)
> > 
> > Looks good to me - via which tree would you like to see this merged upstream?
> 
> I'd prefer the arm64 tree as arm64 is (the most) affected by the issue
> in practice.
> 
> I'm happy for this to go via another tree if that's simpler; I'm not
> aware of anything that's likely to conflict in the arm64 tree.
> 
> Catalin, Andrey, Andrew, any preference?

I'm happy for this to go via the Andrew's -mm tree. For the series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Please report the series to linux-mm@kvack.org with the corresponding
acks in place and the fix-up on patch 1.

Thanks.

-- 
Catalin
