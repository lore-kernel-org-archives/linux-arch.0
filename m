From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 04/20] arch,arm: Fold atomic_ops
Date: Thu, 8 May 2014 19:31:16 +0100
Message-ID: <20140508183116.GJ8981@arm.com>
References: <20140508135840.956784204@infradead.org>
 <20140508135851.939725247@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49457 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754738AbaEHSbz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 May 2014 14:31:55 -0400
Content-Disposition: inline
In-Reply-To: <20140508135851.939725247@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Albin Tonnerre <Albin.Tonnerre@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Chen Gang <gang.chen@asianux.com>, Nicolas Pitre <nico@linaro.org>, Russell King <linux@arm.linux.org.uk>, Victor Kamensky <victor.kamensky@linaro.org>

On Thu, May 08, 2014 at 02:58:44PM +0100, Peter Zijlstra wrote:
> Many of the atomic op implementations are the same except for one
> instruction; fold the lot into a few CPP macros and reduce LoC.
> 
> This also prepares for easy addition of new ops.
> 
> Requires the asm_op because of eor.
> 
> Cc: Albin Tonnerre <albin.tonnerre@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Gang <gang.chen@asianux.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Victor Kamensky <victor.kamensky@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/arm/include/asm/atomic.h |  313 +++++++++++++++++-------------------------
>  1 file changed, 127 insertions(+), 186 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
