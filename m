Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36844 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761340Ab2ELAJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2012 20:09:00 -0400
Received: by dady13 with SMTP id y13so3683593dad.19
        for <linux-arch@vger.kernel.org>; Fri, 11 May 2012 17:08:59 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
In-Reply-To: <20120416081532.GA3238@opensource.wolfsonmicro.com>
References: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com> <CACRpkdZ8yH1ZSG-nQ9dLm0TipHS-jZDuxwqohUC=LGH9V-5q4w@mail.gmail.com> <20120416081532.GA3238@opensource.wolfsonmicro.com>
Date: Fri, 11 May 2012 18:08:53 -0600
Message-ID: <20120512000853.A96353E0791@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux@lists.openrisc.net, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>
Message-ID: <20120512000853.i5369RTPdBtc2h_DV8_6OXLHi9ybcIU0MxPa8ZGFQBs@z>

On Mon, 16 Apr 2012 09:15:32 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 16, 2012 at 09:21:58AM +0200, Linus Walleij wrote:
> 
> > This looks good but I think we need to page the alpha, ia64, m68k, microblaze,
> > openrisc etc subarch maintainers on this patch so they have their say.
> 
> That's why I CCed linux-arch, to get all the architecture maintainers
> included.  vger would get upset if I CCed everyone individually.

Meh; it's been long enough.  I'll build the major ones and then throw it into linux-next.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
