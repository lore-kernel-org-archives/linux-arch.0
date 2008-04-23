Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:55917 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYDWPuh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2008 11:50:37 -0400
Received: by py-out-1112.google.com with SMTP id u52so4282503pyb.10
        for <linux-arch@vger.kernel.org>; Wed, 23 Apr 2008 08:50:36 -0700 (PDT)
Message-ID: <87a5b0800804230850y4d577ff2taf1689f4af26b274@mail.gmail.com>
Date: Wed, 23 Apr 2008 16:50:36 +0100
From: "Will Newton" <will.newton@gmail.com>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
In-Reply-To: <20080423154038.GL19802@phobos.i.cabal.ca>
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
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080423155036.uchIDuHmDdsSg7Om62q5cuPAxipC9lzhDpXW1Zeb7nA@z>

On Wed, Apr 23, 2008 at 4:40 PM, Kyle McMartin <kyle@mcmartin.ca> wrote:
> On Wed, Apr 23, 2008 at 03:36:23PM +0100, Will Newton wrote:
>  > +config ARCH_HAS_SYS_SYSFS
>  > +     bool
>  > +     default y
>  > +
>  >  source "init/Kconfig"
>  >
>
>  Sorry, I meant something more like
>
>
>  config ARCH_HAS_SYS_SYSFS
>         def_bool !BLACKFIN
>         help
>           Obsolete sys_sysfs syscall
>
>  in init/Kconfig
>
>  But, it's your patch, you can do it however you like. :)

That's definitely shorter - but it feels a bit more like #ifdef
CONFIG_BLACKFIN which is explicitly what I don't want to do, because
I'm not actually interested in blackfin. ;-)
