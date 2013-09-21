From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [RFC 1/5] gpiolib: factorize gpiod_get/set functions
Date: Sat, 21 Sep 2013 21:39:14 +0900
Message-ID: <CAAVeFu+mxhfK1rqO3jcx2FSJ4bCGjHDQ7ouSP1qK99RrMaHXjg@mail.gmail.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
 <1378294169-22661-2-git-send-email-acourbot@nvidia.com> <CACRpkdZrjM0cQm8AXNDnaSh2Tp5BVcevDUObFg87cUTEmJxc1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZrjM0cQm8AXNDnaSh2Tp5BVcevDUObFg87cUTEmJxc1w@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 20, 2013 at 5:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>
>> gpiod_get/set functions share common code between their regular and
>> cansleep variants. The exporting of the gpiod interface will make
>> the situation worse. This patch factorizes the common code to avoid code
>> redundancy.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> I don't see why this patch should be RFC?
>
> I just rebased and applied it, it's a clean and nice refactoring.

Oh yeah, I just sent it with the others, but please feel free to apply
it as-is. It should be fine.

Alex.
