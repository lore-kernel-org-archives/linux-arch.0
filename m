Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:51503 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab3C2Ell convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2013 00:41:41 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so179463iad.12
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2013 21:41:41 -0700 (PDT)
Date: Thu, 28 Mar 2013 23:41:37 -0500
From: Rob Landley <rob@landley.net>
Subject: Re: Generic syscall ABI support
In-Reply-To: <201303281142.47631.arnd@arndb.de> (from arnd@arndb.de on Thu
	Mar 28 06:42:47 2013)
Message-ID: <1364532097.18069.7@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ley Foon Tan <lftan@altera.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20130329044137._Fqj3XZCfwYGelRrZ8SaB992KszlBhcUOe4pRcFIZ_g@z>

On 03/28/2013 06:42:47 AM, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Ley Foon Tan wrote:
> > On Thu, 2013-03-28 at 10:40 +0000, Arnd Bergmann wrote:
> > > On Thursday 28 March 2013, Ley Foon Tan wrote:
> > > > We will working on generic ABI for kernel and Glibc. This might  
> take
> > > > some times.
> > >
> > > Ok. Don't let that hold you up from submitting the kernel patches
> > > for review though.
> >
> > Do you mean we can submit the patches for review before we got the
> > generic ABI support?
> 
> I mean you can send the other patches for review already. Changing
> your implementtion to use the generic ABI will basically just mean
> not sending the patches tht implement your own ABI, so that's not
> hard. Of course until you also have a new glibc port, you won't be
> able to test that it actually works, but that is not essential for
> the reviewing stage.

You don't need a new glibc port, you need a new klibc or musl port.

   http://www.openwall.com/lists/musl/2012/07/08/1

Way less work than getting glibc working for your basic smoketest...

Rob