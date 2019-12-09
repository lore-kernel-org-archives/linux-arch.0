Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:44862 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLISsc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 13:48:32 -0500
Received: by mail-io1-f67.google.com with SMTP id z23so15839591iog.11
        for <linux-arch@vger.kernel.org>; Mon, 09 Dec 2019 10:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20191209135823.28465-1-hch@lst.de>
In-Reply-To: <20191209135823.28465-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Dec 2019 10:48:20 -0800
Message-ID: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
Subject: Re: RFC: kill off ioremap_nocache
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mips <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20191209184820.wohVt5z50Zx85NlArfHFl3G3BhpHQ6APcxoQpi9lCso@z>

On Mon, Dec 9, 2019 at 5:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let me know what you think and if this is something acceptable for
> just after -rc1.

How many conflicts will this result in generally? I like it, but I'd
like to have some idea of whether it ends up being one of those
"really painful churn" things?

A couple of conflicts isn't an issue - they'll be trivial to fix. It's
the "this causes fifty silly conflicts" that I worry about, partly
because it then makes submaintainers inevitably do the wrong thing (ie
"I foresee an excessive amount of 'git rebase' rants next release").

Also, it looks like Google doesn't want this to happen. This whole
series was marked as spam for me.I'm not sure why, I don't see
anything odd that would trigger it, and DKIM and SPF both passed.
Maybe it's you, maybe it's Google, and maybe it's the infradead SRS
thing.

               Linus
