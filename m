Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:5260 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751989AbWG1Of6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Jul 2006 10:35:58 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k6SEZtY16443
	for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2006 10:35:55 -0400
Subject: Proposed update to the kernel kmap/kunmap API [rationale]
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 09:35:54 -0500
Message-Id: <1154097354.9447.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

We recently discovered a problem in the kmap/kunmap API on parisc that
causes Linux to crash and burn pretty badly on the most recent PA8800
and PA8900 processors.  The problem is that these are dual core beasts
with a private L1 VIPT cache and a shared L2 PIPT cache.

If you don't want to understand the gory details of what's going on and
how it needs to be fixed, don't read any further (it really only occurs
in a combined VIPT/PIPT cache hierarchy) ... I'll propose the kmap API
change in a later email.

The essence of the problem is that the Linux coherence API is very
careful about managing dirty inequivalent aliases.  However, it adopts a
"don't care" attitude to inequvalent clean aliases.  The problem for us
is that inequivalent clean aliases can also lead to data corruption.
I'll give you a single scenario as an example:  Supposing we have two
inequivalent addresses: V1 and V2 both mapping to physical address P.
Now, if we read the data Da at V1 we set up a clean cache alias in the
L1.  Now let's suppose we write data Db at V2 and then flush it (this
clears it completely out of both the L1 and the L2).  At a later time
the LRU victim selection algorithm in the L1 runs and ejects the line at
V1, which is still a clean line.  However, in a cache hierarchy this
causes Da to be written at P in the L2 PIPT cache.  If someone later
accesses the data via V2, this is resolved in the L2 PIPT at P and the
incorrect data Da is returned (recall, Db is the correct data in memory
but it has been obscured by the alias resolution in the PIPT).

There are many other such scenarios where this type of clean line
corruption can occur in a combined VIPT/PIPT hierarchy. The solution is
that we have to forcibly evict inequivalent aliases after we finish
using them to avoid the data in them becoming stale.  Fortunately, there
is a method of doing this:  In parisc, and most other VI architectures,
we make sure that all user addresses are fully equivalent, so the only
potential source of inequivalency is the kernel mappings.  Thus, as long
as we carefully manage kernel accesses to user data we can avoid this
stale clean aliases problem.  The engine of kernel accesses to user data
is kmap/kunmap, so all we really need is a way to hijack the kmap/kunmap
API so that on kunmap we can guarantee that there is no cache alias
(which can later become stale) for the page in the kernel.

The proposal, however, will be to go beyond this simple hijack for
parisc and to extend the kmap/kunmap API.  Since kmap/kunmap *is* the
engine for this potential incoherence, it makes sense that it should
manage the coherence on all platforms.  Thus now we see things like

kmap(page)
/* write data at kernel addresses */
flush_kernel_dcache_page(page)
kunmap(page)

Threaded through all drivers.  If we force the kmap/kunmap to manage the
coherence, there will be no need to burden either driver or filesystem
writers with the additional flushing.  We'll still require the guarantee
that the page comes to us flushed from user space, which guarantee linux
makes now, but at least we can eliminate coherency worries when the
kernel actually modifies the data.

James


