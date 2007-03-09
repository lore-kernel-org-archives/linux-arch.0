Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39517
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S2993030AbXCIHNt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2007 02:13:49 -0500
Date: Thu, 08 Mar 2007 23:13:41 -0800 (PST)
Message-Id: <20070308.231341.41635421.davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
From: David Miller <davem@davemloft.net>
In-Reply-To: <1173423341.3461.548.camel@pmac.infradead.org>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
	<1173423341.3461.548.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: dwmw2@infradead.org
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org, ralf@linux-mips.org, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 09 Mar 2007 06:55:41 +0000

> On Fri, 2007-03-09 at 15:22 +1100, Stephen Rothwell wrote:
> > This requires an architecture specific compat routine as u64s are passed
> > in odd/even (high/low) register pairs on ppc32.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Doesn't that apply to ARM and to 32-bit MIPS too? And perhaps others?

Unfortunately in the MIPS case you'll have to do some ifdef'ing because
the order of the "high" and "low" sub-part arguments is dependant upon
endianness and MIPS can be both big and little endian.

