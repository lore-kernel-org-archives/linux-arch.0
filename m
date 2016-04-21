From: Niklas =?iso-8859-1?Q?S=F6derlund?=
	<niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Thu, 21 Apr 2016 11:48:20 +0200
Message-ID: <20160421094820.GM19650@bigcity.dyn.berto.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org>
 <3286525.zPAGiD4Xk2@avalon>
 <20160321152601.GA11674@infradead.org>
 <20160413132916.GC19650@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160413132916.GC19650@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

Have you had time to look at the audit? Is there anything else I can do=
=20
make progress on this?

On 2016-04-13 15:29:16 +0200, Niklas S=F6derlund wrote:
> Hi Christoph,
>=20
> On 2016-03-21 08:26:01 -0700, Christoph Hellwig wrote:
> > On Thu, Mar 17, 2016 at 01:33:51PM +0200, Laurent Pinchart wrote:
> > > The good news is that, given that no code uses this new API at th=
e moment,=20
> > > there isn't much to audit. The patch series implements the resour=
ce mapping=20
> > > for arch/arm only, and makes use of it in the rcar-dmac driver on=
ly. Would you=20
> > > like anything audited else than the arch/arm dma mapping implemen=
tation, the=20
> > > rcar-dmac driver and the code that then deals with the dma addres=
ses (I'm=20
> > > thinking about the IOMMU subsystem and the ipmmu-vmsa driver in p=
articular) ?
> >=20
> > Yes, it would be good to do an audit of all the ARM dma_ops as well
> > as generic code like drivers/base/dma-*.c, lib/dma-debug.c and
> > include/linux/dma-*.h
>=20
> I have now done an audit to the best of my abilities, thanks to Laure=
nt=20
> for pointing me in the right direction. And from what I can tell we a=
re=20
> good.
>=20
> * drivers/dma/sh/rcar-dmac.c
>   Once the phys_addr_t is mapped to a dma_addr_t using=20
>   dma_map_resource() it is only used to check that the transfere do n=
ot=20
>   cross 4GB boundaries and then only directly written to HW registers=
=2E
>=20
> * drivers/iommu/iommu.c
>   - iommu_map()
>     Check that it's align to min page size or return -EINVAL then cal=
ls
>     domain->ops->map()
>=20
> * drivers/iommu/ipmmu-vmsa.c
>   - ipmmu_map()
>     No logic only calls domain->ops->map()
>=20
> * drivers/iommu/io-pgtable-arm.c
>   - arm_lpae_map()
>     No logic only calls __arm_lpae_map()
>   - __arm_lpae_map()
>     No logic only calls arm_lpae_init_pte()
>   - arm_lpae_init_pte()
>     Used to get a pte:
>       pte |=3D pfn_to_iopte(paddr >> data->pg_shift, data);
>=20
> * drivers/iommu/io-pgtable-arm-v7s.c
>   - arm_v7s_map()
>     No logic only calls __arm_v7s_map()
>   - __arm_v7s_map()
>     No logic only calls arm_v7s_init_pte()
>   - arm_v7s_init_pte
>     Used to get a pte:
>       pte |=3D paddr & ARM_V7S_LVL_MASK(lvl);
>=20
> * ARM dma-mapping
>   - dma_unmap_*
>     Only valid unmap is dma_unmap_resource() all others are an invali=
d=20
>     use case.
>   - dma_sync_single_*
>     Invalid use case, memmory that is mapped is device memmory
>   - dma_common_mmap() and dma_mmap_attrs()
>     Invalid use case
>   - dma_common_get_sgtable() and dma_get_sgtable_attrs()
>     Invalid use case, only for dma_alloc_* allocated memory,
>   - dma_mapping_error()
>     OK

--=20
Regards,
Niklas S=F6derlund
