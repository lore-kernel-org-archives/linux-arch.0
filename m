Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262504AbULCXWH@vger.kernel.org>
Received: from palrel10.hp.com ([156.153.255.245]:7616 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262502AbULCXWG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2004 18:22:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16816.62747.810326.746490@napali.hpl.hp.com>
Date: Fri, 3 Dec 2004 15:22:03 -0800
Subject: Re: other platforms interested in in-kernel unwinder?
In-Reply-To: <200412032356.21537.arnd@arndb.de>
References: <16815.21943.55627.572012@napali.hpl.hp.com>
	<200412031037.22445.arnd@arndb.de>
	<16816.54808.503077.473990@napali.hpl.hp.com>
	<200412032356.21537.arnd@arndb.de>
Reply-To: davidm@hpl.hp.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: davidm@hpl.hp.com, linux-arch@vger.kernel.org, davidm@napali.hpl.hp.com, Wolfgang Gellerich <gellerich@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Fri, 3 Dec 2004 23:56:18 +0100, Arnd Bergmann <arnd@arndb.de> said:

  Arnd> IIRC, compilers up to gcc 3.4 store all callee-saved registers
  Arnd> in a fixed offset, while with gcc-4.0 and the patched gcc-3.4
  Arnd> used in fedora core 3 only the back chain pointer and the
  Arnd> return address can be read directly without looking at the
  Arnd> code or dwarf2 data.

OK, thanks for the clarification.  So it sounds like libunwind _might_
be useful if you ever wanted to play a similar trick we do on ia64,
where we construct the (preserved) user-level state on the fly.  But
then again, s390 probably has few enough registers that this may not
be much of a win.

Thanks,

	--david
