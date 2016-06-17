Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43108 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbcFQBML (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jun 2016 21:12:11 -0400
Date: Thu, 16 Jun 2016 18:11:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper
 acquire/release barrier
Message-ID: <20160617011155.GA14591@linux-80c1.suse>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com>
 <20160615165659.GC2094@linux-80c1.suse>
 <20160615171250.GO30921@twins.programming.kicks-ass.net>
 <20160615182724.GD2094@linux-80c1.suse>
 <20160615184007.GW30921@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20160615184007.GW30921@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hpe.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160617011155.xcCftBygBiMxU3N8swKDBI8S-8dlcGspQeU5N5JxAAU@z>

On Wed, 15 Jun 2016, Peter Zijlstra wrote:

>Yeah, see a few patches further in this series, where he guards a
>variables with the osq_lock.

So one problem I have with all this is that if we are hardening osq_lock/unlock()
because of some future use that is specific to rwsems, then we will immediately
be hurting mutexes for no good reason.

Thanks,
Davidlohr
