From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/7] lockref: remove homebrew cmpxchg64_relaxed macro
 definition
Date: Thu, 16 Jul 2015 18:48:03 +0200
Message-ID: <20150716164803.GZ19282@twins.programming.kicks-ass.net>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
 <1437060758-10381-5-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44031 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbbGPQsR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 12:48:17 -0400
Content-Disposition: inline
In-Reply-To: <1437060758-10381-5-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Waiman.Long@hp.com, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On Thu, Jul 16, 2015 at 04:32:35PM +0100, Will Deacon wrote:
> cmpxchg64_relaxed is now defined by asm-generic/atomic.h, so we can

linux/atomic.h
