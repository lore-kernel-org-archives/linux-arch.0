Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41211 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbcAZKcb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2016 05:32:31 -0500
Date: Tue, 26 Jan 2016 11:32:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126103200.GI6375@twins.programming.kicks-ass.net>
References: <20160113104516.GE25458@arm.com>
 <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126102402.GE6357@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Will Deacon <will.deacon@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20160126103200.pq1_sASt1rprR7KlEd2zOI_36vb2BYdLLe2BpYEmrzE@z>

On Tue, Jan 26, 2016 at 11:24:02AM +0100, Peter Zijlstra wrote:

> Yeah, this goes under the header: memory-barriers.txt is _NOT_ a
> specification (I seem to keep repeating this).

Do we want this ?

---
 Documentation/memory-barriers.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a61be39c7b51..433326ebdc26 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1,3 +1,4 @@
+
 			 ============================
 			 LINUX KERNEL MEMORY BARRIERS
 			 ============================
@@ -5,6 +6,22 @@
 By: David Howells <dhowells@redhat.com>
     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
 
+==========
+DISCLAIMER
+==========
+
+This document is not a specification; it is intentionally (for the sake of
+brevity) and unintentionally (due to being human) incomplete. This document is
+meant as a guide to using the various memory barriers provided by Linux, but
+in case of any doubt (and there are many) please ask.
+
+I repeat, this document is not a specification of what Linux expects from
+hardware.
+
+=====
+INDEX
+=====
+
 Contents:
 
  (*) Abstract memory access model.
