From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 01/34] Documentation/memory-barriers.txt: document __smb_mb()
Date: Wed, 30 Dec 2015 15:24:16 +0200
Message-ID: <1451473761-30019-2-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45607 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbbL3NYU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:24:20 -0500
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/memory-barriers.txt | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index aef9487..a20f7ef 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1655,17 +1655,18 @@ macro is a good place to start looking.
 SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
 systems because it is assumed that a CPU will appear to be self-consistent,
 and will order overlapping accesses correctly with respect to itself.
+However, see the subsection on "Virtual Machine Guests" below.
 
 [!] Note that SMP memory barriers _must_ be used to control the ordering of
 references to shared memory on SMP systems, though the use of locking instead
 is sufficient.
 
 Mandatory barriers should not be used to control SMP effects, since mandatory
-barriers unnecessarily impose overhead on UP systems. They may, however, be
-used to control MMIO effects on accesses through relaxed memory I/O windows.
-These are required even on non-SMP systems as they affect the order in which
-memory operations appear to a device by prohibiting both the compiler and the
-CPU from reordering them.
+barriers impose unnecessary overhead on both SMP and UP systems. They may,
+however, be used to control MMIO effects on accesses through relaxed memory I/O
+windows.  These barriers are required even on non-SMP systems as they affect
+the order in which memory operations appear to a device by prohibiting both the
+compiler and the CPU from reordering them.
 
 
 There are some more advanced barrier functions:
@@ -2948,6 +2949,28 @@ The Alpha defines the Linux kernel's memory barrier model.
 
 See the subsection on "Cache Coherency" above.
 
+VIRTUAL MACHINE GUESTS
+-------------------
+
+Guests running within virtual machines might be affected by
+SMP effects even if the guest itself is compiled within
+SMP support.
+
+This is an artifact of interfacing with an SMP host while
+running an UP kernel.
+
+Using mandatory barriers for this use-case would be possible
+but is often suboptimal.
+
+To handle this case optimally, low-level __smp_mb() etc macros are available.
+These have the same effect as smp_mb() etc when SMP is enabled, but generate
+identical code for SMP and non-SMP systems. For example, virtual machine guests
+should use __smp_mb() rather than smp_mb() when synchronizing against a
+(possibly SMP) host.
+
+These are equivalent to smp_mb() etc counterparts in all other respects,
+in particular, they do not control MMIO effects: to control
+MMIO effects, use mandatory barriers.
 
 ============
 EXAMPLE USES
-- 
MST
