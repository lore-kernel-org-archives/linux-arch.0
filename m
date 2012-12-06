From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] gpiolib: introduce descriptor-based GPIO interface
Date: Thu, 6 Dec 2012 21:19:47 +0100
Message-ID: <CACRpkdY3mJL00e0Yq7RBRyHxR9AKMTj7um4Upq3Mh2kxMPqdww@mail.gmail.com>
References: <1354779918-4028-1-git-send-email-acourbot@nvidia.com>
	<1354779918-4028-2-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354779918-4028-2-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gnurou@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 6, 2012 at 8:45 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> With the current API, GPIOs are manipulated through an integer which
> represents their unique number across the system. This poses problems in
> terms of portability, scalability and flexibility: for instance, the
> number of valid GPIOs for a given system is fixed at system time, and a
> large array of that size is statically allocated to hold the GPIO
> descriptors. Worse, GPIOs can be used without being properly allocated.
>
> In order to improve the situation, the integer namespace must first get
> away. This patch introduces an alternative GPIO API that uses opaque
> handlers and refactor gpiolib's internals to work with these handlers
> instead of GPIO numbers. The former integer-based API is still available
> as a light wrapper around this new API.
>
> This first step will then us to build more improvements for gpiolib,
> like proper GPIO lookup functions per device and provider, and getting
> rid of the static GPIO array and the ARCH_NR_GPIO configuration option.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

I really like this. It is looking very good.

Especially it's nice that it makes GPIO descriptors the norm
rather than a bolt-on, and the old linear GPIO space is turned
into a comaptibility layer using static inlines.

I'd like to see some love for Documentation/gpio.txt to reflect
the changes, plus considering Grants note, and I will be happy
to add Reviewed-by on this.

Especially the lookups will be nice to see going forward!

Yours,
Linus Walleij
