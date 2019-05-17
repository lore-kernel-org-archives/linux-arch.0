From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
Date: Fri, 17 May 2019 10:54:42 +0200
Message-ID: <CAMuHMdU0N9j2TRtJwJx5uxE2ScFnB-MRrd9hzaXJmwTuY4Ldzw@mail.gmail.com>
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
 <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com> <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Linus,

On Fri, May 17, 2019 at 12:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, May 16, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I have reconfigured it locally now and pushed an identical tag with a
> > new signature. Can you see if that gives you the same warning if you
> > try to pull that?
>
> No, same issue:
>
>    [torvalds@i7 linux]$ git fetch
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
> tags/asm-generic-nommu
>    From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
>     * tag                         asm-generic-nommu -> FETCH_HEAD
>    [torvalds@i7 linux]$ git verify-tag FETCH_HEAD
>    gpg: Signature made Thu 16 May 2019 01:28:54 PM PDT
>    gpg:                using RSA key 60AB47FFC9095227
>    gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
> (0x00, 0x4)
>    gpg: Can't check signature: Wrong key usage

Works fine here.

Oh, I do have the recommended cronjob:
https://www.kernel.org/doc/html/latest/process/maintainer-pgp-guide.html#set-up-a-refresh-cronjob

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
