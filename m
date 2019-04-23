Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDWSrs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Apr 2019 14:47:48 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0257D218D3
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 18:47:47 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id o12so18250742wrn.2
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 11:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
In-Reply-To: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 23 Apr 2019 11:47:34 -0700
Message-ID: <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190423184734.lFOXKUFYwCqKMwaJ8p3xgU2xgRGgH0KeIjwVFnEOC3U@z>

On Thu, Apr 18, 2019 at 1:08 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi.
>
> I have a question about 'vdso_install'.
>
>
> In my understanding, vdso is embedded in the kernel.
> In addition, you can run 'make vdso_install'
> to install an unstripped version of vdso.
> (Mainly, debugging purpose?)
>
> By default, 'make vdso_install' will install it to
> /lib/modules/$(uname -r)/vdso/.
>
>
> Since that directly is owned by root,
> 'make vdso_install' could potentially be
> executed by root, isn't it?
>
>
> Currently, 'vdso_install' depends on vdso,
> so it may cause recompilation of objects
> in the source tree.

Hmm.  I suppose an alternative would be for vdso_install to fail if
the vdso isn't built?

What's the ideal outcome here?
