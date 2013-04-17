From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 5/5] mutex: Move mutex spinning code from sched/core.c
 back to mutex.c
Date: Wed, 17 Apr 2013 09:18:27 +0200
Message-ID: <20130417071827.GB21051@gmail.com>
References: <1366172891-7729-1-git-send-email-Waiman.Long@hp.com>
 <1366172891-7729-6-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:33399 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3DQHSc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Apr 2013 03:18:32 -0400
Content-Disposition: inline
In-Reply-To: <1366172891-7729-6-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>


* Waiman Long <Waiman.Long@hp.com> wrote:

> As mentioned by Ingo, the SCHED_FEAT_OWNER_SPIN scheduler feature
> bit was really just an early hack to make with/without mutex-spinning
> testable. So it is no longer necessary.
> 
> This patch removes the SCHED_FEAT_OWNER_SPIN feature bit and move the
> mutex spinning code from kernel/sched/core.c back to kernel/mutex.c
> which is where they should belong.
> 
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> ---
>  include/linux/sched.h   |    4 ---
>  kernel/mutex.c          |   62 ++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c     |   63 -----------------------------------------------
>  kernel/sched/features.h |    7 -----
>  4 files changed, 62 insertions(+), 74 deletions(-)

Please move this patch first in the series - so that later, functional patches are 
easier to revert, should the need arise. When possible we sort patches by risk: 
low risk ones first, riskier come later.

Thanks,

	Ingo
