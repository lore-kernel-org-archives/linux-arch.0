From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 0/3] New descriptor-based GPIO interface
Date: Fri, 18 Oct 2013 13:23:36 +0200
Message-ID: <CACRpkdYx07Kfs6zOQmTg2cTSmEmsGgP=7wMCSG_30NW=dfYRPQ@mail.gmail.com>
References: <1382030498-23465-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382030498-23465-1-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 17, 2013 at 7:21 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Hi Linus,
>
> This version should merge as-is in your tree (I hope!). A patch for
> documentation will follow soon.
>
> Changes since v2:
> - rebased on top of Linus' for-next branch
> - exported new gpiod_(un)lock_as_irq() functions in driver.h
> - squashed a fix for a compilation error

Thanks, let's see if I can get this into v3.13, right now it's
unclear if I'll dare to do this. These do not apply right off
as it requires the late fixes to the gpiod code which currently
are in Torvalds' tree and on my fixes branch, so I'll merge in
v3.12-rc6 as it arrives, and then attempt to apply this on
top, but I don't know if I dare to do this so late.

The outage of linux-next also contributes to this situation.

We might have to take this as the first thing after the merge
window and targeted for v3.14.

Yours,
Linus Walleij
