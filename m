Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:17642 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbYDWR7I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2008 13:59:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so228774ywh.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Apr 2008 10:59:06 -0700 (PDT)
Message-ID: <8bd0f97a0804231059w76592878s3f6bf4a488b3ddea@mail.gmail.com>
Date: Wed, 23 Apr 2008 13:59:05 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
In-Reply-To: <8bd0f97a0804230905x19fd96aevc8f225d241e59369@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <20080422081211.e85989ec.randy.dunlap@oracle.com>
	 <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
	 <20080422152426.GG19802@phobos.i.cabal.ca>
	 <87a5b0800804220834q4d6daec1x4146d211115ab5c@mail.gmail.com>
	 <20080422153849.GH19802@phobos.i.cabal.ca>
	 <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
	 <20080423154038.GL19802@phobos.i.cabal.ca>
	 <87a5b0800804230850y4d577ff2taf1689f4af26b274@mail.gmail.com>
	 <8bd0f97a0804230905x19fd96aevc8f225d241e59369@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton@gmail.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>, Randy Dunlap <randy.dunlap@oracle.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080423175905.Ee0AqEcJJN69VHf4F4CmmPNHmQEX78pzZh5GH2ShdLc@z>

On Wed, Apr 23, 2008 at 12:05 PM, Mike Frysinger <vapier.adi@gmail.com> wrote:
> On Wed, Apr 23, 2008 at 11:50 AM, Will Newton <will.newton@gmail.com> wrote:
>  > On Wed, Apr 23, 2008 at 4:40 PM, Kyle McMartin <kyle@mcmartin.ca> wrote:
>  >  > On Wed, Apr 23, 2008 at 03:36:23PM +0100, Will Newton wrote:
>  >  >  > +config ARCH_HAS_SYS_SYSFS
>  >  >  > +     bool
>  >  >  > +     default y
>  >  >  > +
>  >  >  >  source "init/Kconfig"
>  >  >  >
>  >  >
>  >  >  Sorry, I meant something more like
>  >  >
>  >  >
>  >  >  config ARCH_HAS_SYS_SYSFS
>  >  >         def_bool !BLACKFIN
>  >  >         help
>  >  >           Obsolete sys_sysfs syscall
>  >  >
>  >  >  in init/Kconfig
>  >  >
>  >  >  But, it's your patch, you can do it however you like. :)
>  >
>  >  That's definitely shorter - but it feels a bit more like #ifdef
>  >  CONFIG_BLACKFIN which is explicitly what I don't want to do, because
>  >  I'm not actually interested in blackfin. ;-)
>
>  i'd have to agree that updating asm/unistd.h fits better with existing
>  paradigm.  if we want to talk about converting *all cases* to Kconfig,
>  we can do it in a separate thread.  splitting the design between two
>  different files is simply confusing to everyone involved as they spend
>  their time going "well which way am *i* supposed to do it".

thinking about this some more ... we actually have three choices here,
not just two.  checksyscalls.sh introduced a new form in asm/unistd.h:
#define __IGNORE_sysfs
perhaps we should be unifying the __ARCH_WANT_XXX and the __IGNORE_XXX
-mike
