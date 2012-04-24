From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 0/3] gcc work-around and math128
Date: Tue, 24 Apr 2012 18:10:39 +0200
Message-ID: <20120424161039.293018424@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57101 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab2DXQZf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 12:25:35 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>

Hi all,

The SCHED_DEADLINE review resulted in the following three patches;

The first is a cleanup of various copies of the same GCC loop optimization
work-around. I don't think this patch is too controversial, at worst I've
picked a wrong name, but I wanted to get it out there in case people
know more sites.

The second two implement a few u128 operations so we can do 128bit math.. I
know a few people will die a little inside, but having nanosecond granularity
time accounting leads to very big numbers very quickly and when you need to
multiply them 64bit really isn't that much.

So far its just mult, add and cmp for u128, no divisions quite yet. I realize
that on 32bit archs mult_u128 will result in like 8 multiplication
instructions that's still nowhere near the most expensive thing ever.

Also, I suck at gcc inline asm, so patch 3/3 is very likely completely wrong,
in any case none of the patches has even been near a compiler and this really
is just an RFC to probe if we want to go here at all.
