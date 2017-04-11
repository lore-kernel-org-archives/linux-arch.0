From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: "Consolidate get_dma_ops" breaks Xen on ARM
Date: Tue, 11 Apr 2017 01:14:29 +0000
Message-ID: <CY1PR0401MB1536C1FF3C069BC88D1DB14581000@CY1PR0401MB1536.namprd04.prod.outlook.com>
References: <alpine.DEB.2.10.1704101713080.2759@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com" <jgross@suse.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "julien.grall@arm.com" <julien.grall@arm.com>
List-Id: linux-arch.vger.kernel.org

On 04/10/17 17:31, Stefano Stabellini wrote:=0A=
> I think the reason is that, as you can see, if (dev && dev->dma_ops),=0A=
> dev->dma_ops is returned, while before this changes, xen_dma_ops was=0A=
> returned on Xen on ARM.=0A=
>=0A=
> Unfortunately DMA cannot work properly without using the appropriate=0A=
> xen_dma_ops. See drivers/xen/swiotlb-xen.c and arch/arm/xen/mm.c for=0A=
> more details. (The problem is easy to spot, but I wasn't CC'ed on the=0A=
> patch.)=0A=
>=0A=
> I don't know how to solve this problem without introducing some sort of=
=0A=
> if (xen()) in include/linux/dma-mapping.h.=0A=
=0A=
Sorry but I don't have access to an ARM development system. Does your =0A=
comment apply to dev =3D=3D NULL only, dev !=3D NULL only or perhaps to bot=
h? =0A=
If your comment applies to dev !=3D NULL only, can you check whether =0A=
adding something like set_dma_ops(dev, get_arch_dma_ops(NULL)) to the =0A=
appropriate ARM arch_setup_dma_ops() function is sufficient?=0A=
=0A=
Thanks,=0A=
=0A=
Bart.=0A=
=0A=
=0A=
