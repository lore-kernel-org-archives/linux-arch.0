From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Thu, 6 Dec 2018 11:55:54 +0100
Message-ID: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205140550.GA27549@lst.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 05 December 2018 at 3:05PM, Christoph Hellwig wrote:
>
> Thanks.  Can you try a few stepping points in the tree?
>
> First just with commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
> (the first one) applied?
>
> Second with all commits up to 5da11e49df21f21dac25a2491aa788307bdacb6b
>
> And if that still works with commits up to
> c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a
>
Hi Christoph,

I undid the commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6 with the 
following command:

git checkout 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6

Result: PASEMI onboard ethernet works again and the P5020 board boots.

I will test the other commits in the next days.

@All
It is really important, that you also test Christoph's work on your 
PASEMI and NXP boards. Could you please help us with solving the issues?

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian
