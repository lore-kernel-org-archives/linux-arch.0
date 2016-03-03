From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
Date: Thu, 3 Mar 2016 17:30:17 +0300
Message-ID: <56D84A79.2030303@virtuozzo.com>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
 <20160303120227.GA2484@gmail.com> <20160303123809.GA19139@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.parallels.com ([199.115.105.18]:40500 "EHLO
	mx2.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbcCCOa1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Mar 2016 09:30:27 -0500
In-Reply-To: <20160303123809.GA19139@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, akpm@linux-foundation.org, catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, glider@google.com, lorenzo.pieralisi@arm.com, mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com

On 03/03/2016 03:38 PM, Mark Rutland wrote:
> On Thu, Mar 03, 2016 at 01:02:27PM +0100, Ingo Molnar wrote:
>>>
>>> Mark Rutland (3):
>>>   kasan: add functions to clear stack poison
>>>   sched/kasan: remove stale KASAN poison after hotplug
>>>   arm64: kasan: clear stale stack poison
>>>
>>>  arch/arm64/kernel/sleep.S |  4 ++++
>>>  include/linux/kasan.h     |  6 +++++-
>>>  kernel/sched/core.c       |  3 +++
>>>  mm/kasan/kasan.c          | 20 ++++++++++++++++++++
>>>  4 files changed, 32 insertions(+), 1 deletion(-)
>>
>> Looks good to me - via which tree would you like to see this merged upstream?
> 
> I'd prefer the arm64 tree as arm64 is (the most) affected by the issue
> in practice.
> 
> I'm happy for this to go via another tree if that's simpler; I'm not
> aware of anything that's likely to conflict in the arm64 tree.
> 
> Catalin, Andrey, Andrew, any preference?
> 

I don't have any. arm64 tree is fine by me.

For the patchset:

	Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
