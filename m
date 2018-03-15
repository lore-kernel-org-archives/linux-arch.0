Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCOQZ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 12:25:26 -0400
Date: Thu, 15 Mar 2018 17:25:22 +0100
From: gregkh <gregkh@linuxfoundation.org>
Subject: Re: [Blackfin removal] [PATCH 11/28] misc: Remove Blackfin DSP echo
 support
Message-ID: <20180315162522.GA2258@kroah.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
 <1521111028-19856-11-git-send-email-aaron.wu@analog.com>
 <CAK8P3a2MKK4gNfP6jN8+ZXpUgS56UBqwdM5aPnbe3e--0BWr5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2MKK4gNfP6jN8+ZXpUgS56UBqwdM5aPnbe3e--0BWr5w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Aaron Wu <aaron.wu@analog.com>, linux-arch <linux-arch@vger.kernel.org>, Steve Underwood <steveu@coppice.org>, David Rowe <david@rowetel.com>

On Thu, Mar 15, 2018 at 04:54:11PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 11:50 AM, Aaron Wu <aaron.wu@analog.com> wrote:
> > Signed-off-by: Aaron Wu <aaron.wu@analog.com>
> >
> > Remove Blackfin DSP echo support
> > ---
> >  drivers/misc/echo/echo.c | 73 ------------------------------------------------
> >  drivers/misc/echo/fir.h  | 50 ---------------------------------
> >  2 files changed, 123 deletions(-)
> 
> I had picked up this patch at first, but now took a closer look and found no
> users of this module. It sounds to me like we should remove the entire
> directory rather than just the blackfin portion.
> 
> Adding the original authors to Cc for clarification.

The echo "driver" is used by Asterix systems.  It seems to be the only
driver that ended up getting merged upstream from that huge mess.  So
there are users of it, or at least there were, I don't know how popular
Asterix is these days.

thanks,

greg k-h
