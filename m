Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3OHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jan 2019 09:07:25 -0500
Date: Wed, 30 Jan 2019 15:07:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/4] locking/qspinlock: Handle > 4 nesting levels
Message-ID: <20190130140707.GC2296@hirez.programming.kicks-ass.net>
References: <1548798828-16156-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548798828-16156-1-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
Message-ID: <20190130140707.ovaJlkiaHOEYHNgt1BAHrgEmuBwnpI1rvCTzCiIl2CU@z>

> Waiman Long (4):
>   locking/qspinlock: Handle > 4 slowpath nesting levels
>   locking/qspinlock_stat: Track the no MCS node available case

I've taken these two,

>   locking/qspinlock_stat: Introduce a generic lockevent counting APIs
>   locking/lock_events: Make lock_events available for all archs & other
>     locks

while no real objection to these; I feel we should wait until there are
in fact more users of this.
