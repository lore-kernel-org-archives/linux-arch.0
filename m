Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Remaining arch problems in cpu_idle
Date: Wed, 29 Jun 2005 14:51:25 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B5D6@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

>h8300, ia64, and sh64 still have possible outstanding issues,
>which I've put at the end of the Documentation/ file. It
>would be nice to get these looked at.

+ia64 - is safe_halt call racy vs interrupts? (does it sleep?) (See #4a)

safe_halt() makes a call to PAL[1] to go to a lower power state.  It does
not do anything that would require a sleep.

-Tony

PAL = "processor abstraction layer" ... some firmware which is used
to hide model specific differences between ia64 processor implementations.
