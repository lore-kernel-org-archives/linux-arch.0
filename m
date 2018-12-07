Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:35133 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGHtI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2018 02:49:08 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20181206193605.GA31255@lst.de>
Date: Fri, 7 Dec 2018 08:48:54 +0100
Content-Transfer-Encoding: quoted-printable
Message-ID: <EC9C556C-B445-4E55-80DA-D5A04C701044@xenosoft.de>
References: <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <9ECD27D6-B039-4253-9FB9-749B41DE4CC6@xenosoft.de> <20181206193605.GA31255@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181207074854.T6ilmHCPyNiut46tkkmKx-kZF82TtqfiGTYabNv4k_0@z>

Good to know. Sorry because of the email.

Sent from my iPhone

> On 6. Dec 2018, at 20:36, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Thu, Dec 06, 2018 at 06:10:54PM +0100, Christian Zigotzky wrote:
>> Please don=E2=80=99t merge this code. We are still testing and trying to f=
igure out where the problems are in the code.
>=20
> The ones I sent pings for were either tested successfully by you
> (the zone change) or are trivial cleanups that don't affect your setup.
