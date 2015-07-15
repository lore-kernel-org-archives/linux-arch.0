From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH v2 3/3] sched/preempt: fix cond_resched_lock() and cond_resched_softirq()
Date: Wed, 15 Jul 2015 15:52:34 +0300
Message-ID: <55A65792.80903@yandex-team.ru>
References: <20150715095201.12246.49283.stgit@buzz>	 <20150715095204.12246.98268.stgit@buzz> <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from forward-corp1g.mail.yandex.net ([95.108.253.251]:45002 "EHLO
	forward-corp1g.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825AbbGOMwj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jul 2015 08:52:39 -0400
In-Reply-To: <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org

On 15.07.2015 15:16, Eric Dumazet wrote:
> On Wed, 2015-07-15 at 12:52 +0300, Konstantin Khlebnikov wrote:
>> These functions check should_resched() before unlocking spinlock/bh-enable:
>> preempt_count always non-zero => should_resched() always returns false.
>> cond_resched_lock() worked iff spin_needbreak is set.
>
> Interesting, this definitely used to work (linux-3.11)
>
> Any idea of which commit broke things ?
>

Searching... done

This one: bdb43806589096ac4272fe1307e789846ac08d7c in v3.13

before

-static inline int should_resched(void)
-{
-       return need_resched() && !(preempt_count() & PREEMPT_ACTIVE);
-}

after

+static __always_inline bool should_resched(void)
+{
+       return unlikely(!*preempt_count_ptr());
+}


So,

Fixes: bdb438065890 ("sched: Extract the basic add/sub preempt_count 
modifiers")

-- 
Konstantin
