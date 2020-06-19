Return-Path: <SRS0=lJ0G=AA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbgFSTxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 15:53:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F8C06174E
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 12:53:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so4863565pfd.6
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 12:53:49 -0700 (PDT)
Date: Fri, 19 Jun 2020 12:53:46 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
Message-ID: <202006191253.B00874B22@keescook>
References: <202006191236.AC3E22AAB@keescook>
 <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>, Will Drewry <wad@chromium.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200619195346.q8Kyuw7lAHr9bERSjODZqkRlWgBHJCNDb1Unf3y0q-s@z>

On Fri, Jun 19, 2020 at 12:42:14PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 19, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The terminator for the mode 1 syscalls list was a 0, but that could be
> > a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
> > listed first and the loop construct would not test it, so there was no
> > bug. However, this is fragile. Replace the terminator with -1 instead,
> > and make the variable name for mode 1 syscall lists more descriptive.
> 
> Could the architecture instead supply the length of the list?

It could, but I didn't like the way the plumbing for that looked.

-- 
Kees Cook
