From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
Date: Sun, 26 Jul 2020 12:00:37 +0300
Message-ID: <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
References: <20200726031154.1012044-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZJAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 05:00:54 -0400
In-Reply-To: <20200726031154.1012044-1-shorne@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Wei Xu <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
>
> The return type of functions _inb, _inw and _inl are all u16 which looks
> wrong.  This patch makes them u8, u16 and u32 respectively.
>
> The original commit text for these does not indicate that these should
> be all forced to u16.

Is it in alight with all architectures? that support this interface natively?

(Return value is arch-dependent AFAIU, so it might actually return
16-bit for byte read, but I agree that this is weird for 32-bit value.
I think you have elaborate more in the commit message)

-- 
With Best Regards,
Andy Shevchenko
