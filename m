Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46125 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfAJL7m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jan 2019 06:59:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so8074925lfg.13
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 03:59:40 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u12-v6sm15275807ljk.79.2019.01.10.03.59.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 03:59:38 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id p6so8121707lfc.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 03:59:38 -0800 (PST)
MIME-Version: 1.0
References: <1547045397-24388-1-git-send-email-guoren@kernel.org> <20190110081052.GB13262@guoren-Inspiron-7460>
In-Reply-To: <20190110081052.GB13262@guoren-Inspiron-7460>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jan 2019 03:59:22 -0800
Message-ID: <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190110115922.FY1wug5rIA5nNqu_TmUm1k2hBNbKDmwI7HnXZcWWKnQ@z>

On Thu, Jan 10, 2019 at 12:11 AM Guo Ren <guoren@kernel.org> wrote:
>
> This pull-request is wrong on the patch:
> "csky: fixup module relocation error with 807 & 860".
> diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> -       uint16_t location_tmp = (uint16_t *)location;
> +       uint16_t *location_tmp = (uint16_t *)location;
>
> Please drop it if possible and I'll send another [GIT PULL].

Too late, already pulled.

Send a patch, and I'll apply it. Or send a pull request with updates
if there's more than that oneliner..

                 Linus
