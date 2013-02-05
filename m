From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/9] gpiolib: use gpio_chips list in sysfs ops
Date: Tue, 5 Feb 2013 18:15:54 +0100
Message-ID: <CACRpkdaC3pu3tBZrw0Az226XEt6+AzJ_NiiCaLwV9o6NUZ8MQw@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-6-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359822572-26009-6-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> This makes the code both simpler and faster compared to parsing the GPIO
> number space.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
