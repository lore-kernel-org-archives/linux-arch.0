Return-Path: <SRS0=GDSS=AV=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgGJPZz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 11:25:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98BC08C5CE
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 08:25:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so3419841lfc.4
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 08:25:55 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r22sm2280302lfm.30.2020.07.10.08.25.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:25:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id j11so6904814ljo.7
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de>
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Jul 2020 08:25:35 -0700
Message-ID: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Subject: Re: clean up address limit helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20200710152535.SCaFXEcIm-9tBpLsbjRlamV6027trzMWNc3qgx6e8h4@z>

On Fri, Jul 10, 2020 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> in preparation for eventually phasing out direct use of set_fs(), this
> series removes the segment_eq() arch helper that is only used to
> implement or duplicate the uaccess_kernel() API, and then adds
> descriptive helpers to force the kernel address limit.

Ack. All the patches looked like no-ops to me, but with better naming
and clarity.

           Linus
