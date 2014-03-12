From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC][PATCH 0/7] locking: qspinlock
Date: Wed, 12 Mar 2014 15:26:16 +1100
Message-ID: <20140312042616.GX13647@dastard>
References: <20140310154236.038181843@infradead.org>
 <20140312023153.GW13647@dastard>
 <20140311231159.25a0d8dc@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:60463 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306AbaCLE0V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Mar 2014 00:26:21 -0400
Content-Disposition: inline
In-Reply-To: <20140311231159.25a0d8dc@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Waiman Long <waiman.long@hp.com>, arnd@arndb.de, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, walken@google.com, andi@firstfloor.org, riel@redhat.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, oleg@redhat.com

On Tue, Mar 11, 2014 at 11:11:59PM -0400, Steven Rostedt wrote:
> On Wed, 12 Mar 2014 13:31:53 +1100
> Dave Chinner <david@fromorbit.com> wrote:
> 
> 
> > So either this patchset doesn't work right now, or there's something
> > else broken in the tip/master tree...
> 
> I've found a few things broken with the tip master tree. Anyway, I'm
> not sure the patches are even there. The last I saw, the patches are
> still in RFC stage. Might want to take a known working kernel and apply
> the patches manually.

I did apply them manually - but the patchset is based on the
tip/master, plus some patches from a previous patch set that aren't
in tip/locking to be able to apply this patchset cleanly in the
first place. So there's no "start froma known working kernel" case
that applies here :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
