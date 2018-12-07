From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 7 Dec 2018 19:33:01 +0100
Message-ID: <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
References: <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de> <20181130105346.GB26765@lst.de> <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Next step: 13c1fdec5682b6e13257277fa16aa31f342d167d (powerpc/dma: move pci_d=
ma_dev_setup_swiotlb to fsl_pci.c)

git checkout 13c1fdec5682b6e13257277fa16aa31f342d167d

Result: The PASEMI onboard ethernet works and the X5000 boots.

=E2=80=94 Christian

Sent from my iPhone

> On 7. Dec 2018, at 14:45, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
>> On 06 December 2018 at 11:55AM, Christian Zigotzky wrote:
>>> On 05 December 2018 at 3:05PM, Christoph Hellwig wrote:
>>>=20
>>> Thanks.  Can you try a few stepping points in the tree?
>>>=20
>>> First just with commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>>> (the first one) applied?
>>>=20
>>> Second with all commits up to 5da11e49df21f21dac25a2491aa788307bdacb6b
>>>=20
>>> And if that still works with commits up to
>>> c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a
>>>=20
>> Hi Christoph,
>>=20
>> I undid the commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6 with the foll=
owing command:
>>=20
>> git checkout 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>>=20
>> Result: PASEMI onboard ethernet works again and the P5020 board boots.
>>=20
>> I will test the other commits in the next days.
>>=20
>> @All
>> It is really important, that you also test Christoph's work on your PASEM=
I and NXP boards. Could you please help us with solving the issues?
>>=20
>> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'=

>>=20
>> Thanks,
>> Christian
>>=20
>>=20
> Today I tested the commit 5da11e49df21f21dac25a2491aa788307bdacb6b.
>=20
> git checkout 5da11e49df21f21dac25a2491aa788307bdacb6b
>=20
> The PASEMI onboard ethernet works and the P5020 board boots.
>=20
> -- Christian
>=20
