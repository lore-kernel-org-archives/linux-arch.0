Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42474 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbeIECC1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 22:02:27 -0400
Date: Tue, 4 Sep 2018 23:38:59 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Message-ID: <20180904213859.GA10394@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com> <20180904211107.GA8202@lst.de> <C2D7FE5348E1B147BCA15975FBA23075012B091717@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B091717@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Christoph Hellwig <hch@lst.de>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Message-ID: <20180904213859.dcwpRXIn75Xp12yrgzMMSC9sJv4cRM5mtroEZO-jqB4@z>

On Tue, Sep 04, 2018 at 09:34:43PM +0000, Vineet Gupta wrote:
> Sorry I missed that request of yours on top of the last msg. I would really want
> this to get into 4.19 (understand that merge window is done etc) given that
> there's a bunch of other changes lined up behind this one. I was just sucked up
> into "other" stuff and could not get to it sooner. Please bear with me this once -
> hopefully it would be smoother going fwd.

Oh, if you manage to get it into 4.19 and do so quickly that is fine
as well.  I just don't want it in your 4.20 queue creating conflicts.
