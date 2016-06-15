Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38424 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcFOV7Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2016 17:59:25 -0400
Date: Wed, 15 Jun 2016 23:59:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper
 acquire/release barrier
Message-ID: <20160615215918.GY30921@twins.programming.kicks-ass.net>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com>
 <20160615165659.GC2094@linux-80c1.suse>
 <20160615171250.GO30921@twins.programming.kicks-ass.net>
 <5761A7C0.6000709@hpe.com>
 <5761B4B7.3070102@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5761B4B7.3070102@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hpe.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160615215918.63r_vdNUiYTl6cNhp_iXXNIuseO7C-o21ps76oRCnok@z>

On Wed, Jun 15, 2016 at 04:04:07PM -0400, Waiman Long wrote:
> 
> BTW, when will the smp_acquire__after_ctrl_dep() patch goes into the tip
> tree? My patch will have a dependency on that when I make the change.

Should already be in as part of that spin_unlock_wait() fixup.

/me checks..

tip/locking/core contains:

33ac279677dc ("locking/barriers: Introduce smp_acquire__after_ctrl_dep()")
