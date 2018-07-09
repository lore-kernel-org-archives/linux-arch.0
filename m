Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36297 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932231AbeGIHdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 03:33:12 -0400
Date: Mon, 9 Jul 2018 09:33:10 +0200
From: "greg@kroah.com" <greg@kroah.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Message-ID: <20180709073310.GA9448@kroah.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <20180709054842.GB7618@kroah.com>
 <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
 <20180709070635.GB13285@kroah.com>
 <e1f959eb900b0c825842b0c28340bef9d1d2cf3e.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f959eb900b0c825842b0c28340bef9d1d2cf3e.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180709073310.UgIzdeEu40Bi3Vk_JFcwhsWWvsapMFRnVeE0kTQi9J0@z>

On Mon, Jul 09, 2018 at 07:17:11AM +0000, Alexey Brodkin wrote:
> Hi Greg,
> 
> On Mon, 2018-07-09 at 09:06 +0200, greg@kroah.com wrote:
> > On Mon, Jul 09, 2018 at 06:46:50AM +0000, Alexey Brodkin wrote:
> > > Hi Greg,
> > > 
> > > On Mon, 2018-07-09 at 07:48 +0200, Greg KH wrote:
> > > > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > > > might be aligned by either word (32-bits) or double word (64-bits).
> > > > > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > > > > 
> > > > > At least for 32-bit ARC cores ABI requires "long long" types
> > > > > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > > > > 12 bytes. Which is still OK as long as we use 32-bit data only.
> > > > > 
> > > > > But once we want to use native atomic64_t type (i.e. when we use special
> > > > > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > > > > misaligned access exception.
> > > > 
> > > > So is this something you hit today?  If not, why is this needed for
> > > > stable kernels?
> > > 
> > > Indeed we hit that problem recently when Etnaviv driver was switched to
> > > DRM GPU scheduler, see
> > > commit e93b6deeb45a ("drm/etnaviv: hook up DRM GPU scheduler").
> > > The most important part of DRM GPU scheduler is "job_id_count" member of
> > > "drm_gpu_scheduler" structure of type "atomic64_t". This structure is put
> > > in a buffer allocated by devm_kzalloc() and if "job_id_count" is not 64-bit
> > > aligned atomic instruction fails with an exception.
> > > 
> > > As for stable requirements - mentioned commit was a part of 4.17 kernel
> > > which broke GPU driver for one of our HSDK board so I guess back-porting
> > > to 4.17 is a no-brainer.
> > 
> > Ok, so 4.17 is as far back as you need?  Please try to be specific when
> > asking for stable backports.
> 
> Well in that particular case I really wanted to get this fix back-ported
> starting from v4.8 so I guess that's what I need to add in Cc tag, right?
> ----------------------------->8---------------------
> Cc: <stable@vger.kernel.org> # 4.8+
> ----------------------------->8---------------------

Yes.
