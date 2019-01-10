Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40540 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfAJLXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jan 2019 06:23:03 -0500
MIME-Version: 1.0
References: <1547045397-24388-1-git-send-email-guoren@kernel.org> <20190110081052.GB13262@guoren-Inspiron-7460>
In-Reply-To: <20190110081052.GB13262@guoren-Inspiron-7460>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 12:22:46 +0100
Message-ID: <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190110112246.wypGrFWcjxG5v96GnNbk3-ORE_NcXOxmNaMdC8yyEKI@z>

On Thu, Jan 10, 2019 at 9:11 AM Guo Ren <guoren@kernel.org> wrote:
>
> Sorry Linus,
>
> This pull-request is wrong on the patch:
> "csky: fixup module relocation error with 807 & 860".
> diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> -       uint16_t location_tmp = (uint16_t *)location;
> +       uint16_t *location_tmp = (uint16_t *)location;
>
> Please drop it if possible and I'll send another [GIT PULL].

It's already pulled into mainline, so it can't be undone, you have
to send a separate pull request, based on top of the patches
that got pulled.

       Arnd
