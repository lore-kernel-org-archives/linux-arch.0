Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Thu, 15 Dec 2005 09:45:10 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: dhowells@redhat.com, Andrew Morton <akpm@osdl.org>
Cc: Mark Lord <lkml@rtr.ca>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

     Okay, spinlocks are null ops when CONFIG_SMP and CONFIG_DEBUG_SPINLOCK
     are both disabled, but you still have to disable interrupts, and that
     slows things down, sometimes quite appreciably. It is, for example,
     something I really want to avoid doing on FRV as it takes a *lot* of
     cycles.

There was a USENIX paper a couple of decades ago that described how
to do a fast s/w disable of interrupts on machines where really disabling
interrupts was expensive.  The rough gist was that the spl[1-7]()
functions would just set a flag in memory to hold the desired interrupt
mask.  If an interrupt actually occurred when it was s/w blocked, the
handler would set a pending flag, and just rfi with interrupts disabled.
Then the splx() code checked to see whether there was a pending interrupt
and dealt with it if there was.

-Tony

 
