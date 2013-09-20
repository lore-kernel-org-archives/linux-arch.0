From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 0/5] New descriptor-based GPIO interface
Date: Fri, 20 Sep 2013 20:06:00 +0200
Message-ID: <CACRpkdYjkDf7c9VxfDTHtFx_upWWRAK8vpXTkrkrRsMjErq1dQ@mail.gmail.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Here is a first RFC for the new GPIO interface.

I'm quite happy with this, and given that all DT-implementations will start
to use it from day 1 I'll happily merge it when you think it's tested enough.

On my wishlist is to also switch over the ACPI GPIO driver:
drivers/gpio/gpiolib-acpi.c to use the descriptors directly, so
I'd like one of the ACPI folks to have a look at this patch set
and see how it looks from their angle.

Mika, Rafael, Mathias, and either of you guys have a look
at this?

Yours,
Linus Walleij
