Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41441 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092AbXKOW4T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 17:56:19 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0711152312210.8650@anakin>
References: <Pine.LNX.4.64.0711152312210.8650@anakin> <20071115090215.GA20612@uranus.ravnborg.org> <20071115122151.GA10359@Krystal> <20071115181451.GA23914@uranus.ravnborg.org>
Subject: Re: HAVE or ARCH_HAS or ARCH_SUPPORTS and use of select
Date: Thu, 15 Nov 2007 22:56:14 +0000
Message-ID: <16614.1195167374@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, Sam Ravnborg <sam@ravnborg.org>, Mathieu Desnoyers <compudj@krystal.dyndns.org>, linux arch <linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
List-ID: <linux-arch.vger.kernel.org>

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > 2) An architecture uses a specific functionality
> >    Examples: MMU
> 
> That's always been just CONFIG_MMU.

And can be variable within an arch.

David
