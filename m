Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:56973 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264056AbUEEIa4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2004 04:30:56 -0400
Date: Wed, 5 May 2004 01:29:47 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-Id: <20040505012947.5e8c4050.akpm@osdl.org>
In-Reply-To: <200405051021.13944.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
	<20040504122352.2b554573.akpm@osdl.org>
	<16535.62156.173458.969241@napali.hpl.hp.com>
	<200405051021.13944.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:
>
> The patch below still changes the common, i.e. non-ia64/x86_64, per-cpu
>  implementation so that STATIC_DEFINE_PER_CPU is not static for modules
>  and static DEFINE_PER_CPU is forbidden for modules.

What's the advantage in this?  The previous patch which killed the compile
if someone sticks a `static' in there seemed sufficient?
