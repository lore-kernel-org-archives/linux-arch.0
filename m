From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 09/19] net: average: Kill off ACCESS_ONCE()
Date: Tue, 24 Oct 2017 07:58:11 +0200
Message-ID: <1508824691.2639.26.camel@sipsolutions.net>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
         <1508792849-3115-9-git-send-email-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508792849-3115-9-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "snitzer@redhat.com" <snitzer@redhat.com>, "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>, "shuah@kernel.org" <shuah@kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "tj@kernel.org" <tj@kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 2017-10-23 at 21:07 +0000, Paul E. McKenney wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
> preference to ACCESS_ONCE(), and new code is expected to use one of the
> former. So far, there's been no reason to change most existing uses of
> ACCESS_ONCE(), as these aren't currently harmful.
> 
> However, for some features it is necessary to instrument reads and
> writes separately, which is not possible with ACCESS_ONCE(). This
> distinction is critical to correct operation.
> 
> It's possible to transform the bulk of kernel code using the Coccinelle
> script below. However, this doesn't pick up some uses, including those
> in <linux/average.h>. As a preparatory step, this patch converts the
> file to use {READ,WRITE}_ONCE() consistently.
> 
> At the same time, this patch addds missing includes necessary for
> {READ,WRITE}_ONCE(), *BUG_ON*(), and ilog2().
> 
> ----
> virtual patch
> 
> @ depends on patch @
> expression E1, E2;
> @@
> 
> - ACCESS_ONCE(E1) = E2
> + WRITE_ONCE(E1, E2)
> 
> @ depends on patch @
> expression E;
> @@
> 
> - ACCESS_ONCE(E)
> + READ_ONCE(E)
> ----
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Let me know if you want me to apply this, since I seem to be the
average.h maintainer :-)

johannes
