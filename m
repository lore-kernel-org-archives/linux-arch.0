Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37458 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbJSQ7a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2015 12:59:30 -0400
Received: by wicfv8 with SMTP id fv8so15306174wic.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Oct 2015 09:59:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151019160842.GF32054@sirena.org.uk>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
	<20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
	<20151019152641.GC32054@sirena.org.uk>
	<s5hk2qi3m93.wl-tiwai@suse.de>
	<20151019160842.GF32054@sirena.org.uk>
Date: Mon, 19 Oct 2015 09:59:29 -0700
Message-ID: <CAPcyv4jper5Byz2782MHbi-_RjDiDna4hYCHG1UBacE3YXd96A@mail.gmail.com>
Subject: Re: [PATCH 11/20] sound, skylake: switch from ioremap_cache to memremap
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaroslav Kysela <perex@perex.cz>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20151019165929.nn1UGaeNebAreF-pacPh_tf1jMmv_vGD-2003kym3ow@z>

On Mon, Oct 19, 2015 at 9:08 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 19, 2015 at 05:34:48PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
>
>> > On Fri, Oct 09, 2015 at 06:16:36PM -0400, Dan Williams wrote:
>> > > In preparation for deprecating ioremap_cache() convert its usage in
>> > > skl-nhlt to memremap.
>
>> > > -void __iomem *skl_nhlt_init(struct device *dev)
>> > > +void *skl_nhlt_init(struct device *dev)
>
>> > Why are we loosing the annotation here?
>
>> It's the exact purpose of this patchset, as far as I understand.
>> memremap() allows the driver accessing the mapped memory just like a
>> normal memory unlike ioremap().
>
> There's no mention of what the purpose of the conversion is in either
> the patch or the cover letter so it's a bit unclear, some confirmation
> would be good :(

The cover letter linked this article which talked through the
motivation: https://lwn.net/Articles/653585/

Essentially an "__iomem" annotation on a cached mapping is
inconsistent as __iomem indicates "may have side effects, use special
accessors" and cached means "pre-fetching, asynchronous write-backs,
and cpu determined i/o sizes are permissible".
