From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 00/15] Provide atomics and bitops implemented with
 ISO C++11 atomics
Date: Wed, 18 May 2016 20:05:58 +0200
Message-ID: <20160518180558.GI3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43327 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbcERSGI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 14:06:08 -0400
Content-Disposition: inline
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wed, May 18, 2016 at 04:10:37PM +0100, David Howells wrote:
>  (1) We could weaken the kernel memory model to for the benefit of arches
>      that have instructions that employ explicit acquire/release barriers -
>      but that may cause data races to occur based on assumptions we've
>      already made.  Note, however, that powerpc already seems to have a
>      weaker memory model.

Linus always vehemently argues against weakening our memory model.
