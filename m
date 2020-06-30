From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
Date: Tue, 30 Jun 2020 09:53:12 -0700
Message-ID: <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk> <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
 <20200629203028.GB2786714@ZenIV.linux.org.uk> <20200630132508.GF2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgF3Qxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2020 12:53:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFFC061755
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2020 09:53:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so18833854lji.12
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2020 09:53:32 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h15sm894536ljk.24.2020.06.30.09.53.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d21so11796566lfb.6
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
In-Reply-To: <20200630132508.GF2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

On Tue, Jun 30, 2020 at 6:25 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How about ->regset_get()?

Sounds good to me. And if you ever do something similar for 'set', you
have a natural name to pick.

No need to repost as far as I'm concerned if it's just the name change
and some minor nots found by the bots.

                     Linus
