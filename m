Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60081 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbbKXKmm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 05:42:42 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Kbuild: disable 'maybe-uninitialized' warning for CONFIG_PROFILE_ALL_BRANCHES
Date: Tue, 24 Nov 2015 11:42:09 +0100
Message-ID: <20825812.L9y0yMCgts@wuerfel>
In-Reply-To: <565439FB.6050800@suse.com>
References: <3799453.oCg1CdOrtm@wuerfel> <565439FB.6050800@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20151124104209.hpB7JzAFuQrsfK9Qrq_rspaadCuVtvJApQ5jNBhcws0@z>

On Tuesday 24 November 2015 11:20:43 Michal Marek wrote:
> > diff --git a/Makefile b/Makefile
> > index 5e01a416c6e4..f8b921658f29 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -626,7 +626,11 @@ KBUILD_CFLAGS    += $(call cc-option,-fno-delete-null-pointer-checks,)
> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >  KBUILD_CFLAGS        += -Os $(call cc-disable-warning,maybe-uninitialized,)
> >  else
> > -KBUILD_CFLAGS        += -O2
> > +ifdef CONFIG_PROFILE_ALL_BRANCHES
> > +KBUILD_CFLAGS        += -O2 $(call cc-disable-warning,maybe-uninitialized,)
> > +else
> > +KBUILD_CFLAGS   += -O2
> > +endif
> 
> Does it only happen with -O2? Normally, we would add it outside the
> ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 

We already disable the warning for -Os builds based on a patch we merged
a while ago. It seems easier to add it to the block we already have.

	Arnd
