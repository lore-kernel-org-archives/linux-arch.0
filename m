Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel13.hp.com ([156.153.255.238]:39355 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264714AbUEEQRn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2004 12:17:43 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16537.5027.145259.789392@napali.hpl.hp.com>
Date: Wed, 5 May 2004 09:17:39 -0700
Subject: Re: static DEFINE_PER_CPU vs. modules
In-Reply-To: <200405051021.13944.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
	<20040504122352.2b554573.akpm@osdl.org>
	<16535.62156.173458.969241@napali.hpl.hp.com>
	<200405051021.13944.arnd@arndb.de>
Reply-To: davidm@hpl.hp.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Wed, 5 May 2004 10:21:12 +0200, Arnd Bergmann <arnd@arndb.de> said:

  Arnd> In theory, it can hit on every architecture that supports
  Arnd> pc-relative relocations (i.e. most of them). It's hard to
  Arnd> trigger because you need SMP, a certain (large) amount of RAM,
  Arnd> and use the scsi or ipv6 as modules.  In the worst case it's
  Arnd> almost impossible to debug (silent corruption of a single word
  Arnd> in memory).

Why silent corruption?  Surely the kernel loader barfs if a relocation
is out of range.

	--david
