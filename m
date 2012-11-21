From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 08/11] ARM: ux500: convert timer suspend/resume to clock_event_device
Date: Wed, 21 Nov 2012 09:14:22 +0100
Message-ID: <CACRpkdacsHS42S=vbb0NOoTj=odxUVAoDu+E4RRULWwh1McKrg@mail.gmail.com>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
	<1353349867-28494-9-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353349867-28494-9-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 19, 2012 at 7:31 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> Move ux500's timer suspend/resume functions from struct sys_timer
> ux500_timer into struct clock_event_device nmdk_clkevt. This
> will allow the sys_timer suspend/resume fields to be removed, and
> eventually lead to a complete removal of struct sys_timer.
>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

We have a comment on the .resume member but I'll find
the right patch and comment there.

Yours,
Linus Walleij
