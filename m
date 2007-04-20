Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24509 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030866AbXDTUXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 16:23:55 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: larger per cpu data
Date: Fri, 20 Apr 2007 13:23:51 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A015F2383@scsmsx411.amr.corp.intel.com>
In-Reply-To: <200704202211.58419.ak@suse.de>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> > IA64 has a 64KB page allocated for each cpu for the percpu data. Right
> > now we are using 28K-32K for the arch/ia64/configs/* variations.
>
> Could that be enlarged without too much trouble?

If we stick to mapping it with a single TLB entry, then the next
size up is 256K ... which is a pretty big jump.  But the code that
does the mapping is just about to be changed from a single locked
TLB entry to a map-on-tlb-miss version (thanks to Ken Chen). Some
small-ish additions to that code would allow an expansion to 128K
by mapping each half with a 64K TLB entry on demand.

-Tony
