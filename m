Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:44011 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422829AbXDXRha (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Apr 2007 13:37:30 -0400
Subject: Re: larger per cpu data
References: <617E1C2C70743745A92448908E030B2A015F2383@scsmsx411.amr.corp.intel.com>
From: Jes Sorensen <jes@sgi.com>
Date: 24 Apr 2007 13:14:49 -0400
In-Reply-To: <617E1C2C70743745A92448908E030B2A015F2383@scsmsx411.amr.corp.intel.com>
Message-ID: <yq0odldpud2.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> "Tony" == Luck, Tony <tony.luck@intel.com> writes:

>> > IA64 has a 64KB page allocated for each cpu for the percpu
>> data. Right > now we are using 28K-32K for the arch/ia64/configs/*
>> variations.
>> 
>> Could that be enlarged without too much trouble?

Tony> If we stick to mapping it with a single TLB entry, then the next
Tony> size up is 256K ... which is a pretty big jump.  But the code
Tony> that does the mapping is just about to be changed from a single
Tony> locked TLB entry to a map-on-tlb-miss version (thanks to Ken
Tony> Chen). Some small-ish additions to that code would allow an
Tony> expansion to 128K by mapping each half with a 64K TLB entry on
Tony> demand.

256KB * 1024 CPUs (or more) == verymightyhuge ..... I certainly
wouldn't like to see this.

Cheers,
Jes
