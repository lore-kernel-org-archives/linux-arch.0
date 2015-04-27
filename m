From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 00/23] gpio: sysfs: fixes and clean ups
Date: Mon, 27 Apr 2015 12:58:17 +0900
Message-ID: <CAAVeFu+fJk9TCXapNF=Vmwzh7oAHz+Lz6h+mJe75pws+-T6k8g@mail.gmail.com>
References: <1429630951-27082-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1429630951-27082-1-git-send-email-johan@kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@zh-kernel.org, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 22, 2015 at 12:42 AM, Johan Hovold <johan@kernel.org> wrote:
> These patches fix a number of issues with the gpio sysfs interface,
> including
>
>  - fix memory leaks and crashes on device hotplug
>  - straighten out the convoluted locking
>  - reduce sysfs-interface latencies through more fine-grained locking
>  - more clearly separate the sysfs-interface implementation from gpiolib
>    core
>
> The first patch is marked for stable and could go into 4.1.
>
> Unfortunately we can't just kill the gpio sysfs interface, but these
> patches will make it more manageable and should allow us to implement a
> new user-space interface while maintaining the old one (for a while at
> least) without losing our sanity.
>
> Note that there is still a race between chip remove and gpiod_request (and
> therefore sysfs export), which needs to be fixed separately (for instance as
> part of a generic solution to chip hotplugging).

Thanks a lot for this great series. To my embarrassment I could not
find anything big to say about it. It simply fixes some of the biggest
issues with the sysfs interface and makes things much more
maintainable.

I made a few minor comments, but globally I like this very much.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
