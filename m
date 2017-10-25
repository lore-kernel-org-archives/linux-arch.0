From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: Re [PATCH v2] lib: optimize cpumask_next_and()
Date: Wed, 25 Oct 2017 18:50:14 +0300
Message-ID: <20171025155014.ppsu6hkwnhh3fjxp@yury-thinkpad>
References: <20171025145938.wpr7spsujounqudk@yury-thinkpad>
 <20171025152841.6746-1-courbet@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:30923
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750923AbdJYPud (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Oct 2017 11:50:33 -0400
Content-Disposition: inline
In-Reply-To: <20171025152841.6746-1-courbet@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Clement Courbet <courbet@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 25, 2017 at 05:28:41PM +0200, Clement Courbet wrote:
> Thanks for the comments Yury.
> 
> > But I'd like also to keep _find_next_bit() consistent with
> > _find_next_bit_le()
> 
> Not sure I understand what you're suggesting here: Do you want a
> find_next_and_bit_le() or do you want to make _find_next_bit_le() more
> like _find_next_bit() ? In the latter case we might just want to merge
> it with _find_next_bit() and end up with an extra is_le parameter :)

Both ways will work, but I think that extra is_le is too much.
_find_next_bit_le() should be the copy of _find_next_bit() with the
addition of swapping code.

If you don't need find_next_and_bit_le(), don't add it.
find_{first,last}_bit() doesn't have LE version, for example.

Yury
