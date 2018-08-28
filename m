From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] mm: dirty/accessed pte optimisations
Date: Tue, 28 Aug 2018 21:20:31 +1000
Message-ID: <20180828112034.30875-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Here are some patches that didn't get much comment last time. It
looks like x86 might benefit too though, so that might get people
interested. 

I improved changelogs and added some comments, but no real logic
changes.

I hope I didn't get the x86 numbers wrong, they're more significant
than I expected so it could quite well be a problem with my test
(corrections welcome). Any data from other archs would be interesting
too.

Andrew perhaps if there aren't objections these could go in mm for
a while. 

Thanks,
Nick


Nicholas Piggin (3):
  mm/cow: don't bother write protectig already write-protected huge
    pages
  mm/cow: optimise pte dirty/accessed bits handling in fork
  mm: optimise pte dirty/accessed bit setting by demand based pte
    insertion

 mm/huge_memory.c | 24 +++++++++++++++---------
 mm/memory.c      | 18 ++++++++++--------
 mm/vmscan.c      |  8 ++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.18.0
