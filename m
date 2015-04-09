From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 16/16] unfair qspinlock: a queue based unfair lock
Date: Thu, 9 Apr 2015 09:01:46 +0200
Message-ID: <20150409070146.GL27490@worktop.programming.kicks-ass.net>
References: <1428517939-27968-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52372 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbDIHB5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2015 03:01:57 -0400
Content-Disposition: inline
In-Reply-To: <1428517939-27968-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Wed, Apr 08, 2015 at 02:32:19PM -0400, Waiman Long wrote:
> For a virtual guest with the qspinlock patch, a simple unfair byte lock
> will be used if PV spinlock is not configured in or the hypervisor
> isn't either KVM or Xen. The byte lock works fine with small guest
> of just a few vCPUs. On a much larger guest, however, byte lock can
> have serious performance problem.

Who cares?
