From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 05/20] arch,arm64: Fold atomic_ops
Date: Thu, 8 May 2014 19:31:42 +0100
Message-ID: <20140508183142.GK8981@arm.com>
References: <20140508135840.956784204@infradead.org>
 <20140508135851.995123148@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49475 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840AbaEHScW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 May 2014 14:32:22 -0400
Content-Disposition: inline
In-Reply-To: <20140508135851.995123148@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Chen Gang <gang.chen@asianux.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On Thu, May 08, 2014 at 02:58:45PM +0100, Peter Zijlstra wrote:
> Many of the atomic op implementations are the same except for one
> instruction; fold the lot into a few CPP macros and reduce LoC.
> 
> This also prepares for easy addition of new ops.
> 
> Requires the asm_op due to eor.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Gang <gang.chen@asianux.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/atomic.h |  213 ++++++++++++++++------------------------
>  1 file changed, 88 insertions(+), 125 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
