Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:62143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264471AbUEDTZB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2004 15:25:01 -0400
Date: Tue, 4 May 2004 12:23:52 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-Id: <20040504122352.2b554573.akpm@osdl.org>
In-Reply-To: <16535.60380.254878.301569@napali.hpl.hp.com>
References: <200405031741.52504.arnd@arndb.de>
	<20040503193835.72c62ad8.akpm@osdl.org>
	<200405041617.37371.arnd@arndb.de>
	<16535.50431.820664.953078@napali.hpl.hp.com>
	<20040504120317.36d45341.akpm@osdl.org>
	<16535.60380.254878.301569@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, arnd@arndb.de, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Tue, 4 May 2004 12:03:17 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   Andrew> We can certainly live with this workaround
> 
> I'll bet that sooner or later someone would do a source-code review
> and find that the per-CPU variables in question are only used in one
> file and then "fix" that by adding back the static.

But then it won't compile?

>   Andrew> but it would be nice to find something better. per-module
>   Andrew> per-cpu data sections?
> 
> I had something rather simpler in mind: just a macro that expands into
> "static" for the normal case and nothing for s390x.

But then things will work OK on x86 but there's a risk that s390 will see
duplicated symbols at link-time.  Admittedly the risk is pretty low, but in
that case the risk is also low on other architectures, so they can live
with making the symbols global.

What's the concern?  Just the tidiness thing?
