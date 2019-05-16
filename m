From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
Date: Thu, 16 May 2019 22:33:59 +0200
Message-ID: <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 16, 2019 at 8:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 16, 2019 at 5:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> > tags/asm-generic-nommu
>
> Interesting. I haven't seen this error before:
>
>   # gpg: Signature made Tue 23 Apr 2019 12:54:49 PM PDT
>   # gpg:                using RSA key 60AB47FFC9095227
>   # gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
> (0x00, 0x4)
>   # gpg: Can't check signature: Wrong key usage
>
> I think it means that you signed it with a key that was marked for
> encryption only or something like that.
>
> But gpg being the wonderful self-explanatory great UX that it is, I
> have no effin clue what it really means.

Same here.

> Looking at the git history, it turns out this has happened a before
> from you, and in fact goes back to pull requests from 2012.
>
> Either I just didn't notice - which sounds unlikely for something that
> has been going on for 7+ years - or the actual check and error is new
> to gpg, and I only notice it this merge window because I've upgraded
> to F30.

I have reconfigured it locally now and pushed an identical tag with a
new signature. Can you see if that gives you the same warning if you
try to pull that?

      Arnd
