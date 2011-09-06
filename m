From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [Linaro-mm-sig] [PATCH 2/2] ARM: Samsung: update/rewrite Samsung
 SYSMMU (IOMMU) driver
Date: Tue, 6 Sep 2011 15:35:48 +0300
Message-ID: <CADMYwHzTe7WcqjCOSdgnbFsHm6gtV7Bf1154WHXiTnffGSAYRA@mail.gmail.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
 <1314971786-15140-3-git-send-email-m.szyprowski@samsung.com> <CAHQjnONHr-Ao_KLjdRKgVQQUKtOmmoyqFwdkSZCDsE6hx1q-Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAHQjnONHr-Ao_KLjdRKgVQQUKtOmmoyqFwdkSZCDsE6hx1q-Ug@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, Kyungmin Park <kyungmin.park@samsung.com>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Chunsang Jeong <chunsang.jeong@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 6, 2011 at 1:27 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> On Fri, Sep 2, 2011 at 10:56 PM, Marek Szyprowski
>> +static int s5p_sysmmu_map(struct iommu_domain *domain, unsigned long io=
va,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, int=
 gfp_order, int prot)
>> +{
>> + =A0 =A0 =A0 struct s5p_sysmmu_domain *s5p_domain =3D domain->priv;
>> + =A0 =A0 =A0 int flpt_idx =3D flpt_index(iova);
>> + =A0 =A0 =A0 size_t len =3D 0x1000UL << gfp_order;
>> + =A0 =A0 =A0 void *flpt_va, *slpt_va;
>> +
>> + =A0 =A0 =A0 if (len !=3D SZ_16M && len !=3D SZ_1M && len !=3D SZ_64K &=
& len !=3D SZ_4K) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_debug(3, "bad order: %d\n", gfp_ord=
er);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>
> Likewise, I think this driver need to support mapping 128KiB aligned,
> 128KiB physical memory, for example.
>
> Otherwise, it is somewhat restrictive than we expect.

That's actually OK, because the IOMMU core will split physically
contiguous memory regions to pages on behalf of its drivers (drivers
will just have to advertise the page sizes their hardware supports);
this way you don't duplicate the logic in every IOMMU driver.

Take a look:

http://www.spinics.net/lists/linux-omap/msg56660.html

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
