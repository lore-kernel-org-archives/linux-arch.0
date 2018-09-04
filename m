From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Tue, 4 Sep 2018 18:13:28 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B09164B@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com>
 <1534180089.3962.68.camel@synopsys.com>
 <81ddd506-1f7e-db82-4c77-ff08b1c15dd3@synopsys.com>
 <1534963226.3962.215.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Hi,=0A=
=0A=
On 08/22/2018 11:40 AM, Eugeniy Paltsev wrote:=0A=
>=0A=
>> Reading kernel/dma/* I see what you mean. We check @ioc_enable at the ti=
me of=0A=
>> registering the dma op for coherent vs. non coherent case, so there's co=
mmon vs.=0A=
>> ARC versions of alloc/free for coherent vs. noncoherent.=0A=
> Just to be sure that we understand both each other and source code correc=
tly: =0A=
> - In coherent case we use dma_direct_* ops which doesn't use ARC alloc fu=
nctions (arch_dma_{alloc|free})=0A=
> - In non-coherent case we use dma_noncoherent_* ops which uses ARC alloc =
functions (arch_dma_{alloc|free})=0A=
=0A=
Right I see that.=0A=
=0A=
>> But then I'm curious why=0A=
>> do we bother to check the following in new arch_dma_(alloc|free) at all.=
=0A=
>>=0A=
>> 	if (attrs & DMA_ATTR_NON_CONSISTENT)=0A=
>>=0A=
>> Isn't it supposed to be NON_CONSISTENT always given the way new code wor=
ks ?=0A=
> DMA_ATTR_NON_CONSISTENT flag is not related to IOC topic.=0A=
> It is a flag which we can pass to dma_{alloc|free}_attrs function from dr=
iver side.=0A=
>=0A=
> According to documentation:=0A=
>   DMA_ATTR_NON_CONSISTENT: Lets the platform to choose to return either=
=0A=
>   consistent or non-consistent memory as it sees fit.=0A=
=0A=
Right I'd them mixed up. But then in case of direct dma ops, the attr is si=
mply=0A=
ignored in dma_alloc_attrs() -> dma_direct_alloc(). User always gets cohere=
nt memory.=0A=
=0A=
>=0A=
> We check this flag in arch_dma_alloc (which are used in non-coherent case=
) to=0A=
> skip MMU mapping if we are advertised that consistency is not required.=
=0A=
>=0A=
> So, actually we can get rid of this flag checking in arch_dma_alloc and =
=0A=
> simply always do MMU mapping to enforce non-cachability and return=0A=
> non-cacheable memory even if DMA_ATTR_NON_CONSISTENT is passed.=0A=
> But I don't sure we want to do that.=0A=
>=0A=
> BTW: dma_alloc_coherent is simply dma_alloc_attrs with attrs =3D=3D 0.=0A=
>=0A=
=0A=
