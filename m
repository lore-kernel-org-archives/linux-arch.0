Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: i386-cpu-hotplug-updated-for-mm.patch
Date: Wed, 13 Apr 2005 12:14:32 -0700
Message-ID: <A28EFEDC5416054BA1026D892753E9AF09493F7B@orsmsx404.amr.corp.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>> I'd prefer doing that change as a followup, but i'm fine with doing
it
>> before, i'm  just trying to avoid patches dependent on this backing
up.
>
>That sounds reasonable at this stage, if the racy code is only used
during
>"hotplugging".  But I don't think that's the case, is it?

That sounds reasonable, as long as we are tagging it EXPERIMENTAL in the
config files.

Atleast it will help not having to keep back-porting for ages...

Currently the problem will happen in two places

1. handling writes to /proc/irq/, I think user mode irq-balancer uses
this, in the past when we had CONFIG_IRQ_BALANCE, it used do the right
way for the kernel mode balancing, but not user mode writes to /proc.
This was fixed for ia64, I think I have an old patch for i386 that I can
dish out sometime.

2. when we do fixup_irqs(), which will get called in the suspend/resume
solution that they are discussing, the same problem may happen,
especially when unsolicited network packet makes it way in, right when
we switch cpu targets for interrupts.

I would prefer the startup code for 386 change as well, I think Andi is
making some progress in x86_64 side, so we could probably leverage from
there once this is complete. 

Current i386 startup code is kludgy, Natalie from Unisys also made some
changes in the same area for i386 that we could pull in as 2nd phase as
necessary. (I think that would need more cleanup, so can be deferred
later)

Cheers,
ashok
