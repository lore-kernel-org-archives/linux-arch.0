Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net ([64.81.246.98]:36741 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263815AbUECSGO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2004 14:06:14 -0400
Date: Mon, 3 May 2004 11:01:56 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-ID: <20040503180156.GA10981@twiddle.net>
References: <200405031741.52504.arnd@arndb.de> <16534.34396.940596.361864@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16534.34396.940596.361864@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 03, 2004 at 10:50:20AM -0700, David Mosberger wrote:
> Seems to me this is a gcc bug if it
> generates code that is unable to reach all possible addresses.

Nope.  There are multiple memory models for amd64.  The default
assumes a 32-bit local data segment, since that makes for the
most efficient code generation and works virtually all of the time.

No different than assuming a 22-bit small-data section by default
for ia64...


r~
