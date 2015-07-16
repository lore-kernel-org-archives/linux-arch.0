From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Fri, 17 Jul 2015 08:54:25 +1000
Message-ID: <1437087265.28088.53.camel@kernel.crashing.org>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <1436826689.3948.233.camel@kernel.crashing.org>
	 <1436929578.10956.3.camel@ellerman.id.au> <20150715104420.GD1005@arm.com>
	 <1437012028.28475.2.camel@ellerman.id.au>
	 <1437023004.28088.27.camel@kernel.crashing.org>
	 <1437023695.28088.29.camel@kernel.crashing.org>
	 <20150716151142.GR3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58977 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910AbbGPWzD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jul 2015 18:55:03 -0400
In-Reply-To: <20150716151142.GR3717@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Thu, 2015-07-16 at 08:11 -0700, Paul E. McKenney wrote:
> > So isync in lock in architecturally incorrect, despite being what
> the
> > architecture recommends using, yay !
> 
> Well, the architecture isn't expecting that crazies like myself would
> want to have an unlock-lock provide ordering to some CPU not holding
> the lock.  :-/

Yes, isync in lock effectively allows any load or store before the lock
to leak into the lock and get re-ordered with things in there.

lwsync leaves us exposed to the re-order inside the LL/SC of a
subsequent load.

So to get the full barrier semantic, the only option is a full sync,
either in lock or unlock. Instinctively I prefer in lock but there's
an argument to have it in unlock so we can get rid of the iosync
business.

Ben.
