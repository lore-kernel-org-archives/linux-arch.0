From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Tue, 30 May 2017 13:55:36 +1000
Message-ID: <20170530135536.4d6a5f74@roar.ozlabs.ibm.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
        <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
        <CA+55aFwofV0DZhh+yGH_=ceBzFcSr_tGexuGV4Wioao096R-uQ@mail.gmail.com>
        <20170530091343.1f98b24b@roar.ozlabs.ibm.com>
        <CA+55aFzknOUqpSj_dtfebUuuk50g6NuaCxiM+DA0_5xs6=05fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36808 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdE3Dzt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 23:55:49 -0400
In-Reply-To: <CA+55aFzknOUqpSj_dtfebUuuk50g6NuaCxiM+DA0_5xs6=05fA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, 29 May 2017 20:22:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, May 29, 2017 at 4:13 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > *thin* archives does require binutils 2.19. That's nearly 10 years
> > old, but we advertise 2.12 minimum at the moment.  
> 
> I think we're ok with upgrading that. We've been allowing some
> ridiculously old tools at times. I think "feature is 10 years old and
> actively used by other projects" (Qt uses it from some googling, for
> example) is more than sufficient.

Well we might have to. I couldn't make thick archives work easily
because we have multiple levels of built-in.o, and with thick you
get an archive of an archive which the linker does not understand.
Fixing that would mean unpacking the archive and repacking it for
every built-in.o input you link -- too painful.

I suspect Google uses the format internally too because they added
the initial support.

https://sourceware.org/ml/binutils/2008-03/msg00150.html

Support has been pervasively added to binutils -- nm, objdump, ld,
etc. I think it falls into the category of well supported.

> 
> If somebody has user space older than that, they presumably aren't
> building new kernels either.

Yeah I think it's reasonable to drop support for such old toolchain
if we have a reason for it.

I'll send a patch to 0day and if that passes, I'll see if it's
something Stephen would put into linux-next.

Thanks,
Nick
