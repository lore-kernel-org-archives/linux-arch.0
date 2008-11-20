Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:22118 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754310AbYKTNZu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Nov 2008 08:25:50 -0500
From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel (specifically arm in our case)
Date: Fri, 21 Nov 2008 00:25:39 +1100
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com> <200811201759.01039.nickpiggin@yahoo.com.au> <b647ffbd0811200428u2b41b108ifb02872563c871ab@mail.gmail.com>
In-Reply-To: <b647ffbd0811200428u2b41b108ifb02872563c871ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200811210025.39568.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fsdevel@vger.kernel.org, Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20081120132539.0zAEm06z5W5AVZUdOjH4To00z5hkj0LK0mM3-SEljyg@z>

On Thursday 20 November 2008 23:28, Dmitry Adamushko wrote:
> 2008/11/20 Nick Piggin <nickpiggin@yahoo.com.au>:
> > [ ... ]
> >
> > - The page is sent to the block layer, which stores into the page. Some
> >  block devices like 'brd' will potentially store via the kernel linear
> > map here, and they probably don't do enough cache flushing.
>
> btw., if someone is curious, here is another case of what may happen
> on VIPT systems when someone uses a "virtual" block device (like
> 'brd') as, heh, a swap :-)
>
> http://www.linux-mips.org/archives/linux-mips/2008-11/msg00038.html

Right... Now I'm lacking knowledge when it comes to devices, but I
think it is probably reasonable for the block device layer to ensure
the physical memory is uptodate after it signals request completion.

That is, there shouldn't be any potentially aliasing dirty lines.
Block devices which do any writeout via the kernel linear address
(eg. brd) should do a flush_dcache_page.

