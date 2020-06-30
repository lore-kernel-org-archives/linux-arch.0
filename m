From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
Date: Tue, 30 Jun 2020 14:25:08 +0100
Message-ID: <20200630132508.GF2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
 <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
 <20200629203028.GB2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgF3NZO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2020 09:25:14 -0400
Content-Disposition: inline
In-Reply-To: <20200629203028.GB2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

On Mon, Jun 29, 2020 at 09:30:28PM +0100, Al Viro wrote:

> >  (b) or just call it something better to begin with. Maybe just
> > "get_regset" instead?
> 
> <nod>
> 
> Frankly, other field names there are also nasty - 'set' is not
> fun to grep for, but there are 'n' and 'size' as well.  There's
> also 'bias'  and 'align' (both completely unused)...

How about ->regset_get()?  I've force-pushed a variant with that change +
removal of leftover unused variables (caught by Intel build bot) +
braino fix in sparc conversion (spotted when looking through the
patchset again); same branch names.  Not sure if it's worth a repost
of the entire patchbomb...
