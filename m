Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36280 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCWtn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2017 18:49:43 -0400
MIME-Version: 1.0
In-Reply-To: <20170703223011.GI2393@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com> <1498780894-8253-8-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170630091928.GC9726@arm.com> <20170630123815.GT2393@linux.vnet.ibm.com>
 <20170630131339.GA14118@arm.com> <20170630221840.GI2393@linux.vnet.ibm.com>
 <20170703131514.GE1573@arm.com> <20170703161851.GY2393@linux.vnet.ibm.com>
 <CA+55aFzA+dk8P-wWFX_rYE09A-3uCL8_7ZNG4jC1+c0x4COQkQ@mail.gmail.com>
 <20170703171338.GG1573@arm.com> <20170703223011.GI2393@linux.vnet.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jul 2017 15:49:42 -0700
Message-ID: <CA+55aFy4QPFypce_N0jC-QjhTU9GKZ2i11HewKKOfo0hCHn7Sw@mail.gmail.com>
Subject: Re: [PATCH RFC 08/26] locking: Remove spin_unlock_wait() generic definitions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>
Message-ID: <20170703224942.HwzWbQBb7EsGE3QhpYKRjl94r2DMoxCwMN0NxsMADSs@z>

On Mon, Jul 3, 2017 at 3:30 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> That certainly is one interesting function, isn't it?  I wonder what
> happens if you replace the raw_spin_is_locked() calls with an
> unlock under a trylock check?  ;-)

Deadlock due to interrupts again?

Didn't your spin_unlock_wait() patches teach you anything? Checking
state is fundamentally different from taking the lock. Even a trylock.

I guess you could try with the irqsave versions. But no, we're not doing that.

                Linus
