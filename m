From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Thu, 3 Jan 2019 20:26:15 +0100
Message-ID: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de> <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de> <20181213091021.GA2106@lst.de> <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de> <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de> <20181213112511.GA4574@lst.de> <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de> <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de> <20190103073622.GA24323@lst.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103073622.GA24323@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

Happy new year for you too. Unfortunately we have some problems with the lat=
est DRM patches. They modified a lot and some graphics cards don=E2=80=99t w=
ork anymore. During the holidays we tried to figure out where the problems a=
re but without any success.

I will try to test your patches next week.

Cheers,
Christian

Sent from my iPhone

> On 3. Jan 2019, at 08:36, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Hi Christian,
>=20
> happy new year and I hope you had a few restful deays off.
>=20
> I've pushed a new tree to:
>=20
>   git://git.infradead.org/users/hch/misc.git powerpc-dma.6
>=20
> Gitweb:
>=20
>   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6
>=20
> Which has been rebased to the latests Linus tree, which has a lot of
> changes, and has also changed the patch split a bit to aid bisection.
>=20
> I think=20
>=20
>   http://git.infradead.org/users/hch/misc.git/commitdiff/c446404b041130fbd=
9d1772d184f24715cf2362f
>=20
> might be a good commit to re-start testing, then bisecting up to the
> last commit using git bisect.
