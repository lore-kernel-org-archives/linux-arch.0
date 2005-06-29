Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Remaining arch problems in cpu_idle
Date: Wed, 29 Jun 2005 16:46:28 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B7ED@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, David Mosberger <davidm@hpl.hp.com>
List-ID: <linux-arch.vger.kernel.org>

>> +ia64 - is safe_halt call racy vs interrupts? (does it >sleep?) (See #4a)
>> 
>> safe_halt() makes a call to PAL[1] to go to a lower power state.  It does
>> not do anything that would require a sleep.
>> 
>
>So it won't need an interrupt to be revived out of that state?
>Thank you Tony, I'll take ia64 off the list.

Ummm ... no.  The processor will stay in the low power state until
an unmasked external interrupt occurs (or one of several other more
intrusive events like reset, machine check, PMI occur).

-Tony
