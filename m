From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Tue, 30 May 2017 00:34:34 +1000
Message-ID: <20170530003434.5099e7b3@roar.ozlabs.ibm.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
        <20170529203355.4ebd1062@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35197 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdE2Oev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 10:34:51 -0400
In-Reply-To: <20170529203355.4ebd1062@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, 29 May 2017 20:33:55 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Nick,
> 
> On Mon, 29 May 2017 18:11:03 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 6c00e5b00f8b..28e64cb65dd5 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -511,10 +511,23 @@ config CC_STACKPROTECTOR_STRONG
> >  endchoice
> >  
> >  config THIN_ARCHIVES
> > -	bool
> > +	bool "Build the kernel using thin archives"
> > +	default n  
> 
> Of course, this will be enabled by allmodconfig, etc builds ...
> 

Yes that is true. Thanks for making a note of it -- I guess the
changelog could be interpreted as implying no change to any
existing build without arch enablement. I didn't intend to mislead
there.

Thanks,
Nick
