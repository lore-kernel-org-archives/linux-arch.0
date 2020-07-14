Return-Path: <SRS0=Q31O=AZ=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgGNPdl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 11:33:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03348C061794
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:33:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so23330607ljl.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:33:40 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v24sm5363379lfo.4.2020.07.14.08.33.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:33:37 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e4so23315444ljn.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
 <20200714070955.GB776@lst.de>
In-Reply-To: <20200714070955.GB776@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Jul 2020 08:33:21 -0700
Message-ID: <CAHk-=wibed1S5_XMgjrUTOgUf0UOy1djm3e14c3YOm1Loj2vzw@mail.gmail.com>
Subject: Re: clean up address limit helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20200714153321.qUMBUevA10EKHSaz7hTG2H1QWqUQm0SLbV8r5ampQbE@z>

On Tue, Jul 14, 2020 at 12:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 10, 2020 at 08:25:35AM -0700, Linus Torvalds wrote:
> >
> > Ack. All the patches looked like no-ops to me, but with better naming
> > and clarity.
>
> Is that a formal Acked-by?

Yup, the patch series looks fine to me, and it looks like you fixed up
the things people noticed about off m68k behavior.

              Linus
