From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Good idea to rename files in include/uapi/ ?
Date: Mon, 15 Jun 2020 13:11:22 +0200
Message-ID: <CAMuHMdVvYRzOA-cOj41_0g1OXw+xhJ29=FZNAL5v_fWsBjwm4g@mail.gmail.com>
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
 <20200614223456.13807a00@redhat.com> <5033402c-d95c-eecd-db84-75195b159fab@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <5033402c-d95c-eecd-db84-75195b159fab@al2klimov.de>
Sender: netdev-owner@vger.kernel.org
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Stefano Brivio <sbrivio@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>NetFilter <netf>
List-Id: linux-arch.vger.kernel.org

Hi Alexander,

On Mon, Jun 15, 2020 at 1:11 AM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
> Am 14.06.20 um 22:34 schrieb Stefano Brivio:
> > On Sun, 14 Jun 2020 21:41:17 +0200
> >> Also even on a case-sensitive one VIm seems to have trouble with editing
> >> both case-insensitively equal files at the same time.
> >
> > ...what trouble exactly?
> vi -O2 include/uapi/linux/netfilter/xt_CONNMARK.h
> include/uapi/linux/netfilter/xt_connmark.h
>
> ... opens the first file two times.

Works fine for me, using vim 2:8.0.1453-1ubuntu1.3.
You must be using a buggy version.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
