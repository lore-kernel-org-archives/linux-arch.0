From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Wed, 04 Jun 2008 16:27:11 -0700
Message-ID: <1212622031.6340.42.camel@brick>
References: <1212428244.11008.40.camel@brick>
	 <Pine.LNX.4.64.0806022038400.6262@anakin> <1212604681.6340.28.camel@brick>
	 <Pine.LNX.4.64.0806042133510.32459@anakin> <1212608385.6340.32.camel@brick>
	 <20080604232022.GA28960@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:38266 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbYFDX1N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jun 2008 19:27:13 -0400
Received: by py-out-1112.google.com with SMTP id p76so286864pyb.10
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2008 16:27:12 -0700 (PDT)
In-Reply-To: <20080604232022.GA28960@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, "tony.luck" <tony.luck@intel.com>

On Thu, 2008-06-05 at 00:20 +0100, Russell King wrote:
> On Wed, Jun 04, 2008 at 12:39:45PM -0700, Harvey Harrison wrote:
> > On Wed, 2008-06-04 at 21:34 +0200, Geert Uytterhoeven wrote:
> > > On Wed, 4 Jun 2008, Harvey Harrison wrote:
> > > > On Mon, 2008-06-02 at 21:15 +0200, Geert Uytterhoeven wrote:
> > > > > On Mon, 2 Jun 2008, Harvey Harrison wrote:
> > > Sounds still a bit strange to me...
> > > 
> > > As `get' and `put' have connotations of reference counts, what about
> > > `load' and `store', e.g. `load_le32()' and `store_be16()'?
> > > 
> > 
> > Well, load is covered by le16_to_cpup and friends.
> 
> What about the logical cpu_to_le16p then?
> 

Already exists, but it is not like the proposed store_le16, it just
has the types reversed.

u16 le16_to_cpup(__le16 *p)
__le16 cpu_to_le16p(u16 *p)

Currently you see things like:

*(__le16 *)ptr = cpu_to_le16(val);

Hence my idea for a:
store_le16(ptr, val);

Harvey
