Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <424564D9.9010306@yahoo.com.au>
Date: Sun, 27 Mar 2005 00:34:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [patch][RFC] sched: optimise/cleanup resched_task, idle routines
References: <4245631A.1070806@yahoo.com.au>
In-Reply-To: <4245631A.1070806@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

Had this around for a while too. Quite a bit of arch work to get
through here, and I haven't done most of it (I probably butchered
ppc64, too).

It does seem to work OK on i386 and ia64, though. I'd like to get
confirmation that my approach is correct before putting more work
into it.

It can save locked memory ops and IPIs during scheduling operations.
I don't have access to any big systems that might most beneift from
the improved scalability, but it is worth a % or so on a dual Xeon
system here (on schedule happy workload).

But am I horribly misinformed? ;)
