Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29899 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993313AbXDTSXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 14:23:54 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: larger per cpu data
Date: Fri, 20 Apr 2007 11:23:13 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A015F22CB@scsmsx411.amr.corp.intel.com>
In-Reply-To: <200704201246.17531.ak@suse.de>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> I heard there were some problems with ia64 have those been fixed too?

IA64 has a 64KB page allocated for each cpu for the percpu data. Right
now we are using 28K-32K for the arch/ia64/configs/* variations.

> Anybody would have a problem with increasing per CPU data in a
> standard kernel by a few KB?

How many is "a few" ... and much more importantly is your few KB
a fixed amount, or does it scale up with the number of network cards
(or anything else that there might be a lot of on a large system)?

A fixed extra 8-10K should be fine.  #NIC * 1K would cause problems.

-Tony
 
