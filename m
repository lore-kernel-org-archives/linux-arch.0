From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 10/11] ARM: remove struct sys_timer suspend and resume fields
Date: Wed, 21 Nov 2012 09:21:03 +0100
Message-ID: <CACRpkdYBfh49qxfAi6Kt74rVbqSRCioF6O=87gXrhzK=3YR6TQ@mail.gmail.com>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
	<1353349867-28494-11-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42133 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2KUIVE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Nov 2012 03:21:04 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so3309864vcm.19
        for <linux-arch@vger.kernel.org>; Wed, 21 Nov 2012 00:21:03 -0800 (PST)
In-Reply-To: <1353349867-28494-11-git-send-email-swarren@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On Mon, Nov 19, 2012 at 7:31 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> These fields duplicate e.g. struct clock_event_device's suspend and
> resume fields, so remove them now that nothing is using them. The aim
> is to remove all fields from struct sys_timer except .init, then replace
> the ARM machine descriptor's .timer field with a .init_time function
> instead, and delete struct sys_timer.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
