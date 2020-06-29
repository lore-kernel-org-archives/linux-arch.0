From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
Date: Mon, 29 Jun 2020 12:23:34 -0700
Message-ID: <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732336AbgF2TXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:23:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E56C03E979
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:23:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so19481928ljg.13
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:23:53 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r25sm120727lfi.70.2020.06.29.12.23.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:23:51 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q7so6275008ljm.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:23:50 -0700 (PDT)
In-Reply-To: <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

On Mon, Jun 29, 2020 at 11:28 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->get2() takes task+regset+buffer, returns the amount of free space
> left in the buffer on success and -E... on error.

Can we please give it a better name than "get2"?

That's not a great name to begin with, and it's a completely
nonsensical name by the end of this series when you've removed the
original "get" function.

So either:

 (a) add one final patch to rename "get2" all back to "get" after you
got rid of the old "get"

 (b) or just call it something better to begin with. Maybe just
"get_regset" instead?

I'd prefer (b) just because I think it will be a lot clearer if we
ever end up having old patches forward-ported (or, more likely,
newpatches back-ported), so having a "get" function that changed
semantics but got back the old name sounds bad to me.

Other than that, I can't really argue with the numbers:

 41 files changed, 1368 insertions(+), 2347 deletions(-)

looks good to me, and the code seems more understandable.

But I only scanned the individual patches, maybe I missed some other horror.

               Linus
