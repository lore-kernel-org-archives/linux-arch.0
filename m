From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU) driver
Date: Mon, 5 Sep 2011 21:21:39 +0300
Message-ID: <CADMYwHyeP-1Rd1GxJx-z7XjrThK_H_bPB-_FZMb-_Y1VGeA4Dg@mail.gmail.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com> <1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39797 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab1IESWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2011 14:22:00 -0400
Received: by wwe5 with SMTP id 5so159020wwe.1
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2011 11:21:59 -0700 (PDT)
In-Reply-To: <1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>

Hi Marek,

On Fri, Sep 2, 2011 at 4:56 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
=2E..
> =A0arch/arm/plat-s5p/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 21 +-
> =A0arch/arm/plat-s5p/include/plat/sysmmu.h =A0 =A0 =A0 =A0| =A0119 ++=
--
> =A0arch/arm/plat-s5p/sysmmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0855 ++++++++++++++++++------

Please move the driver to drivers/iommu/, where all other IOMMU API use=
rs sit.

=2E..
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
=2E..
> +config IOMMU_API
> + =A0 =A0 =A0 bool

You don't need this anymore: this is already part of drivers/iommu/Kcon=
fig.

> +static int s5p_sysmmu_unmap(struct iommu_domain *domain, unsigned lo=
ng iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int gfp_order)
> =A0{
=2E..
> + =A0 =A0 =A0 if (SZ_1M =3D=3D len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!page_1m(flpt_va))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bug_unmapping_prohibite=
d(iova, len);
=2E.
> + =A0 =A0 =A0 } else if (SZ_16M =3D=3D len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* first loop to verify it actually is =
16M mapping */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 16; ++i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!page_16m(flpt_va +=
 4 * i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bug_unm=
apping_prohibited(iova, len);

Actually these are not bugs; iommu drivers need to unmap the page they
find in iova, and return the page size that was actually unmapped: you
may well receive a page size that is different from the page that maps
iova.

=2E..
> +
> + =A0 =A0 =A0 return 0;

On success, need to return the size (in page order) of the page that
was unmapped.

Regards,
Ohad.
