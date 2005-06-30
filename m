Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Remaining arch problems in cpu_idle
Date: Wed, 29 Jun 2005 17:07:57 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B84D@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, David Mosberger <davidm@hpl.hp.com>
List-ID: <linux-arch.vger.kernel.org>

>I don't suppose safe_halt can be called with interrupts off
>safely, like the i386 function of the same name?

Yes.  Looking at the code for safe_halt() [chasing through
ia64_do_halt_light() to PAL_CALL() to ia64_pal_call_static] I see
that we disable interrupts before calling into the PAL, and restore
the state after we return.  So somewhere in the depths of the PAL
code the cpu is checking to see whether an external interrupt is
pending, even though we have interrupts blocked.

-Tony
