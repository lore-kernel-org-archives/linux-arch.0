From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Generic syscall ABI support
Date: Thu, 28 Mar 2013 11:42:47 +0000
Message-ID: <201303281142.47631.arnd@arndb.de>
References: <1364440182.2289.45.camel@leyfoon-vm> <201303281040.04463.arnd@arndb.de> <1364470251.3146.1.camel@leyfoon-vm>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52071 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3C1Lmy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 07:42:54 -0400
In-Reply-To: <1364470251.3146.1.camel@leyfoon-vm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 28 March 2013, Ley Foon Tan wrote:
> On Thu, 2013-03-28 at 10:40 +0000, Arnd Bergmann wrote:
> > On Thursday 28 March 2013, Ley Foon Tan wrote:
> > > We will working on generic ABI for kernel and Glibc. This might take
> > > some times.
> > 
> > Ok. Don't let that hold you up from submitting the kernel patches
> > for review though.
>
> Do you mean we can submit the patches for review before we got the
> generic ABI support?

I mean you can send the other patches for review already. Changing
your implementtion to use the generic ABI will basically just mean
not sending the patches tht implement your own ABI, so that's not
hard. Of course until you also have a new glibc port, you won't be
able to test that it actually works, but that is not essential for
the reviewing stage.

	Arnd
