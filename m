Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50330 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeIECBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2018 22:01:46 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Tue, 4 Sep 2018 21:34:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B091717@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
 <20180904211107.GA8202@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Message-ID: <20180904213443.s7yfQ2V3nCQuUg6xlrIFJjcDak2hr5HYJJsMRVSM6BM@z>

On 09/04/2018 02:07 PM, Christoph Hellwig wrote:=0A=
> On Tue, Sep 04, 2018 at 01:14:49PM -0700, Vineet Gupta wrote:=0A=
>> Apologies for the delay in getting to this - series applied and pushed t=
o for-curr=0A=
> This is going to create really annoying merge conflicts with=0A=
> work pending for the dma-mapping tree.  That's why I requested earlier=0A=
> to merge it either via the dma-mapping tree or some shared branch.=0A=
=0A=
Sorry I missed that request of yours on top of the last msg. I would really=
 want=0A=
this to get into 4.19 (understand that merge window is done etc) given that=
=0A=
there's a bunch of other changes lined up behind this one. I was just sucke=
d up=0A=
into "other" stuff and could not get to it sooner. Please bear with me this=
 once -=0A=
hopefully it would be smoother going fwd.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
=0A=
