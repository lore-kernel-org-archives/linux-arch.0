From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
Date: Mon, 11 Mar 2019 13:11:22 +0100
Message-ID: <CAK8P3a2w0B50Nb1gu6nJ2BJJsPFyOyXXOqn5SaTZnRBS=vD+Yg@mail.gmail.com>
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
 <20190102202938.GA26600@linux-8ccs> <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
 <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com> <20190311115523.GA30951@linux-8ccs>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311115523.GA30951@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
To: Jessica Yu <jeyu@kernel.org>
Cc: Mathias Krause <minipli@googlemail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 11, 2019 at 12:55 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Mathias Krause [10/03/19 20:26 +0100]:
> >Hi Jessica,
> >
> >On Mon, 21 Jan 2019 at 12:39, Mathias Krause <minipli@googlemail.com> wrote:
> >>
> >> On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
> >> >
> >> > +++ Mathias Krause [30/12/18 13:40 +0100]:
> >> > >The reference to '__vermagic' is a relict from v2.5 times. And even
> >> > >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
> >> > >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
> >> > >67ac5b866bda ("[PATCH] complete modinfo section")).
> >> > >
> >> > >Neither current kernels nor modules contain a '__vermagic' section any
> >> > >more, so get rid of it.
> >> > >
> >> > >Signed-off-by: Mathias Krause <minipli@googlemail.com>
> >> > >Cc: Rusty Russell <rusty@rustcorp.com.au>
> >> > >Cc: Jessica Yu <jeyu@kernel.org>
> >> >
> >> > Thanks for the cleanup.
> >> >
> >> > Reviewed-by: Jessica Yu <jeyu@kernel.org>
> >> >
> >>
> >> Arnd, will you carry this patch through your asm-generic tree or did
> >> the MAINTAINERS file mislead me here?
> >>
> >
> >looks like Arnd keeps ignoring my Emails. :/ Can you carry this patch
> >through your module tree? Or do you think I should ask Andrew Morton
> >instead?

Oops, sorry about this.

> Sure, I'll queue this up in modules-next shortly after the merge window.

Ok, thanks for picking it up!

     Arnd
