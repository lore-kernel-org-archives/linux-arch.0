From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/2] locking/qrwlock: Better optimization for
 interrupt context readers
Date: Thu, 18 Jun 2015 13:41:10 +0100
Message-ID: <20150618124110.GC5168@arm.com>
References: <1434594023-43589-1-git-send-email-Waiman.Long@hp.com>
 <1434594023-43589-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42176 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbbFRMlO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Jun 2015 08:41:14 -0400
Content-Disposition: inline
In-Reply-To: <1434594023-43589-2-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Thu, Jun 18, 2015 at 03:20:22AM +0100, Waiman Long wrote:
> The qrwlock is fair in the process context, but becoming unfair when
> in the interrupt context to support use cases like the tasklist_lock.
> 
> The current code isn't that well-documented on what happens when
> in the interrupt context. The rspin_until_writer_unlock() will only
> spin if the writer has gotten the lock. If the writer is still in the
> waiting state, the increment in the reader count will cause the writer
> to remain in the waiting state and the new interrupt context reader
> will get the lock and return immediately. The current code, however,
> do an additional read of the lock value which is not necessary as
> the information have already been there in the fast path. This may
> sometime cause an additional cacheline transfer when the lock is
> highly contended.
> 
> This patch passes the lock value information gotten in the fast path
> to the slow path to eliminate the additional read. It also document
> the action for the interrupt context readers more clearly.
> 
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> ---
>  include/asm-generic/qrwlock.h |    4 ++--
>  kernel/locking/qrwlock.c      |   13 +++++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)

LGTM:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
