Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36100 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2ROs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 13:14:48 -0400
MIME-Version: 1.0
References: <20180827194531.3796559-4-arnd@arndb.de> <20180829125052.GA114325@lkp-g5>
In-Reply-To: <20180829125052.GA114325@lkp-g5>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 29 Aug 2018 15:17:35 +0200
Message-ID: <CAK8P3a11PnCsDTfqk-7fVyntOw83vC3-6VPXq39wkK+3GtH=aw@mail.gmail.com>
Subject: Re: [Y2038] [RFC PATCH] y2038: __get_old_timespec32() can be static
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180829131735.cBeRhaGsBXH5DzpwNIH-lY-fv6bMNBwEuKkhZXpjFlA@z>

On Wed, Aug 29, 2018 at 2:52 PM kbuild test robot
<fengguang.wu@intel.com> wrote:
>
>
> Fixes: ee16c8f415e4 ("y2038: Globally rename compat_time to old_time32")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  time.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index f1983f4..e3a7f7f 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -863,7 +863,7 @@ int put_timespec64(const struct timespec64 *ts,
>  }
>  EXPORT_SYMBOL_GPL(put_timespec64);
>
> -int __get_old_timespec32(struct timespec64 *ts64,
> +static int __get_old_timespec32(struct timespec64 *ts64,
>                                    const struct old_timespec32 __user *cts)
>  {

This was caused by an older patch and we already get the same
warning in mainline linux, the bot triggered again after I renamed
it. Anyway, the fix is good, and I'll come up with a proper changelog
to include it in my series.

      Arnd
