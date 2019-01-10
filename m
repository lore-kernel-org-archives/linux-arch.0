From: Guo Ren <guoren@kernel.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Thu, 10 Jan 2019 20:33:39 +0800
Message-ID: <20190110123339.GA15390@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190110081052.GB13262@guoren-Inspiron-7460>
 <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 10, 2019 at 12:22:46PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 10, 2019 at 9:11 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Sorry Linus,
> >
> > This pull-request is wrong on the patch:
> > "csky: fixup module relocation error with 807 & 860".
> > diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> > -       uint16_t location_tmp = (uint16_t *)location;
> > +       uint16_t *location_tmp = (uint16_t *)location;
> >
> > Please drop it if possible and I'll send another [GIT PULL].
> 
> It's already pulled into mainline, so it can't be undone, you have
> to send a separate pull request, based on top of the patches
> that got pulled.

Thx for the reply, I've sent a patch for it.

Best Regards
 Guo Ren
