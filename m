Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0057.outbound.protection.outlook.com ([104.47.37.57]:52352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932095AbdJYRmG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Oct 2017 13:42:06 -0400
Date: Wed, 25 Oct 2017 20:41:46 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: Re [PATCH v2] lib: optimize cpumask_next_and()
Message-ID: <20171025174146.577ar6igqpkcbzin@yury-thinkpad>
References: <20171025145938.wpr7spsujounqudk@yury-thinkpad>
 <20171025152841.6746-1-courbet@google.com>
 <20171025155014.ppsu6hkwnhh3fjxp@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171025155014.ppsu6hkwnhh3fjxp@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Clement Courbet <courbet@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20171025174146._0UliqjoyFG0bm0DVwSnPaTb-HE55M2g_54RKcz4Q4g@z>

On Wed, Oct 25, 2017 at 06:50:14PM +0300, Yury Norov wrote:
> On Wed, Oct 25, 2017 at 05:28:41PM +0200, Clement Courbet wrote:
> > Thanks for the comments Yury.
> > 
> > > But I'd like also to keep _find_next_bit() consistent with
> > > _find_next_bit_le()
> > 
> > Not sure I understand what you're suggesting here: Do you want a
> > find_next_and_bit_le() or do you want to make _find_next_bit_le() more
> > like _find_next_bit() ? In the latter case we might just want to merge
> > it with _find_next_bit() and end up with an extra is_le parameter :)
> 
> Both ways will work, but I think that extra is_le is too much.
> _find_next_bit_le() should be the copy of _find_next_bit() with the
> addition of swapping code.
> 
> If you don't need find_next_and_bit_le(), don't add it.
> find_{first,last}_bit() doesn't have LE version, for example.

Few comments more.

_find_next_bit is now referenced also by find_next_and_bit(), and
so it should be added to guard code:

#if !defined(find_next_bit) || !defined(find_next_zero_bit)
        || !defined(find_next_and_bit)
static unsigned long _find_next_bit( ... )
{
        ...
}
#endif

It may be essential at least for arm.

Don't forget to synchronize your changes with
tools/lib/find_bit.c

Thanks,
Yury
