From: Paul Jackson <pj@sgi.com>
Subject: Re: [RFC/PATCH] Make for_each_node_mask out-of-line
Date: Sun, 11 May 2008 16:01:04 -0500
Message-ID: <20080511160104.c3fef6bf.pj@sgi.com>
References: <20080511135039.GA3286@mailshack.com>
	<20080511091403.a75f5b78.pj@sgi.com>
	<20080511160658.GA3398@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:56288 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753062AbYEKVBH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 11 May 2008 17:01:07 -0400
In-Reply-To: <20080511160658.GA3398@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: travis@sgi.com, akpm@linux-foundation.org, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, heukelum@fastmail.fm

Alexander wrote:
> Sure. This patch introduces lib/nodemask.c, but I'm not quite sure
> if building it should depend on CONFIG_SMP or something else (NUMA?).
> When is MAX_NUMNODES 1?

Well ... I'm pretty sure it made sense to depend on SMP, back when
it was first added.  However that might have changed.  I recall
vaguely that there has been discussion of this CONFIG_SMP dependency
every year or so, but I don't have the time right now to dig through
the archives and code to figure it out.

So ... offhand ... good questions, but I don't have answers.


> I'ld be happy to take a stab at aligning the cpumask and nodemask
> code even more by uninlining some more functions and using stubs
> for the MAX_NUMNODES=1 case.

That could be good ... though could you co-ordinate with Mike Travis
first, to minimize the risks of merge conflicts with what he's doing?

You kernel text space saving in the first patch seemed worth going
ahead with even if it did conflict a little, and I liked the matching
nodemask patch, just to keep things in sync.  Other nodemask cleanup
is a little lower priority in my book, so should make a modest effort
to co-ordinate with more critical patches, to minimize conflict.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.940.382.4214
