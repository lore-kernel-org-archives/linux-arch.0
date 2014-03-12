From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/7] locking: qspinlock
Date: Tue, 11 Mar 2014 23:11:59 -0400
Message-ID: <20140311231159.25a0d8dc@gandalf.local.home>
References: <20140310154236.038181843@infradead.org>
	<20140312023153.GW13647@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:5227 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751609AbaCLDMD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Mar 2014 23:12:03 -0400
In-Reply-To: <20140312023153.GW13647@dastard>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Waiman Long <waiman.long@hp.com>, arnd@arndb.de, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, walken@google.com, andi@firstfloor.org, riel@redhat.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, oleg@redhat.com

On Wed, 12 Mar 2014 13:31:53 +1100
Dave Chinner <david@fromorbit.com> wrote:


> So either this patchset doesn't work right now, or there's something
> else broken in the tip/master tree...

I've found a few things broken with the tip master tree. Anyway, I'm
not sure the patches are even there. The last I saw, the patches are
still in RFC stage. Might want to take a known working kernel and apply
the patches manually.

-- Steve
