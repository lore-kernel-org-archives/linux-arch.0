From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH -v2 00/33] implement atomic_fetch_$op
Date: Thu, 2 Jun 2016 09:27:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EAF393@us01wembx1.internal.synopsys.com>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:39351 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcFBJ1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2016 05:27:51 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "dalias@libc.org" <dalias@libc.org>, "davem@davemloft.net" <davem@davemloft.net>, cmetcalf@mellanox

On Tuesday 31 May 2016 03:59 PM, Peter Zijlstra wrote:
> Notes:
>  - arc asm/atomic.h is a bit of a mess after the eznps merge, I would
>    recommend a restructure or split of that file, but could not find
>    the will to do it.
>  - arc, metag and tile could convert to _relaxed.

Yes that was bothering me too. The split is indeed in order. However good news is
even w/o it I have decent cleanup as all the backoff retry code can now be
removed. The hardware guys did their foo and production RTL with latest h/w
release doesn't suffer from the scond livelock problem. I'd disabled the config
option for some time and now the code can be removed as well.

What's ur merge plan - are u going to rebase/respin once more so I can push those
updates to Linus for 4.7-rc2. Or you could carry those ARC patches in ur tree -
ahead of ur series. I'd much rather prefer the revert / cleanup before adding new
code which extends the back off code only to be deleted later.

What say you ?

-Vineet
