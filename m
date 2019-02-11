Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:13362 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKHVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Feb 2019 02:21:21 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
Date: Mon, 11 Feb 2019 08:21:11 +0100
Content-Transfer-Encoding: quoted-printable
Message-ID: <0807B9CE-69E6-45A6-A029-1AAE5615CC8E@xenosoft.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de> <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de> <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de> <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190211072111.6oYtUGv417lhX-QZxJjkpT_xtGBQFiPPjAz85MdJG-s@z>

Hi Christoph,

Mario successfully tested a kernel from your Git [1] on his T2080rdb today.

Link to the log:=20
https://gitlab.com/oshw-powerpc-notebook/T2080customizations/blob/master/ker=
nel/dma_fix/kernel_dma_fix_log.txt

He wrote:

Please, note that all of the above kernel runs just fine with the T2080rdb, h=
owever did not had the time to test extensively (tested: login into MATE gra=
phical desktop environment, used ArctiFox for opening couple of websites, th=
en played Neverball).

=E2=80=94=E2=80=94

Cheers,
Christian

[1] http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6=
