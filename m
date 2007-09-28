Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45221 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbXI1ReQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Sep 2007 13:34:16 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Optimize cpumask functions for SMPs with < BITS_PER_LONG processors
Date: Fri, 28 Sep 2007 19:34:11 +0200
References: <20070925155200.GA7342@linux-mips.org>
In-Reply-To: <20070925155200.GA7342@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709281934.11957.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 25 September 2007 17:52:00 Ralf Baechle wrote:
> When debugging a kernel using a logic analyzer (!) a colleague recently
> noticed that because the <linux/cpumasks.h> functions are based on the
> generic bitops which support arbitrary size bitfields we had a relativly
> high overhead resulting from this.  Here's the chainsaw edition of a patch
> to optimize this for CONFIG_NR_CPUS <= BITS_PER_LONG.  Comments?

The right thing to test is not CONFIG_NR_CPUS, but just
do __builtin_constant_p(x) && (x) <= BITS_PER_LONG ? fast case : external call
in find_*_bit()

x86-64 has done this already for some time. But one issue is that 
that the cpumask walk functions currently do (n = find_*_bit()) >= maxbit ? maxbit : n
which also creates more overhead because some architectures get this
wrong (including x86-64 I must admit) 

-Andi

