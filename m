From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 6/9] locking/qrwlock: allow architectures to hook in to
 contended paths
Date: Wed, 8 Jul 2015 14:35:12 +0100
Message-ID: <20150708133512.GD9283@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-7-git-send-email-will.deacon@arm.com>
 <20150708100657.GD3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41116 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758225AbbGHNfP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jul 2015 09:35:15 -0400
Content-Disposition: inline
In-Reply-To: <20150708100657.GD3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "mingo@redhat.com" <mingo@redhat.com>

On Wed, Jul 08, 2015 at 11:06:57AM +0100, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 06:24:22PM +0100, Will Deacon wrote:
> > When contended, architectures may be able to reduce the polling overhead
> > in ways which aren't expressible using a simple relax() primitive.
> > 
> > This patch allows architectures to override the use of
> > cpu_relax_lowlatency() in the qrwlock code and also implement their own
> > unlock macros in case explicit signalling is required to wake up a
> > `relaxed' CPU spinning on an unlock event.
> 
> No real objection, but could you do this _after_ you've converted
> AARGH64 to use the normal qrwlock, such that you can show the benefit
> with numbers?

Sure, although the biggest gain may be in the form of reduced power
consumption, which I can't easily measure on my development platform.

Will
