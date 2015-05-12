Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34922 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbbELGiI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2015 02:38:08 -0400
MIME-Version: 1.0
In-Reply-To: <1430752248-15401-1-git-send-email-johan@kernel.org>
References: <1430752248-15401-1-git-send-email-johan@kernel.org>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 12 May 2015 15:37:47 +0900
Message-ID: <CAAVeFuK35oXsrSsbdhGckjhfC=B6=aizqZYv2+0CQxAYQoYVGw@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] gpio: sysfs: fixes and clean ups
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@zh-kernel.org, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20150512063747.CxWh9XZZTqtfuYD-IgXQvtsEOsUVorRxKj-KaEDWdpc@z>

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
