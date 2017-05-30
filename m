Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38052 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdE3Dym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 23:54:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170530091343.1f98b24b@roar.ozlabs.ibm.com>
References: <20170529081103.29999-1-npiggin@gmail.com> <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
 <CA+55aFwofV0DZhh+yGH_=ceBzFcSr_tGexuGV4Wioao096R-uQ@mail.gmail.com> <20170530091343.1f98b24b@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 May 2017 20:54:40 -0700
Message-ID: <CA+55aFwUV+uYokVEttfvJKHmmJFZQ_d_MbUKG8U1xscr0DWyEg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20170530035440.aKTBit-P9V2eJ0s5rAlKolC_2TE2CdGGaWJgLP8cOS4@z>

On Mon, May 29, 2017 at 4:13 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> We haven't run into any bugs AFAIK. It's been pretty solid.

I tried just changing the THIN_ARCHIVES "bool" into "def_bool y" to
test it on my laptop, and certainly saw neither build problems nor
problems with the resulting kernel image.

So honestly, I'd really rather just see the change happen
unconditionally, and finding problems much quicker and easier that way
(in addition to making the conversion much simpler and not asking
people odd questions).

                    Linus
