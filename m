Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:38316 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754612AbaCLQTg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Mar 2014 12:19:36 -0400
Date: Wed, 12 Mar 2014 12:19:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/7] locking: qspinlock
Message-ID: <20140312121933.40f63087@gandalf.local.home>
In-Reply-To: <20140312155754.GG27965@twins.programming.kicks-ass.net>
References: <20140310154236.038181843@infradead.org>
	<20140312023153.GW13647@dastard>
	<20140311231159.25a0d8dc@gandalf.local.home>
	<20140312042616.GX13647@dastard>
	<20140312060730.435122f0@gandalf.local.home>
	<20140312155754.GG27965@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Waiman Long <waiman.long@hp.com>, arnd@arndb.de, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, walken@google.com, andi@firstfloor.org, riel@redhat.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, oleg@redhat.com
Message-ID: <20140312161933.ObPxdr6Qmy7YijJo8JlsrTRlG9S3zaRdtbLUhllL36Y@z>

On Wed, 12 Mar 2014 16:57:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:


> I build and booted these patches against tip/master as of this morning.
> It build ~50 defconfig kernels on my WSM-EP.
> 
> I've not managed to reproduce the hang as reported by Dave, but then I
> doubt building kernels has anywhere near the lock contention he
> generated.
> 

Have you tried hackbench? That usually gives rq spinlocks a bit of
contention.

-- Steve
