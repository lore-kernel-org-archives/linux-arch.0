From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
Date: Tue, 25 Sep 2018 18:02:25 +0200
Message-ID: <CAMRc=MeSte7oQ+oLm0f-Re0LgO1c203xPZRQF9mky9oLCTkeKg@mail.gmail.com>
References: <20180925124629.20710-1-brgl@bgdev.pl> <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
 <a729cfd1102ef280650074dd8bec32c6b12636db.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a729cfd1102ef280650074dd8bec32c6b12636db.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arend van Spriel <aspriel@gmail.com>, Vivek Gautam <vivek.gautam@codeaurora.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

wt., 25 wrz 2018 o 17:48 Joe Perches <joe@perches.com> napisa=C5=82(a):
>
> On Tue, 2018-09-25 at 13:51 +0100, Robin Murphy wrote:
> > On 25/09/18 13:46, Bartosz Golaszewski wrote:
> > > This series implements devm_kstrdup_const() together with some
> > > prerequisite changes and uses it in pmc-atom driver.
> >
> > Is anyone expecting me to review this series,
>
> Probably not.
>
> > or am I just here because
> > I once made a couple of entirely unrelated changes to device.h?
>
> Most likely yes.
>
> It is likely that Bartosz should update his use of the
> get_maintainer.pl script to add "--nogit --nogit-fallback"
> so drive-by patch submitters are not also cc'd on these
> sorts of series.
>
> $ ./scripts/get_maintainer.pl -f \
>         drivers/base/devres.c \
>         drivers/mailbox/tegra-hsp.c \
>         include/asm-generic/sections.h \
>         include/linux/device.h \
>         mm/util.c | \
>   wc -l
> 26
>
> $ ./scripts/get_maintainer.pl -f --nogit --nogit-fallback \
>         drivers/base/devres.c \
>         drivers/mailbox/tegra-hsp.c \
>         include/asm-generic/sections.h \
>         include/linux/device.h \
>         mm/util.c | \
>   wc -l
> 10
>
>

Hi, sorry for that. Got it and will use next time.

Bartosz
