From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 07/31] arch,arm64: Convert smp_mb__*
Date: Fri, 21 Mar 2014 11:54:47 +0000
Message-ID: <20140321115447.GB14251@arm.com>
References: <20140319064729.660482086@infradead.org>
 <20140319065204.150839038@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:39738 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752119AbaCULzM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Mar 2014 07:55:12 -0400
Content-Disposition: inline
In-Reply-To: <20140319065204.150839038@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com

On Wed, Mar 19, 2014 at 07:47:36AM +0100, Peter Zijlstra wrote:
> AARGH64 uses ll/sc primitives that do not imply any barriers for the
> normal atomics, therefore smp_mb__{before,after} should be a full
> barrier.
> 
> Since AARGH64 doesn't use asm-generic/barrier.h, add the required
> definitions to its asm/barrier.h.

There is a typo above ;)

Otherwise,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
