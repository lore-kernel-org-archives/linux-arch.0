From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Good idea to rename files in include/uapi/ ?
Date: Mon, 15 Jun 2020 13:12:00 +0200
Message-ID: <CAMuHMdWixiv2NBQ8_Yo5LVv0wXsPaRAvL2mWYWBDF4p2moh_Og@mail.gmail.com>
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37838 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 07:12:13 -0400
In-Reply-To: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>, coretea

Hi Alexander,

On Sun, Jun 14, 2020 at 9:44 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
> *Is it a good idea to rename files in include/uapi/ ?*

No it is not: include/uapi/ is append-only.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
