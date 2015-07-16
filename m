From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Thu, 16 Jul 2015 15:03:24 +1000
Message-ID: <1437023004.28088.27.camel@kernel.crashing.org>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <1436826689.3948.233.camel@kernel.crashing.org>
	 <1436929578.10956.3.camel@ellerman.id.au> <20150715104420.GD1005@arm.com>
	 <1437012028.28475.2.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54765 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbbGPFEJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jul 2015 01:04:09 -0400
In-Reply-To: <1437012028.28475.2.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>

On Thu, 2015-07-16 at 12:00 +1000, Michael Ellerman wrote:
> That would fix the problem with smp_mb__after_unlock_lock(), but not
> the original worry we had about loads happening before the SC in lock.

However I think isync fixes *that* :-) The problem with isync is as you
said, it's not a -memory- barrier per-se, it's an execution barrier /
context synchronizing instruction. The combination stwcx. + bne + isync
however prevents the execution of anything past the isync until the
stwcx has completed and the bne has been "decided", which prevents loads
from leaking into the LL/SC loop. It will also prevent a store in the
lock from being issued before the stwcx. has completed. It does *not*
prevent as far as I can tell another unrelated store before the lock
from leaking into the lock, including the one used to unlock a different
lock.

Cheers,
Ben.
