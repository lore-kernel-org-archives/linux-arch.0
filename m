Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44598 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHVJ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Mar 2019 16:09:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so15005122pff.11
        for <linux-arch@vger.kernel.org>; Fri, 08 Mar 2019 13:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
 <20190307164647.GC25101@redhat.com> <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
 <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com> <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
In-Reply-To: <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 8 Mar 2019 13:09:47 -0800
Message-ID: <CAKwvOd=+_FjWmo2McyLOAL3r6JOuu1wZEzQknY-GToDnCwzhsQ@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
Message-ID: <20190308210947.4oLXx1MSbOv9Yj3GFPxYuNjjDMGLGeHzgx8qITqj-30@z>

On Thu, Mar 7, 2019 at 4:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-03-07 at 16:22 -0800, Nick Desaulniers wrote:
> > On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > I'd have to try, but I think you are right. It was probably an
> > > overoptimization back in 1997 when the code got added to
> > > linux-2.1.68pre1, and compilers have become smarter in the
> > > meantime ;-)
> >
> > How do you track history pre-git (2.6.XX)?
>
> https://landley.net/kdocs/fullhist/

Ah neat! Thanks for the link.  Now to wire that up to fugitive:
http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/

The LLVM project recently switched to git from svn.  For quite some
time the move was delayed in order to preserve history (including for
parked release branches and all kinds of edge cases and things that
don't quite translate from svn to git).  Now I better appreciate the
history preservation.
-- 
Thanks,
~Nick Desaulniers
