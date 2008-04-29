From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/10] Add generic helpers for arch IPI function calls #3
Date: Tue, 29 Apr 2008 09:26:20 +0200
Message-ID: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy-TSDbQ3PG+2Y@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org

Hi,

This is a repost of the generic-ipi block git branch. It contains
generic helpers for issuing and handling IPI function calls. It
improves smp_call_function_single() so that it is now a scalable
interface that doesn't rely on call_lock and it also greatly
speeds up smp_call_function(). Microbenchmarks show that it is about
30% faster on call throughput on a simple 2-way SMP system. Benefits
should be much higher on bigger systems.

Changes since last post:

- Address Andrew's review comments
- Address Paul's RCU comments. Hopefully everything is covered now,
  I'd much appreciate a second look at this code Paul!
- Drop s390 support, as it currently relies on smp_call_function()
  not returning before other CPUs are ready (or have) called the passed
  in function.
- Address the x86/xen comments from Jeremy, I hope xen works as expected
  now.
- Address the review comments from Peter.
- Various other little things and improvements.

-- 
Jens Axboe
