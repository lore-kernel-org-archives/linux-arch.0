From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Thu, 10 Jan 2019 12:22:46 +0100
Message-ID: <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org> <20190110081052.GB13262@guoren-Inspiron-7460>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110081052.GB13262@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <guoren@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
