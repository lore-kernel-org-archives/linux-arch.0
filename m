Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37955 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbdHKRMs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2017 13:12:48 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6 4/7] mm: refactoring TLB gathering API
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20170811092334.rmeazkklvordrmrl@hirez.programming.kicks-ass.net>
Date: Fri, 11 Aug 2017 10:12:45 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <EBBFF419-4E4C-440A-853B-25FB6F0DE7F6@gmail.com>
References: <20170802000818.4760-1-namit@vmware.com>
 <20170802000818.4760-5-namit@vmware.com>
 <20170811092334.rmeazkklvordrmrl@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>
Message-ID: <20170811171245.37SM5DdLJTwTuqUMFyKUbZ6CUGR5ABNxvwiH8tUV_iA@z>

Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Aug 01, 2017 at 05:08:15PM -0700, Nadav Amit wrote:
>> From: Minchan Kim <minchan@kernel.org>
>>=20
>> This patch is a preparatory patch for solving race problems caused by
>> TLB batch.  For that, we will increase/decrease TLB flush pending =
count
>> of mm_struct whenever tlb_[gather|finish]_mmu is called.
>>=20
>> Before making it simple, this patch separates architecture specific
>> part and rename it to arch_tlb_[gather|finish]_mmu and generic part
>> just calls it.
>=20
> I absolutely hate this. We should unify this stuff, not diverge it
> further.

Agreed, but I don=E2=80=99t see how this patch makes the situation any =
worse.

I=E2=80=99ll review your other comments by tomorrow due to some personal
constraints.
