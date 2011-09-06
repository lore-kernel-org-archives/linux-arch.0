From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH 2/2] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU) driver
Date: Tue, 6 Sep 2011 19:27:59 +0900
Message-ID: <CAHQjnONHr-Ao_KLjdRKgVQQUKtOmmoyqFwdkSZCDsE6hx1q-Ug@mail.gmail.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi.

On Fri, Sep 2, 2011 at 10:56 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> + *
> + * iova must be aligned on a 4kB, 64kB, 1MB and 16MB boundaries, res=
pectively.
> + */

Actually, iova is just needed to be aligned by 4KiB because it is
minimum requirement.
I think IOMMU driver is capable of mapping a group of page frames that
is aligned
by 1MiB with an iova that is aligned by 4KB
if the iova is large enough to map the given page frames.

> +static int s5p_sysmmu_map(struct iommu_domain *domain, unsigned long=
 iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, =
int gfp_order, int prot)
> +{
> + =A0 =A0 =A0 struct s5p_sysmmu_domain *s5p_domain =3D domain->priv;
> + =A0 =A0 =A0 int flpt_idx =3D flpt_index(iova);
> + =A0 =A0 =A0 size_t len =3D 0x1000UL << gfp_order;
> + =A0 =A0 =A0 void *flpt_va, *slpt_va;
> +
> + =A0 =A0 =A0 if (len !=3D SZ_16M && len !=3D SZ_1M && len !=3D SZ_64=
K && len !=3D SZ_4K) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_debug(3, "bad order: %d\n", gfp_=
order);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }

Likewise, I think this driver need to support mapping 128KiB aligned,
128KiB physical memory, for example.

Otherwise, it is somewhat restrictive than we expect.

Thank you.

Cho KyongHo.
