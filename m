From: Russell King <rmk@arm.linux.org.uk>
Subject: [RFC:PATCH] Correct cpu_relax() documentation
Date: Tue, 9 Mar 2010 16:30:24 +0000
Message-ID: <20100309163024.GA17428@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Subject: Correct cpu_relax() documentation

cpu_relax() is documented in volatile-considered-harmful.txt to be a
memory barrier.  However, everyone with the exception of Blackfin and
possibly ia64 defines cpu_relax() to be a compiler barrier.

Make the documentation reflect the general concensus.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/volatile-considered-harmful.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/volatile-considered-harmful.txt b/Documentation/volatile-considered-harmful.txt
index 991c26a..db0cb22 100644
--- a/Documentation/volatile-considered-harmful.txt
+++ b/Documentation/volatile-considered-harmful.txt
@@ -63,9 +63,9 @@ way to perform a busy wait is:
         cpu_relax();
 
 The cpu_relax() call can lower CPU power consumption or yield to a
-hyperthreaded twin processor; it also happens to serve as a memory barrier,
-so, once again, volatile is unnecessary.  Of course, busy-waiting is
-generally an anti-social act to begin with.
+hyperthreaded twin processor; it also happens to serve as a compiler
+barrier, so, once again, volatile is unnecessary.  Of course, busy-
+waiting is generally an anti-social act to begin with.
 
 There are still a few rare situations where volatile makes sense in the
 kernel:


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
