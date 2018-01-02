From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] xtensa: shut up gcc-8 warnings
Date: Tue, 2 Jan 2018 03:29:17 -0800
Message-ID: <CAMo8BfL8xqpjQ-LuFZG5J_RbaqiLLpBcQTuE55XkCTvw=+zhrg@mail.gmail.com>
References: <20180102110035.1806925-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40110 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeABL3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 06:29:18 -0500
In-Reply-To: <20180102110035.1806925-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Jan 2, 2018 at 3:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Many uses of strncpy() on xtensa causes  a warning like
>
> arch/xtensa/include/asm/string.h:56:42: warning: array subscript is above array bounds [-Warray-bounds]
>    : "0" (__dest), "1" (__src), "r" (__src+__n)
>
> This avoids the warning by turning the pointer arithmetic into an
> integer operation that does not get checked the same way.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/xtensa/include/asm/string.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my xtensa tree.

-- Max
