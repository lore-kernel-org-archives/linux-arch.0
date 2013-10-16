From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 3/3] gpiolib: add gpiod_get() and gpiod_put() functions
Date: Wed, 16 Oct 2013 09:10:07 -0700
Message-ID: <525EBA5F.5080608@nvidia.com>
References: <1381515273-25466-1-git-send-email-acourbot@nvidia.com>	<1381515273-25466-4-git-send-email-acourbot@nvidia.com>	<52587C37.3070606@nvidia.com> <CACRpkdZTqZKyG3Lbs_GmdnqB0yEjRApsaUhJA9-s_uPb_Wrq8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZTqZKyG3Lbs_GmdnqB0yEjRApsaUhJA9-s_uPb_Wrq8A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "gnurou@gmail.com" <gnurou@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/16/2013 04:37 AM, Linus Walleij wrote:
> On Sat, Oct 12, 2013 at 12:31 AM, Alex Courbot <acourbot@nvidia.com> wrote:
>>> +#else
>>> +static struct device_node *of_find_gpio(struct device *dev, const char *id
>>> +                                     unsigned int idx, unsigned long flags)
>>> +{
>>> +     return ERR_PTR(-ENODEV);
>>> +}
>>> +#endif
>>
>> ... and of course I forgot to fix the main compilation error. Linus,
>> would you mind squashing what follows into this patch? Apologies for
>> the inconvenience.
>
> I guess you'll fix this if you respin it?
>
> If it's too much trouble now we can just defer this for early in the v3.14
> cycle.

No problem, I will try to rebase on top of your for-next, and squash 
this today.

Thanks,
Alex.
