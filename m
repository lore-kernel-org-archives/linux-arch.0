Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45983 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfBKS2r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Feb 2019 13:28:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so8530429lfa.12
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2019 10:28:46 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a127sm2442836lfe.73.2019.02.11.10.28.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 10:28:43 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id g2so3262838lfh.11
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2019 10:28:43 -0800 (PST)
MIME-Version: 1.0
References: <1549861699-11875-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1549861699-11875-1-git-send-email-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Feb 2019 10:28:26 -0800
Message-ID: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190211182826.qXiNtb9b1cmpMgwqrq0CEstfrV0S95XK5CPo0Ae1ZjU@z>

On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
>
> arch/csky patches for 5.0-rc6

The bulk of this seems to be new hardware support code.

Please send it during the 5.1 merge window, not as fixes at post-rc6 time.

                 Linus
