From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
Date: Sat, 20 Jun 2020 11:16:35 -0700
Message-ID: <CAHk-=wjt=mTBqymWuRYeiXQxdEdf6si_it=Yzm7KR62ws0vknw@mail.gmail.com>
References: <20200618210645.GB2212102@localhost.localdomain>
 <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com> <20200620075732.GA468070@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgFTSRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jun 2020 14:17:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so15009789lji.1
        for <linux-arch@vger.kernel.org>; Sat, 20 Jun 2020 11:17:54 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d3sm1928689lfe.93.2020.06.20.11.16.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:16:51 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id o4so7375791lfi.7
        for <linux-arch@vger.kernel.org>; Sat, 20 Jun 2020 11:16:51 -0700 (PDT)
In-Reply-To: <20200620075732.GA468070@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>

On Sat, Jun 20, 2020 at 12:57 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > If you want to build the kernel with C++, you'd be a lot better off just doing
> >
> >    /* C++ braindamage */
> >    #define this __this
> >    #define new __new
> >
> > and deal with that instead.
>
> Can't do this because of placement new.

Can you explain?

> > Because no, the 'new' renaming will never happen, and while 'this'
> > isn't nearly as common or relevant a name, once you have the same
> > issue with 'new', what's the point of trying to deal with 'this'?
>
> I'm not sending "new".

My point about 'new' is that

 (a) there's a lot more 'new' than 'this'

 (b) without dealing with 'new', dealing with 'this' is pointless

So why bother? Without some kind of pre-processing phase to make our C
code palatable to a C++ parser, it will never work.

And if you _do_ have a pre-processing phase (which might be a #define,
but might also be a completely separate pass with some special tool),
converting 'this' in the kernel sources isn't useful anyway, because
you could just do it in the pre-processing phase instead.

See? THAT is why I'm harping on 'new'. Not because you sent me a patch
to deal with 'new', but because such a patch will never be accepted,
and without that patch the pain from 'this' seems entirely irrelevant.

What's your plan for 'new'? And why doesn't that plan then work for 'this'?

              Linus
