Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel11.hp.com ([156.153.255.246]:64206 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264500AbUEDTpU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2004 15:45:20 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16535.62156.173458.969241@napali.hpl.hp.com>
Date: Tue, 4 May 2004 12:45:16 -0700
Subject: Re: static DEFINE_PER_CPU vs. modules
In-Reply-To: <20040504122352.2b554573.akpm@osdl.org>
References: <200405031741.52504.arnd@arndb.de>
	<20040503193835.72c62ad8.akpm@osdl.org>
	<200405041617.37371.arnd@arndb.de>
	<16535.50431.820664.953078@napali.hpl.hp.com>
	<20040504120317.36d45341.akpm@osdl.org>
	<16535.60380.254878.301569@napali.hpl.hp.com>
	<20040504122352.2b554573.akpm@osdl.org>
Reply-To: davidm@hpl.hp.com
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, arnd@arndb.de, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Tue, 4 May 2004 12:23:52 -0700, Andrew Morton <akpm@osdl.org> said:

  >>  I'll bet that sooner or later someone would do a source-code
  >> review and find that the per-CPU variables in question are only
  >> used in one file and then "fix" that by adding back the static.

  Andrew> But then it won't compile?

OK.

  Andrew> but it would be nice to find something better. per-module
  Andrew> per-cpu data sections?
  >>  I had something rather simpler in mind: just a macro that
  >> expands into "static" for the normal case and nothing for s390x.

  Andrew> But then things will work OK on x86 but there's a risk that
  Andrew> s390 will see duplicated symbols at link-time.  Admittedly
  Andrew> the risk is pretty low, but in that case the risk is also
  Andrew> low on other architectures, so they can live with making the
  Andrew> symbols global.

  Andrew> What's the concern?  Just the tidiness thing?

It's wrong to change the kernel just because it happens to be the easy
way out.

Arnd said that using a "model(small)" attribute would lead to less
efficient code, but wouldn't the same be true on s390x when dropping
the "static"?

	--david
