Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:7114 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263803AbUECRvj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2004 13:51:39 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.34396.940596.361864@napali.hpl.hp.com>
Date: Mon, 3 May 2004 10:50:20 -0700
Subject: Re: static DEFINE_PER_CPU vs. modules
In-Reply-To: <200405031741.52504.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
Reply-To: davidm@hpl.hp.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 3 May 2004 17:41:50 +0200, Arnd Bergmann <arnd@arndb.de> said:

  Arnd> I got a bug report about loading some modules on s390 (for the
  Arnd> privileged, see
  Arnd> http://bugzilla.suse.de/show_bug.cgi?id=38820).

  Arnd> The problem is that modules are loaded to a virtual address
  Arnd> that is far away (roughly main memory size) from the percpu
  Arnd> kernel section, but s390x-gcc generates only 32-bit
  Arnd> relocations for static variables.  My suspicion is that there
  Arnd> are some more architectures where a relocation for static
  Arnd> variables is not sufficient for per-cpu data. Can anyone
  Arnd> confirm this?

Definitely not a problem on ia64.  Seems to me this is a gcc bug if it
generates code that is unable to reach all possible addresses.

	--david
