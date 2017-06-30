Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:34081 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdF3AGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 20:06:22 -0400
MIME-Version: 1.0
In-Reply-To: <1498780894-8253-25-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com> <1498780894-8253-25-git-send-email-paulmck@linux.vnet.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Jun 2017 17:06:16 -0700
Message-ID: <CA+55aFxf=4+LEk6wSE3HPFdwSf_F0Ny9NRGXaA6daikY+TGbDg@mail.gmail.com>
Subject: Re: [PATCH RFC 25/26] tile: Remove spin_unlock_wait() arch-specific definitions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20170630000616.YPLCGiHLXeNCfO-sehOBaYUQgTWTtQxXL8Zi0HuVHbQ@z>

On Thu, Jun 29, 2017 at 5:01 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> There is no agreed-upon definition of spin_unlock_wait()'s semantics,
> and it appears that all callers could do just as well with a lock/unlock
> pair.  This commit therefore removes the underlying arch-specific
> arch_spin_unlock_wait().

Please don't make this one commit fopr every architecture.

Once something gets removed, it gets removed. There's no point in
"remove it from architecture X". If there are no more users, we're
done with it, and making it be 25 patches with the same commit message
instead of just one doesn't help anybody.

               Linus
