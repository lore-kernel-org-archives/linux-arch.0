From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Date: Tue, 3 Apr 2018 11:18:15 +0200
Message-ID: <CAMuHMdVZg8BL7D2eB-FnDbJabU3sfda6nOnaCdJj-3OC-+KP0g@mail.gmail.com>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
 <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com> <CAK8P3a2pdmLOHb2wkPVvqLDo71Rf3hLVfhG7vsMzaPD-DMEzSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2pdmLOHb2wkPVvqLDo71Rf3hLVfhG7vsMzaPD-DMEzSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 2, 2018 at 9:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 2, 2018 at 8:57 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> Regarding a possible revert, that would indeed involve reverting
> multiple patches for most architectures, plus parts of at least these
> three:
>
>   Documentation: arch-support: remove obsolete architectures
>   treewide: simplify Kconfig dependencies for removed archs
>   ktest: remove obsolete architectures
>
> For those, I went the other way, and removed all architectures at
> once to simplify my work and to avoid touching the same files up
> to eight times with interdependent patches (which couldn't
> be reverted without conflicts either).
>
> There are a couple of driver removal patches that got picked up
> into subsystem trees instead of this tree, so a full revert would also
> involve finding other drivers, but if you prefer to have the patches
> completely split up by arch, I could rework the series that way.

In reality, a resurrection may not be implemented as a pure revert, but as
the addition of a new architecture, implemented using modern features (DT,
CCF, ...).

Cfr. the resurrected arch/h8300, which doesn't have much in common with
the removed one:

$ git diff --stat v3.12..v4.2 -- arch/h8300
[...]
 197 files changed, 3155 insertions(+), 7849 deletions(-)

(for a total of ca. 6200 lines)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
