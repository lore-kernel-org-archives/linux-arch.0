Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38674 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755888AbdJJOIQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Oct 2017 10:08:16 -0400
Date: Tue, 10 Oct 2017 07:08:13 -0700
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 05/15] percpu: READ_ONCE() now implies
 smp_read_barrier_depends()
Message-ID: <20171010140813.GK3301751@devbig577.frc2.facebook.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Christoph Lameter <cl@linux.com>
Message-ID: <20171010140813.3RcxTAI9-QYXAAwBIFKTGgEmi9xfwAkK4jos7BaQei0@z>

On Mon, Oct 09, 2017 at 05:22:39PM -0700, Paul E. McKenney wrote:
> Because READ_ONCE() now implies smp_read_barrier_depends(), this commit
> removes the now-redundant smp_read_barrier_depends() following the
> READ_ONCE() in __ref_is_percpu().
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route with other patches.  If this should be
routed through the percpu tree, please let me know.

Thanks.

-- 
tejun
