Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:39088 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264151AbUECXMl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2004 19:12:41 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.53723.524354.936428@napali.hpl.hp.com>
Date: Mon, 3 May 2004 16:12:27 -0700
Subject: Re: static DEFINE_PER_CPU vs. modules
In-Reply-To: <200405040024.03906.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
	<20040503180156.GA10981@twiddle.net>
	<16534.37209.199911.737170@napali.hpl.hp.com>
	<200405040024.03906.arnd@arndb.de>
Reply-To: davidm@hpl.hp.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: davidm@hpl.hp.com, Richard Henderson <rth@twiddle.net>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Tue, 4 May 2004 00:24:02 +0200, Arnd Bergmann <arnd@arndb.de> said:

  Arnd> I don't understand how that would help. On an 4GB+ system,
  Arnd> modules get get loaded to a >4GB address, so a 32 bit
  Arnd> PC-relative relocation that can not get to a small positive
  Arnd> address won't be enough for a small negative address
  Arnd> either. The only way to force absolute addressing instead of
  Arnd> PC-relative on s390x is to compile with -fPIC (as we do) _and_
  Arnd> declare the symbol non-static.

Why not use a GCC attribute?  Perhaps it's a bit of a stretch, but if
you interpret "model(small)" as indicating "small positive/negative
_absolute_ address", you could even use the same attribute name.

	--david
