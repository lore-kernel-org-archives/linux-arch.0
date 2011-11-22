From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 0/2] Stop some of the abuse of BUG() where compile time checks should be used.
Date: Mon, 21 Nov 2011 17:31:04 -0800
Message-ID: <1321925466-11280-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ralf@linux-mips.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-arch.vger.kernel.org

From: David Daney <david.daney@cavium.com>

After some, perhaps justified, reluctance to merge dummy symbol
definitions  containing BUG() into header files, I propose these patches
instead.

We define a new compile time assertion BUILD_BUG_ON_USED() that can be
used in places were we expect the compiler's dead code elimination to
get rid of code.  This happens mostly in code dealing with huge pages,
but in other places as well.

The first patch adds BUILD_BUG_ON_USED(), the second gets rid of one
of the main abusers of BUG().

David Daney (2):
  kernel.h: Add BUILD_BUG_ON_USED() macro.
  hugetlb: Replace BUG() with BUILD_BUG_ON_USED() for dummy
    definitions.

 include/linux/compiler-gcc4.h |    1 +
 include/linux/compiler.h      |    4 +++-
 include/linux/hugetlb.h       |   15 ++++++++-------
 include/linux/kernel.h        |   16 ++++++++++++++++
 4 files changed, 28 insertions(+), 8 deletions(-)

-- 
1.7.2.3
