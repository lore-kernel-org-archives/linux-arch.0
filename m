Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267958AbUHPV3j@vger.kernel.org>
Received: from fmr06.intel.com ([134.134.136.7]:54422 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266341AbUHPV3j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2004 17:29:39 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Using get_cycles for add_timer_randomness
Date: Mon, 16 Aug 2004 14:29:03 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F01DAE278@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>
Cc: arnd@arndb.de, richm@oldelvet.org.uk, tytso@mit.edu, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>+		if (sizeof(time) > 4)
>>+			num ^= (u32)(time >> 32);
>
>How does this bit-flipping the low-order bits based on the high
>order bits of the timer help get more randomness?  It looks to
>me that it will just mess up the calculation of how much randomness
>you might have added. The delta/delta2/delta3 comparisons that
>are done later in the function appear to be based on the idea
>that you measure the `time' between events.  High order bits in
>cycle counters change at quite predicatable intervals and shouldn't
>take part in this calculation.

So I can't read today ... I was sure that "num" said "time" when
I wrote the above ... so disregard the part about messing up
delta calculations.  But I'm still don't see how using the high
bits of the cycle counter can be a good thing.

-Tony
