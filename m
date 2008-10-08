From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [RFC] Normalizing byteorder/unaligned access API
Date: Wed, 08 Oct 2008 00:34:34 -0700
Message-ID: <1223451274.8195.87.camel@brick>
References: <1223416391.8195.22.camel@brick>
	 <Pine.LNX.4.64.0810080908480.19202@anakin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:51734 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYJHHeh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2008 03:34:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3869959wfd.4
        for <linux-arch@vger.kernel.org>; Wed, 08 Oct 2008 00:34:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0810080908480.19202@anakin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Matthew Wilcox <matthew@wil.cx>, linux-scsi <linux-scsi@vger.kernel.org>, Boaz Harrosh <bharrosh@panasas.com>

On Wed, 2008-10-08 at 09:13 +0200, Geert Uytterhoeven wrote:
> On Tue, 7 Oct 2008, Harvey Harrison wrote:
> > [related question regarding the SCSI-private endian helper needs at the end]
> > 
> > Currently on the read side, we have (le16 as an example endianness)
> > 
> > le16_to_cpup(__le16 *)
> > get_unaligned_le16(void *)
> > 
> > And on the write side:
> > 
> > *(__le16)ptr = cpu_to_le16(u16)
> > put_unaligned_le16(u16, void *);
> > 
> > On the read side, Al said he would have preferred the unaligned version
> > take the same types as the aligned, rather than void *.  AKPM didn't think
> 
> As I said before, me too (take the same types as the aligned). I like to
> rely on sparse for:
> 
>     struct {
> 	...
> 	__le32 x;
> 	...
>     } s __attribute__ ((packed));
> 
> get_unaligned_le16(&s.x);

Agreed.

> 
> > the use of get_ was that great as get/put generally implies some kind of reference
> > taking in the kernel.
> 
> OK.
> 
> > As the le16_to_cpup has been around for so long and is more recognizable, let's
> > make it the same for the unaligned case and typesafe:
> > 
> > le16_to_cpup(__le16 *)
> > unaligned_le16_to_cpup(__le16 *)
> 
> I always hated that naming...

True, but there are already lots of places that use them...and I didn't want to
introduce an identical name for something that already exists, so I worked using
the existing name.  I think load_le16/load_unaligned_le16 is the best so far,
but I can see people being unhappy with the duplication of le16_to_cpup.

But it is trivial to move existing users over if that's the way the decision
goes.

> 
> > On the write side, the above get/put and type issues are still there, in addition AKPM felt
> > that the ordering of the put_unaligned parameters was opposite what was intuitive and that
> > the pointer should come first.
> > 
> > In this case, as there is currently no aligned helper (other than in some drivers defining macros)
> > define the api thusly:
> > 
> > Aligned:
> > write_le16(__le16 *ptr, u16 val)
> > 
> > Unaligned:
> > unaligned_write_le16(__le16 *ptr, u16 val)
> 
> Does it write to MMIO I/O space? No? Then please don't use write (like
> in writeb()).
> 
> What about load_{unaligned_,}le16() and store_{unaligned_,}le16()?

OK, will stay away from write as well.  I think store looks good, with
load_ there is still a question of duplicating existing functionality.

Thanks for the feedback.

Harvey
