From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
Date: Mon, 1 Jul 2019 16:52:29 +0200
Message-ID: <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
References: <1561786601-19512-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561786601-19512-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <guoren@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> These codes are copied from glibc/string directory, they are the generic
> implementation for string operations. We may further optimize them with
> assembly code in the future.
>
> In fact these code isn't tested enough for kernel, but we've tested them
> on glibc and it seems good. We just trust them :)

Are these files from the architecture independent portion of glibc or
are they csky specific? If they are architecture independent, we might
want to see if they make sense for other architectures as well, and
add them to lib/ rather than arch/csky/lib/

Should the SPDX identifier list the original LGPL-2.1 license instead
of GPL-2.0?

       Arnd
