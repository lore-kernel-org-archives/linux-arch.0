Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269048AbUHMIQ6@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:34007 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S269041AbUHMIQg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Aug 2004 04:16:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.30943.757771.278533@napali.hpl.hp.com>
Date: Fri, 13 Aug 2004 01:16:31 -0700
Subject: Re: clear_user_highpage()
In-Reply-To: <20040812213403.GE12936@parcelfarce.linux.theplanet.co.uk>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040812020825.GA14411@wotan.suse.de>
	<20040811194545.0034428b.davem@redhat.com>
	<20040812110924.0713f5d9.ak@suse.de>
	<20040812125059.298ae914.davem@redhat.com>
	<20040812213403.GE12936@parcelfarce.linux.theplanet.co.uk>
Reply-To: davidm@hpl.hp.com
To: Matthew Wilcox <willy@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Thu, 12 Aug 2004 22:34:03 +0100, Matthew Wilcox <willy@debian.org> said:

  Matthew> Yes, almost exactly.  You can specify the "nta" hint to
  Matthew> stores which means "non-temporal at all levels".  If the
  Matthew> cache-line is already present in the cache at any level, it
  Matthew> will not be demoted, but if it isn't present, it'll bypass
  Matthew> the cache entirely.

The architecture leaves the details to the chip family.  For Itanium 2
chips, a store with the ".nta" hint means (see [1]):

 L1 cache: don't allocate, don't update LRU bits
 L2 cache: allocate, don't update LRU bits
 L3 cache: don't allocate, don't update LRU bits

The textual description is as follows:

 .nta: This hint means non-temporal locality in all levels of the
 cache hierarchy.  For the Itanium 2 processor, this hint will cause
 the line to be allocated in L2; however, the LRU information will not
 be updated for the line (i.e., it will be the next line to be
 replaced in the particular set).  This line will not be allocated in
 the L3 cache.  If present in any cache, it will not be deallocated
 from that cache, although sometimes lines are deallocated for
 coherency reasons.

So it's not exactly like the SPARC64 case but it is quite similar in
nature.

	--david

[1] http://www.intel.com/design/itanium2/manuals/251110.htm
