From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL v2] timers updates for 3.15
Date: Fri, 14 Mar 2014 09:36:52 +0100
Message-ID: <20140314083652.GA22913@gmail.com>
References: <1394642174-14315-1-git-send-email-fweisbec@gmail.com>
 <20140313110510.GA10424@gmail.com>
 <20140313153301.GA25296@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:53057 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477AbaCNIg4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Mar 2014 04:36:56 -0400
Content-Disposition: inline
In-Reply-To: <20140313153301.GA25296@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Archs <linux-arch@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@redhat.com>, Huiqingding <huding@redhat.com>


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> So I propose you something even more simple. The choice of 
> tip:timers/core as a base was actually just about topic. But there 
> is no dependency on it. (And actually sched/core would have been a 
> better choice for a base if any).
> 
> So in order to fix the conflict and minimize the dependencies, I 
> just rebased the patches on top of tip:core/locking only. No merge 
> on top of that. It seems to work pretty well.
> 
> The pullable result is in sched/cputime on my tree. Let me know if 
> that's ok for you.

Yeah, that sounds excellent. Thomas, you might want to keep this in a 
sparate branch from timers/core though. We still have timers/nohz for 
example.

Thanks,

	Ingo
