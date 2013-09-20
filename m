From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 0/5] New descriptor-based GPIO interface
Date: Fri, 20 Sep 2013 10:28:32 +0200
Message-ID: <CACRpkdZz1VwVoEyO-nntKDx185oBO0xOs0kaozJ_6W0xN-2c9w@mail.gmail.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Another point that definitely needs more attention is the documentation. I am
> not sure whether the new interface should be described as a couple of sections
> in the existing GPIO documentation (the current approach) or as a new
> documentation file of its own.

The right way to do this would be to list the new way in the gpio.txt document,
then mark the old methods as deprecated.

Yours,
Linus Walleij
