Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:37794 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbYBNBsK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Feb 2008 20:48:10 -0500
Date: Thu, 14 Feb 2008 02:47:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
In-Reply-To: <20080213231512.GB20358@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0802140246440.1822@scrub.home>
References: <200802132330.23817.alessandro.guido@gmail.com>
 <20080213225058.GA20358@flint.arm.linux.org.uk> <200802140000.52936.alessandro.guido@gmail.com>
 <20080213231512.GB20358@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

Hi,

On Wed, 13 Feb 2008, Russell King wrote:

> > No because they all depend on CPU_FREQ and as far as I understand Kconfig
> > automagically puts them under the same menu.
> 
> Hmm, that's not documented behaviour.  If we're starting to rely on that
> maybe it should be documented as being the expected behaviour?

It is. :)
Look for "Menu structure" in kconfig-language.txt.

bye, Roman
