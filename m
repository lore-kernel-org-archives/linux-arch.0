Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net ([64.81.246.98]:50053 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261576AbUEEDU5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2004 23:20:57 -0400
Date: Tue, 4 May 2004 20:18:33 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-ID: <20040505031833.GA17341@twiddle.net>
References: <200405031741.52504.arnd@arndb.de> <20040503193835.72c62ad8.akpm@osdl.org> <200405041617.37371.arnd@arndb.de> <16535.50431.820664.953078@napali.hpl.hp.com> <20040504120317.36d45341.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040504120317.36d45341.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, arnd@arndb.de, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Tue, May 04, 2004 at 12:03:17PM -0700, Andrew Morton wrote:
> We can certainly live with this workaround, but it would be nice to find
> something better. per-module per-cpu data sections?

I would think it should be possible to work around the amd64
compiler memory model thing by using inline assembly to access
the movabsq instruction and thense the 64-bit relocation.


r~
