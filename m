From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
Date: Thu, 3 Mar 2016 14:49:27 +0000
Message-ID: <20160303144927.GD19139@leverpostej>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
 <20160303120227.GA2484@gmail.com>
 <20160303123809.GA19139@leverpostej>
 <56D84A79.2030303@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D84A79.2030303@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Ingo Molnar <mingo@kernel.org>, akpm@linux-foundation.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, glider@google.com, lorenzo.pieralisi@arm.com, mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 03, 2016 at 05:30:17PM +0300, Andrey Ryabinin wrote:
> On 03/03/2016 03:38 PM, Mark Rutland wrote:
> > On Thu, Mar 03, 2016 at 01:02:27PM +0100, Ingo Molnar wrote:
> >>>
> >>> Mark Rutland (3):
> >>>   kasan: add functions to clear stack poison
> >>>   sched/kasan: remove stale KASAN poison after hotplug
> >>>   arm64: kasan: clear stale stack poison
> >>>
> >>>  arch/arm64/kernel/sleep.S |  4 ++++
> >>>  include/linux/kasan.h     |  6 +++++-
> >>>  kernel/sched/core.c       |  3 +++
> >>>  mm/kasan/kasan.c          | 20 ++++++++++++++++++++
> >>>  4 files changed, 32 insertions(+), 1 deletion(-)
> >>
> >> Looks good to me - via which tree would you like to see this merged upstream?
> > 
> > I'd prefer the arm64 tree as arm64 is (the most) affected by the issue
> > in practice.
> > 
> > I'm happy for this to go via another tree if that's simpler; I'm not
> > aware of anything that's likely to conflict in the arm64 tree.
> > 
> > Catalin, Andrey, Andrew, any preference?
> > 
> 
> I don't have any. arm64 tree is fine by me.
> 
> For the patchset:
> 
> 	Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 

Cheers!

Following [1], I intend to change patch 1 to start at task_stack_page(t)
rather than task_thread_info(task) + 1, to keep things simple.

I assume that your Reviewed-by would still apply in that case?

Thanks,
Mark.

[1] https://lkml.org/lkml/2016/3/2/428
