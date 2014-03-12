From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/7] locking: qspinlock
Date: Wed, 12 Mar 2014 06:07:30 -0400
Message-ID: <20140312060730.435122f0@gandalf.local.home>
References: <20140310154236.038181843@infradead.org>
	<20140312023153.GW13647@dastard>
	<20140311231159.25a0d8dc@gandalf.local.home>
	<20140312042616.GX13647@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:51975 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750967AbaCLKHc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Mar 2014 06:07:32 -0400
In-Reply-To: <20140312042616.GX13647@dastard>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Waiman Long <waiman.long@hp.com>, arnd@arndb.de, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, walken@google.com, andi@firstfloor.org, riel@redhat.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, oleg@redhat.com

On Wed, 12 Mar 2014 15:26:16 +1100
Dave Chinner <david@fromorbit.com> wrote:


> I did apply them manually - but the patchset is based on the
> tip/master, plus some patches from a previous patch set that aren't
> in tip/locking to be able to apply this patchset cleanly in the
> first place. So there's no "start froma known working kernel" case
> that applies here :/

Peter,

Which kernel should we start testing your code against?

Thanks,

-- Steve
