From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Break out types from <linux/list.h> to
	<linux/list_types.h>.
Date: Fri, 2 Jul 2010 13:19:11 -0600
Message-ID: <20100702191910.GA5842@parisc-linux.org>
References: <201007021811.04197.arnd@arndb.de> <201007021747.o62HlgmV019405@farm-0002.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40298 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0GBTTM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2010 15:19:12 -0400
Content-Disposition: inline
In-Reply-To: <201007021747.o62HlgmV019405@farm-0002.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Fri, Jul 02, 2010 at 01:41:14PM -0400, Chris Metcalf wrote:
> This allows a list_head (or hlist_head, etc.) to be used from places
> that used to be impractical, in particular <asm/processor.h>, which
> used to cause include file recursion: <linux/list.h> includes
> <linux/prefetch.h>, which always includes <asm/processor.h> for the
> prefetch macros, as well as <asm/system.h>, which often includes
> <asm/processor.h> directly or indirectly.

Why a new header file instead of linux/types.h?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
