Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] sched: unlocked context-switches
Date: Fri, 8 Apr 2005 11:38:09 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>tested on x86, and all other arches should work as well, but if an 
>architecture has irqs-off assumptions in its switch_to() logic 
>it might break. (I havent found any but there may such assumptions.)

The ia64_switch_to() code includes a section that can change a pinned
MMU mapping (when the stack for the new process is in a different
granule from the stack for the old process).  The code beyond the ".map"
label in arch/ia64/kernel/entry.S includes the comment:

.map:
        rsm psr.ic                      // interrupts (psr.i) are already disabled here

I don't think that it would be sufficient to merely add psr.i to this rsm
(and to the ssm 15 lines above).  That would leave a window where we could
take an interrupt, but not be sure that the current stack is pinned.

-Tony
