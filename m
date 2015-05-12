From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 00/23] gpio: sysfs: fixes and clean ups
Date: Tue, 12 May 2015 15:37:47 +0900
Message-ID: <CAAVeFuK35oXsrSsbdhGckjhfC=B6=aizqZYv2+0CQxAYQoYVGw@mail.gmail.com>
References: <1430752248-15401-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1430752248-15401-1-git-send-email-johan@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@zh-kernel.org, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, May 5, 2015 at 12:10 AM, Johan Hovold <johan@kernel.org> wrote:
> These patches fix a number of issues with the gpio sysfs interface,
> including
>
>  - fix memory leaks and crashes on device hotplug
>  - straighten out the convoluted locking
>  - reduce sysfs-interface latencies through more fine-grained locking
>  - more clearly separate the sysfs-interface implementation from gpiolib
>    core
>
> The first patch is marked for stable and could go into 4.1. [ May
> already have been applied but not pushed by Linus, but included in v2
> for completeness.  ]
>
> Unfortunately we can't just kill the gpio sysfs interface, but these
> patches will make it more manageable and should allow us to implement a
> new user-space interface while maintaining the old one (for a while at
> least) without losing our sanity.
>
> Note that there is still a race between chip remove and gpiod_request (and
> therefore sysfs export), which needs to be fixed separately (for instance as
> part of a generic solution to chip hotplugging).

Reiterating my

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

on this very nice series.
