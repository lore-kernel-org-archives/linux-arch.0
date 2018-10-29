Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41698 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJ3AxB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2018 20:53:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so2266684ljb.8
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2018 09:03:47 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p19-v6sm579421ljb.47.2018.10.29.09.03.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:03:44 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id x85-v6so4137830ljb.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2018 09:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Oct 2018 09:03:27 -0700
Message-ID: <CAHk-=whq5ebFd2CKE0bybLOY7ttMPxGiXF3WkzFXtkYhAbJqSg@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, Peter Zijlstra <peterz@infradead.org>, robh@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
Message-ID: <20181029160327.iy5i-sFTEDLpOa8BTQmBXMtcbR_ExX2RrIQtCMBiZUM@z>

On Fri, Oct 26, 2018 at 9:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> Release, which has been through 10 rounds of review on mailing list.
>
> We almost got the Acked-by/Reviewed-by of all patches except "Process
> management and Signal", but all've been tested.

Pulled,

                    Linus
