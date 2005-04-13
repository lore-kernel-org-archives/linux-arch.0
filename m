Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: i386-cpu-hotplug-updated-for-mm.patch
Date: Wed, 13 Apr 2005 11:00:43 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03456F3C@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, "Raj, Ashok" <ashok.raj@intel.com>
List-ID: <linux-arch.vger.kernel.org>

>This is the i386 cpu hotplug patch.  It's been in -mm for eons.
>
>I was planning on merging it post-2.6.12 because several 
>power-management
>related projects will use infrastructure which it provides.

But my local cpu hotplug expert (Ashok) has this to say about
the irq redirection part of the i386 code:

On i386, the way they do in fixup_irqs() to 

  Redirect interrupts
  Local_irq_enable() // hack to permit irq processing
  Mdelay();; hack to wait
  Local_irq_disable()

Is totally not the right solution, there are easy cases that a race
condition can be triggered, and chipsets can also lockup if you do
programming the rte's without disabling them first.

This really ought to be fixed before putting it into production
kernels.

They also need to change irq to deferred mode when we do proc/irq
write handling like what we do for ia64.


-Tony
