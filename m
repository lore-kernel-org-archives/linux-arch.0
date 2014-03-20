Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:46867 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424AbaCTLTk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Mar 2014 07:19:40 -0400
Date: Thu, 20 Mar 2014 12:11:47 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 11/31] arch,cris: Convert smp_mb__*
Message-ID: <20140320111147.GX25718@axis.com>
References: <20140319064729.660482086@infradead.org>
 <20140319065204.369517899@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140319065204.369517899@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com
Message-ID: <20140320111147._vteEwkzhs1sjbO3IcDS949zduQjrbCDvJDX47phOwk@z>

On Wed, Mar 19, 2014 at 07:47:40AM +0100, Peter Zijlstra wrote:
> Cris fully relies on asm-generic/barrier.h, therefore its smp_mb() is
> barrier(), thus we can use the default implementation that uses
> smp_mb().

For the CRIS parts:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Peter Zijlstra <peterz@infradead.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
