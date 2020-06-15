Return-Path: <SRS0=nbOu=74=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 07:11:35 -0400
MIME-Version: 1.0
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
 <20200614223456.13807a00@redhat.com> <5033402c-d95c-eecd-db84-75195b159fab@al2klimov.de>
In-Reply-To: <5033402c-d95c-eecd-db84-75195b159fab@al2klimov.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2020 13:11:22 +0200
Message-ID: <CAMuHMdVvYRzOA-cOj41_0g1OXw+xhJ29=FZNAL5v_fWsBjwm4g@mail.gmail.com>
Subject: Re: Good idea to rename files in include/uapi/ ?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Stefano Brivio <sbrivio@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, netdev <netdev@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20200615111122.9hj05VX1Rz8pWqDYqaU1uogeemnY4sogdjjyqlS_ZLU@z>

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
