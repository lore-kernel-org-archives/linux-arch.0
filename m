From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Date: Mon, 29 May 2017 20:22:41 -0700
Message-ID: <CA+55aFzknOUqpSj_dtfebUuuk50g6NuaCxiM+DA0_5xs6=05fA@mail.gmail.com>
References: <20170529081103.29999-1-npiggin@gmail.com> <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
 <CA+55aFwofV0DZhh+yGH_=ceBzFcSr_tGexuGV4Wioao096R-uQ@mail.gmail.com> <20170530091343.1f98b24b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:34300 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdE3DWn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 23:22:43 -0400
In-Reply-To: <20170530091343.1f98b24b@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, May 29, 2017 at 4:13 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> *thin* archives does require binutils 2.19. That's nearly 10 years
> old, but we advertise 2.12 minimum at the moment.

I think we're ok with upgrading that. We've been allowing some
ridiculously old tools at times. I think "feature is 10 years old and
actively used by other projects" (Qt uses it from some googling, for
example) is more than sufficient.

If somebody has user space older than that, they presumably aren't
building new kernels either.

                     Linus
