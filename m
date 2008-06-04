From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Thu, 5 Jun 2008 00:20:23 +0100
Message-ID: <20080604232022.GA28960@flint.arm.linux.org.uk>
References: <1212428244.11008.40.camel@brick> <Pine.LNX.4.64.0806022038400.6262@anakin> <1212604681.6340.28.camel@brick> <Pine.LNX.4.64.0806042133510.32459@anakin> <1212608385.6340.32.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40858 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbYFDXVV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jun 2008 19:21:21 -0400
Content-Disposition: inline
In-Reply-To: <1212608385.6340.32.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, "tony.luck" <tony.luck@intel.com>

On Wed, Jun 04, 2008 at 12:39:45PM -0700, Harvey Harrison wrote:
> On Wed, 2008-06-04 at 21:34 +0200, Geert Uytterhoeven wrote:
> > On Wed, 4 Jun 2008, Harvey Harrison wrote:
> > > On Mon, 2008-06-02 at 21:15 +0200, Geert Uytterhoeven wrote:
> > > > On Mon, 2 Jun 2008, Harvey Harrison wrote:
> > Sounds still a bit strange to me...
> > 
> > As `get' and `put' have connotations of reference counts, what about
> > `load' and `store', e.g. `load_le32()' and `store_be16()'?
> > 
> 
> Well, load is covered by le16_to_cpup and friends.

What about the logical cpu_to_le16p then?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
