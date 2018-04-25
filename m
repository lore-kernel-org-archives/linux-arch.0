Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeDYVIX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Apr 2018 17:08:23 -0400
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-23-hch@lst.de>
 <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de> <20180425072105.GA12308@lst.de>
From: Helge Deller <deller@gmx.de>
Message-ID: <84d9e1ac-86c3-6f2e-377f-2be44783b933@gmx.de>
Date: Wed, 25 Apr 2018 23:07:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180425072105.GA12308@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180425210757.tJw58xORBnscMDkPcTAtNVVAY268C-speHgufkIc7Ow@z>

On 25.04.2018 09:21, Christoph Hellwig wrote:
> On Sat, Apr 21, 2018 at 07:43:46PM +0200, Helge Deller wrote:
>> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU, "pcxl2").
>> After applying this patch series the lasi82956 network driver works unreliable. 
>> NIC gets IP, but ping doesn't work.
>> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.
> 
> Just to confirm:  Without the series it is known to actually work?

Yes.
I reverted this series from my tree, rebuilt, and then the issue was gone.
I won't be able to test again earlier than next week.

Helge
