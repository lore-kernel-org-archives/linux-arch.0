From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 1 Feb 2019 17:54:37 +0100
Message-ID: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
References: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de> <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de> <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de> <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de> <20190201080456.GA15456@lst.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201080456.GA15456@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

I will try it at the weekend.

Thanks,
Christian

Sent from my iPhone

> On 1. Feb 2019, at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Thu, Jan 31, 2019 at 01:48:26PM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>=20
>> I compiled kernels for the X5000 and X1000 from your branch 'powerpc-dma.=
6'=20
>> today.
>>=20
>> Gitweb:=20
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-d=
ma.6
>>=20
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>=20
>> The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet doesn't=
=20
>> work.
>=20
> Oh.  Can you try with just the next one and then two patches applied
> over the working setup?  That is first:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/b50f42f0fe12965ead3=
95c76bcb6a14f00cdf65b
>=20
> then also with:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/21fe52470a483afbb17=
26741118abef8602dde4d
