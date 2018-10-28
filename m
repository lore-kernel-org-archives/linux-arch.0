Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34236 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeJ2F5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2018 01:57:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id g8-v6so2956886ljk.1
        for <linux-arch@vger.kernel.org>; Sun, 28 Oct 2018 14:11:49 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z195-v6sm2823378lff.82.2018.10.28.14.11.46
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 14:11:47 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p86so2329741lfg.5
        for <linux-arch@vger.kernel.org>; Sun, 28 Oct 2018 14:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Oct 2018 14:11:30 -0700
Message-ID: <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, Peter Zijlstra <peterz@infradead.org>, robh@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
Message-ID: <20181028211130.s0J2Au0-39GBOVm9DnMVnuYGTA5cBvnyVr6QokhXuiM@z>

Arnd,
 I was kind of hoping/expecting to get an explicit ack for this from
you, since it's a new architecture.

Good to merge?

              Linus

On Fri, Oct 26, 2018 at 9:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> Release, which has been through 10 rounds of review on mailing list.
>
> We almost got the Acked-by/Reviewed-by of all patches except "Process
> management and Signal", but all've been tested.
