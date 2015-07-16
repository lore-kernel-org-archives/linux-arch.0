From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 4/7] lockref: remove homebrew cmpxchg64_relaxed macro
 definition
Date: Thu, 16 Jul 2015 18:00:03 +0100
Message-ID: <20150716170003.GN26390@arm.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
 <1437060758-10381-5-git-send-email-will.deacon@arm.com>
 <20150716164803.GZ19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44959 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbbGPRAG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jul 2015 13:00:06 -0400
Content-Disposition: inline
In-Reply-To: <20150716164803.GZ19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Thu, Jul 16, 2015 at 05:48:03PM +0100, Peter Zijlstra wrote:
> On Thu, Jul 16, 2015 at 04:32:35PM +0100, Will Deacon wrote:
> > cmpxchg64_relaxed is now defined by asm-generic/atomic.h, so we can
> 
> linux/atomic.h

Whoops, thanks. Fixed.

Will
