From: Guo Ren <guoren@kernel.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Thu, 10 Jan 2019 20:35:41 +0800
Message-ID: <20190110123541.GB15390@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190110081052.GB13262@guoren-Inspiron-7460>
 <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
