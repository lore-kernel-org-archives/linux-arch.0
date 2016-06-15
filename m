Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38149 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbcFORlG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2016 13:41:06 -0400
Date: Wed, 15 Jun 2016 19:40:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH-tip v2 4/6] locking/rwsem: move down
 rwsem_down_read_failed function
Message-ID: <20160615174055.GS30921@twins.programming.kicks-ass.net>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-5-git-send-email-Waiman.Long@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465944489-43440-5-git-send-email-Waiman.Long@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160615174055.T75_mu7TIsF8ijncDqHJl3afmXmRJ5u-5w2ST-tomFc@z>

On Tue, Jun 14, 2016 at 06:48:07PM -0400, Waiman Long wrote:
> Move the rwsem_down_read_failed() function down to below the optimistic
> spinning section before enabling optimistic spinning for the readers.

newline

> There is no change in code.

Changelog fails to explain the why part.
