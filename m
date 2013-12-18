From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 2/4] arch: Move smp_mb__{before,after}_atomic_{inc,dec}.h
 into asm/atomic.h
Date: Wed, 18 Dec 2013 19:10:12 +0530
Message-ID: <52B1A5BC.1010607@synopsys.com>
References: <20131213145657.265414969@infradead.org> <20131213150640.786183683@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-relay.synopsys.com ([198.182.60.77]:56707 "EHLO
	smtp-relay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3LRNkk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2013 08:40:40 -0500
In-Reply-To: <20131213150640.786183683@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org
Cc: geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

On 12/13/2013 08:26 PM, Peter Zijlstra wrote:
> Move the barriers functions that depend on the atomic implementation
> into the atomic implementation.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/arc/include/asm/atomic.h      |    5 +++++
>  arch/arc/include/asm/barrier.h     |    5 -----
>  arch/hexagon/include/asm/atomic.h  |    6 +++++-
>  arch/hexagon/include/asm/barrier.h |    4 ----
>  4 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Vineet Gupta <vgupta@synopsys.com> [for arch/arc bits]

Thx,
-Vineet
