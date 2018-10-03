From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v6 0/4] devres: provide and use devm_kstrdup_const()
Date: Wed, 3 Oct 2018 10:33:52 +0200
Message-ID: <CAMRc=MdMda1fhRZsB96MZd=XXd5otaik9zAnAE3qXWggqhweMA@mail.gmail.com>
References: <20180930202615.12951-1-brgl@bgdev.pl> <20181001160901.GY15943@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001160901.GY15943@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

pon., 1 pa=C5=BA 2018 o 18:14 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Sun, Sep 30, 2018 at 10:26:11PM +0200, Bartosz Golaszewski wrote:
> > This series implements devm_kstrdup_const() together with some
> > prerequisite changes and uses it in tegra-hsp driver.
>
> Thanks!
> For the first three,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> >
> > v1 -> v2:
> > - fixed the changelog in the patch implementing devm_kstrdup_const()
> > - fixed the kernel doc
> > - moved is_kernel_rodata() to asm-generic/sections.h
> > - fixed constness
> >
> > v2 -> v3:
> > - rebased on top of 4.19-rc5 as there were some conflicts in the
> >   pmc-atom driver
> > - collected Reviewed-by tags
> >
> > v3 -> v4:
> > - Andy NAK'ed patch 4/4 so I added a different example
> > - collected more tags
> >
> > v4 -> v5:
> > - instead of providing devm_kfree_const(), make devm_kfree() check if
> >   given pointer is not in .rodata and act accordingly
> >
> > v5 -> v6:
> > - fixed the commit message in patch 2/4 (s/devm_kfree_const/devm_kfree/=
)
> > - collected even more tags
> >
> > Bartosz Golaszewski (4):
> >   devres: constify p in devm_kfree()
> >   mm: move is_kernel_rodata() to asm-generic/sections.h
> >   devres: provide devm_kstrdup_const()
> >   mailbox: tegra-hsp: use devm_kstrdup_const()
> >
> >  drivers/base/devres.c          | 36 +++++++++++++++++++++++++++--
> >  drivers/mailbox/tegra-hsp.c    | 41 ++++++++--------------------------
> >  include/asm-generic/sections.h | 14 ++++++++++++
> >  include/linux/device.h         |  4 +++-
> >  mm/util.c                      |  7 ------
> >  5 files changed, 60 insertions(+), 42 deletions(-)
> >
> > --
> > 2.18.0
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Greg,

I think that the three first patches of this series are ready to be
picked up. The last one can wait until the next release cycle. Out of
those three two are devres patches and one is mm. Do you think this
should go through your tree?

Best regards,
Bartosz Golaszewski
