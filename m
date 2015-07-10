From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][PATCH 02/24] arc: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 04:30:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665AD246@IN01WEMBXB.internal.synopsys.com>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.217482496@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53738 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbGJEa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 00:30:56 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "rth@twiddle.net" <rth@twiddle.net>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "will.deacon@arm.com" <will.deacon@arm.com>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>, "mingo@kernel.org" <mingo@kernel.org>

On Thursday 09 July 2015 11:26 PM, Peter Zijlstra wrote:
> Implement atomic logic ops -- atomic_{or,xor,and}.
>
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Since we are on the topic, the cmpxchg() loop in arch/arc/kernel/smp.c still
irritates me.
Do we need a new set of primitives to operate atomically on non atomic_t data or
does that mean that the data *not* being atomic_t but requiring such semantics is
the fundamental problem and thus needs to be converted first.

-Vineet
