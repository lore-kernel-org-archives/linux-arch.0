From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: Add driver to enable access to the user dynamic network.
Date: Fri, 2 Jul 2010 18:11:03 +0200
Message-ID: <201007021811.04197.arnd@arndb.de>
References: <201006252110.o5PLArvw010770@farm-0002.internal.tilera.com> <201006282134.55166.arnd@arndb.de> <4C2DD958.7030005@tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51767 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758967Ab0GBQLO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2010 12:11:14 -0400
In-Reply-To: <4C2DD958.7030005@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Friday 02 July 2010, Chris Metcalf wrote:
> So, if there's a good reason for it to be there, I'd say that pushes us
> back toward a separate <linux/list_types.h>.  Otherwise we can
> investigate splitting out the prefetch content on every platform to
> <asm/prefetch.h> (presumably creating some empty <asm/prefetch.h>
> headers on architectures that just use the gcc builtin) and adding new
> #includes of <asm/prefetch.h> to files that reference the prefetch
> functionality.  Arnd and other list folks, what's your instinct?

Makes sense. Splitting out the list types from list.h does seem to be
safest option. We might actually be able to do some header file
untangling that way, by using list_types.h in all headers that
use a list_head by none of the macros and functions associated with it.

	Arnd
