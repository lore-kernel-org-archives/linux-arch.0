From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/5] preempt_count rework
Date: Wed, 14 Aug 2013 18:55:05 +0200
Message-ID: <20130814165505.GB21191@laptop.programming.kicks-ass.net>
References: <20130814131539.790947874@chello.nl>
 <20130814164827.GN23412@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:60338 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951Ab3HNQzM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2013 12:55:12 -0400
Content-Disposition: inline
In-Reply-To: <20130814164827.GN23412@tassilo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Aug 14, 2013 at 09:48:27AM -0700, Andi Kleen wrote:

> FWIW I removed the user_schedule in v2 because I don't need it anymore.
> Feel free to pick it up from v1 though.

Ah, I had a quick look through your v2 because I got a link into it from
Ingo but didn't find it. I'll have to ask Google to locate this v1. I
suppose that's what's wrong with my last patch. It directly does a call
preempt_schedule -- which I had hoped would work due to its asmlinkage,
but apparently there's more to it.

Also, I suppose there's a few volatile thingies missing.
