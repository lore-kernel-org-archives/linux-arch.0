Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:56384
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751293AbaKKDAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Nov 2014 22:00:22 -0500
Message-ID: <1415674805.2445.0.camel@leyfoon-vm>
Subject: Re: [PATCH v6 00/29] nios2 Linux kernel port
From: Ley Foon Tan <lftan@altera.com>
Date: Tue, 11 Nov 2014 11:00:05 +0800
In-Reply-To: <20141110001250.7fc64233@canb.auug.org.au>
References: <1415011945-3297-1-git-send-email-lftan@altera.com>
	 <CAFiDJ5_6HOPH_g6+Z1GwE87qXaGtnyUZdPvFCbC7E3v0+7o3VA@mail.gmail.com>
	 <CAFiDJ5_opOE5g14y1A7X3mn3H0ZOGV0kLVhEJnSrt3n47Nn2bQ@mail.gmail.com>
	 <20141110001250.7fc64233@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20141111030005._Nf_75bfUZ7kfb68tJdCW3EHqh-ZfJqFL3Z8T3uUYbI@z>

On Isn, 2014-11-10 at 00:12 +1100, Stephen Rothwell wrote:
> Hi,
> 
> On Fri, 7 Nov 2014 17:24:43 +0800 Ley Foon Tan <lftan@altera.com> wrote:
> >
> > On Fri, Nov 7, 2014 at 3:39 PM, LF.Tan <lftan.linux@gmail.com> wrote:
> > >
> > > Review for Nios2 port is completed and ready for upstream. Can you
> > > please add nios2 patchset to linux-next?
> > >
> > > The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:
> > >
> > >   Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
> > >
> > > are available in the git repository at:
> > >
> > >   http://git.rocketboards.org/linux-socfpga-next.git tags/nios2-for-linux-next
> > >
> > > for you to fetch changes up to 1b9e67a57ac633f407de11b36d8f996c368a8c66:
> > >
> > >   nios2: Build infrastructure (2014-11-06 15:23:37 +0800)
> >
> > By the way, I also created "nios2-next" branch for you to add to linux-next.
> > 
> > git://git.rocketboards.org/linux-socfpga-next.git nios2-next
> 
> Added from Monday with just you as the contact.
> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgment of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
Thanks. Saw it in linux-next.

Regards
Ley Foon



