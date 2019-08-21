From: Matthias Maennich <maennich-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 11/11] RFC: watchdog: export core symbols in
 WATCHDOG_CORE namespace
Date: Wed, 21 Aug 2019 17:28:12 +0100
Message-ID: <20190821162812.GB77665@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-12-maennich@google.com>
 <20190821145911.GA6521@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190821145911.GA6521-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Tomas Winkler <tomas.winkler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, michal.lkml-yyZNWGI4GtDR7s880joybQ@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-aspeed-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, Thierry Reding <thierry.redin>
List-Id: linux-arch.vger.kernel.org

Hi Guenter!

On Wed, 21 Aug, 07:59, Guenter Roeck wrote:
>On Wed, Aug 21, 2019 at 12:49:26PM +0100, Matthias Maennich wrote:
>> Modules using these symbols are required to explicitly import the
>> namespace. This patch was generated with the following steps and serves
>> as a reference to use the symbol namespace feature:
>>
>>  1) Use EXPORT_SYMBOL_NS* macros instead of EXPORT_SYMBOL* for symbols
>>     in watchdog_core.c
>>  2) make  (see warnings during modpost about missing imports)
>>  3) make nsdeps
>>
>> I used 'allmodconfig' for the above steps to ensure all occurrences are
>> patched.
>>
>> Defining DEFAULT_SYMBOL_NAMESPACE in the Makefile is not trivial in this
>> case as not only watchdog_core is defined in drivers/watchdog/Makefile.
>> Hence this patch uses the variant of using the EXPORT_SYMBOL_NS* macros
>> to export into a different namespace.
>>
>I don't have the context, and thus I am missing the point of this patch
>set. Whatever it is supposed to accomplish, it seems extreme to me
>to require extra code in each driver for it.
>

Unfortunately, get_maintainer.pl has helped me too much and this series
got blocked by some mailing lists due to the large amount of recipients.
Following versions will be sent to the previous audience + the
linux-watchdog list.
For context, the full series (including previous versions) can be found
on lore at
https://lore.kernel.org/lkml/20180716122125.175792-1-maco-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org/
and the cover letter for v3 has made it to linux-amlogic
https://lore.kernel.org/linux-amlogic/20190821114955.12788-1-maennich-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org/

>Anyway, WATCHDOG_CORE would be the default namespace (if it is what
>I think it is) for watchdog drivers, even though not all watchdog drivers
>use it. As such, I am missing an explanation why defining it in Makefile
>is not trivial. "... as not only watchdog_core is defined in
>drivers/watchdog/Makefile" does not mean anything to me and is not a real

True, that is a bit out of context. Especially considering you did not
receive any other messages of that series.
Defining a namespace a symbol should be exported to can be done in
different ways. All of them effectively change the EXPORT_SYMBOL*
macro's behaviour. The method I am referring to is using

  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=WATCHDOG_CORE

directly in drivers/watchdog/Makefile. Since this would also apply the
namespace to exports in non-core modules it would be incorrect. Thus I
used the method of applying the namespace directly by changing the
EXPORT_SYMBOL macro expansion.

>explanation. Also, it is not immediately obvious to me why "select
>WATCHDOG_CORE" in Kconfig would not automatically imply that WATCHDOG_CORE
>is used by a given driver, and why it is impossible to use that
>information to avoid the per-driver changes.
>

One intention of this patch series is to make exporting and using of
namespaces explicit. As such, the subsystem exporting symbols is
defining the namespace it exports to and the module using a namespace is
supposed to explicitly declare its usage via import. In case of watchdog
(and probably other cases) it might make sense to find a way to
implicitly import the namespace for in-tree drivers in the same area.

>I am also missing an explanation why WATCHDOG_CORE is going to be a
>separate namespace to start with. Maybe that discussion has happened,
>but I don't recall being advised or asked or told about it. Are we also
>going to have a new HWMON_CORE namespace ? And the same for each other
>subsystem in the kernel ?
>

This very patch is an RFC to demonstrate how Symbol Namespaces would be
used based on the current implementation (the other RFC as part of this
series is for the introduction of the namespace USB_STORAGE).
WATCHDOG_CORE serves as one of two examples. I do not think the two RFC
patches should be merged along with this series.

>Since this is being added to the watchdog API, it will have to be
>documented accordingly. Watchdog driver writers, both inside and outside
>the watchdog subsystem, will need to know that they now have to add an
>additional boilerplate declaration into their drivers.
>

Completely agree. This is just an RFC that omits these details as it
purely focuses on the introduction and consequences of such a namespace
to demonstrate how the feature works.

>Last but not least, combining patches affecting multiple subsystems in a
>single patch will make it difficult to apply and will likely result in
>conflicts. Personally I would prefer a split into one patch per affected
>subsystem. Also, please keep in mind that new pending watchdog drivers
>won't have the new boilerplate.

I understand the point. Especially as I am already now affected by the
long list of recipients when sending this patch. The problem with single
patches here is, that once a symbol is exported into a namespace, all
modules using it have to declare that import to avoid a warning at
compile time and module load time. Hence the all-in-one approach.
Luckily, the patch series also provides a way to address such a warning
(via `make nsdeps`) that creates the necessary source code fix as a
single line per module and namespace right after MODULE_LICENSE(). That
is how this patch was created in the first place.

Cheers,
Matthias
