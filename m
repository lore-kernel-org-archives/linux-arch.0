Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:28054 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeLFRLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Dec 2018 12:11:08 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
Date: Thu, 6 Dec 2018 18:10:54 +0100
Content-Transfer-Encoding: quoted-printable
Message-ID: <9ECD27D6-B039-4253-9FB9-749B41DE4CC6@xenosoft.de>
References: <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de> <20181130105346.GB26765@lst.de> <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181206171054.BRLMcj2zib2XLlfGNGymaGhweREBDCOoEZkPWtc8DM8@z>

Please don=E2=80=99t merge this code. We are still testing and trying to fig=
ure out where the problems are in the code.

=E2=80=94 Christian

Sent from my iPhone

> On 6. Dec 2018, at 11:55, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
>> On 05 December 2018 at 3:05PM, Christoph Hellwig wrote:
>>=20
>> Thanks.  Can you try a few stepping points in the tree?
>>=20
>> First just with commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>> (the first one) applied?
>>=20
>> Second with all commits up to 5da11e49df21f21dac25a2491aa788307bdacb6b
>>=20
>> And if that still works with commits up to
>> c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a
>>=20
> Hi Christoph,
>=20
> I undid the commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6 with the follo=
wing command:
>=20
> git checkout 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>=20
> Result: PASEMI onboard ethernet works again and the P5020 board boots.
>=20
> I will test the other commits in the next days.
>=20
> @All
> It is really important, that you also test Christoph's work on your PASEMI=
 and NXP boards. Could you please help us with solving the issues?
>=20
> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'
>=20
> Thanks,
> Christian
>=20
