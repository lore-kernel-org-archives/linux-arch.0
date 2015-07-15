From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH v2 3/3] sched/preempt: fix cond_resched_lock() and
 cond_resched_softirq()
Date: Wed, 15 Jul 2015 14:16:36 +0200
Message-ID: <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
References: <20150715095201.12246.49283.stgit@buzz>
	 <20150715095204.12246.98268.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37014 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbGOMQk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2015 08:16:40 -0400
In-Reply-To: <20150715095204.12246.98268.stgit@buzz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org

On Wed, 2015-07-15 at 12:52 +0300, Konstantin Khlebnikov wrote:
> These functions check should_resched() before unlocking spinlock/bh-enable:
> preempt_count always non-zero => should_resched() always returns false.
> cond_resched_lock() worked iff spin_needbreak is set.

Interesting, this definitely used to work (linux-3.11)

Any idea of which commit broke things ?
