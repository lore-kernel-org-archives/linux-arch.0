From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/7] clocksource: Rename clksrc
Date: Sun, 28 May 2017 15:51:04 +0200
Message-ID: <CACRpkdYqs8+5X7FZ0LKWQ11-nmH0UaqTUrav7argE8cgpEE+uQ@mail.gmail.com>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36828 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE1NvG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 May 2017 09:51:06 -0400
Received: by mail-io0-f169.google.com with SMTP id o12so29867529iod.3
        for <linux-arch@vger.kernel.org>; Sun, 28 May 2017 06:51:05 -0700 (PDT)
In-Reply-To: <1495879129-28109-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The table name is now renamed to 'timer' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
