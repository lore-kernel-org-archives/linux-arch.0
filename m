Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeACXpg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 18:45:36 -0500
Date: Thu, 4 Jan 2018 00:45:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] bpf: inhibit speculated out-of-bounds pointers
Message-ID: <20180103234529.GA32035@hirez.programming.kicks-ass.net>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <20180103223827.39601-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103223827.39601-5-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Message-ID: <20180103234529.ft7Cu54ZbCU50JO8y9v-moK_89P-n8ByzPOBN6bgldA@z>

On Wed, Jan 03, 2018 at 10:38:27PM +0000, Mark Rutland wrote:
> Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> memory accesses under a bounds check may be speculated even if the
> bounds check fails, providing a primitive for building a side channel.
> 
> The EBPF map code has a number of such bounds-checks accesses in
> map_lookup_elem implementations. This patch modifies these to use the
> nospec helpers to inhibit such side channels.
> 
> The JITted lookup_elem implementations remain potentially vulnerable,
> and are disabled (with JITted code falling back to the C
> implementations).

Since this is now public, let me re-iterate that I don't particularly
like this approach. If you have to kill the JIT, could we please keep
that in the arch JIT implementation?
