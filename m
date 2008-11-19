From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: + unaligned-introduce-common-header.patch added to -mm tree
Date: Wed, 19 Nov 2008 09:16:26 -0800
Message-ID: <1227114986.13182.12.camel@brick>
References: <200811190614.mAJ6EsXA007330@imap1.linux-foundation.org>
	 <Pine.LNX.4.64.0811190919280.27671@anakin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:52489 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYKSRQb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 12:16:31 -0500
Received: by yw-out-2324.google.com with SMTP id 9so30785ywe.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2008 09:16:30 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0811190919280.27671@anakin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, bryan.wu@analog.com, "David S. Miller" <davem@davemloft.net>, dhowells@redhat.com, Greg Ungerer <gerg@uclinux.org>, grundler@parisc-linux.org, heiko.carstens@de.ibm.com, hskinnemoen@atmel.com, ink@jurassic.park.msu.ru, kyle@mcmartin.ca, lethal@linux-sh.org, linux-arch@vger.kernel.org, mingo@elte.hu, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>, rth@twiddle.net, schwidefsky@de.ibm.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, ysato@users.sourceforge.jp, zankel@tensilica.com, Roman Zippel <zippel@linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Wed, 2008-11-19 at 09:21 +0100, Geert Uytterhoeven wrote:
> On Tue, 18 Nov 2008, akpm@linux-foundation.org wrote:
> > Subject: unaligned: introduce common header
> > From: Harvey Harrison <harvey.harrison@gmail.com>
> > 
> > There are two common cases in the kernel, one where unaligned access is OK
> > for an arch and one where the arch uses a packed-struct for the native
> > endianness and opencoded C byteshifting for the other endianness. 
> > Consolidate these two implementations in asm-generic/unaligned.h
> > 
> > Arches that require no special handling of unaligned access can define
> > _UNALIGNED_ACCESS_OK in their asm/unaligned.h before including the generic
> > version.
> > 
> > +static inline void __put_le32_noalign(u8 *p, u32 val)
> > +{
> > +	__put_le16_noalign(p + 2, val >> 16);
> > +	__put_le16_noalign(p, val);
> 
> Isn't it more logical to reverse the order, to store in increasing memory
> locations:
> 
> 	__put_le16_noalign(p, val);
> 	__put_le16_noalign(p + 2, val >> 16);
> 

All of the byteshifting versions were cribbed from the ARM implementation.

I'm not sure if there was a particular reason for doing it in this order, but
a lot of work seems to have gone in to minimize register usage.

See include/asm-arm/unaligned.h circa 2.6.25.

Harvey
