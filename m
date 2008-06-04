From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Wed, 04 Jun 2008 12:39:45 -0700
Message-ID: <1212608385.6340.32.camel@brick>
References: <1212428244.11008.40.camel@brick>
	 <Pine.LNX.4.64.0806022038400.6262@anakin> <1212604681.6340.28.camel@brick>
	 <Pine.LNX.4.64.0806042133510.32459@anakin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:63451 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759617AbYFDTjq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jun 2008 15:39:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so193793wfd.4
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2008 12:39:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806042133510.32459@anakin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, "tony.luck" <tony.luck@intel.com>

On Wed, 2008-06-04 at 21:34 +0200, Geert Uytterhoeven wrote:
> On Wed, 4 Jun 2008, Harvey Harrison wrote:
> > On Mon, 2008-06-02 at 21:15 +0200, Geert Uytterhoeven wrote:
> > > On Mon, 2 Jun 2008, Harvey Harrison wrote:
> Sounds still a bit strange to me...
> 
> As `get' and `put' have connotations of reference counts, what about
> `load' and `store', e.g. `load_le32()' and `store_be16()'?
> 

Well, load is covered by le16_to_cpup and friends.

I could live with store_le16 though.  I had originally added get_le16,
put_le16 to match up with the get_unaligned_le16, put_unaligned_le16
functions.  Maybe these would have been better as load_unaligned_*
store_unaligned_* and during this change we could fix the argument
order to be (ptr, val) allowing a gradual changeover without a flag
day.

Andrew?  What do you think of load/store?

Harvey
