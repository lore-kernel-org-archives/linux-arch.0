Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfAJMfr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 07:35:47 -0500
Date: Thu, 10 Jan 2019 20:35:41 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110123541.GB15390@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190110081052.GB13262@guoren-Inspiron-7460>
 <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190110123541.glCx3fiPiYrlGVxw5cyZNCODUsqbHvx-eNwCPcPUWS8@z>

On Thu, Jan 10, 2019 at 03:59:22AM -0800, Linus Torvalds wrote:
> On Thu, Jan 10, 2019 at 12:11 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > This pull-request is wrong on the patch:
> > "csky: fixup module relocation error with 807 & 860".
> > diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> > -       uint16_t location_tmp = (uint16_t *)location;
> > +       uint16_t *location_tmp = (uint16_t *)location;
> >
> > Please drop it if possible and I'll send another [GIT PULL].
> 
> Too late, already pulled.
> 
> Send a patch, and I'll apply it. Or send a pull request with updates
> if there's more than that oneliner..
Thx, I've sent a patch for you:
"[PATCH V2] csky: fixup compile error with CPU 810."

Best Regards
 Guo Ren
