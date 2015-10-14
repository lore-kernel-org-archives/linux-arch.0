From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH 09/20] i915: switch from acpi_os_ioremap to
 memremap
Date: Wed, 14 Oct 2015 09:33:21 +0200
Message-ID: <20151014073321.GU26718@phenom.ffwll.local>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221625.32203.74117.stgit@dwillia2-desk3.jf.intel.com>
 <20151012070102.GV26718@phenom.ffwll.local>
 <1444684376.9780.5.camel@intel.com>
 <20151013082416.GF26718@phenom.ffwll.local>
 <CAPcyv4i6SFziAr_O1YB7hdpPTUdXM3FEsi-3AMF9-KBLJmtT2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35880 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbJNHa1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2015 03:30:27 -0400
Received: by wicgb1 with SMTP id gb1so218174932wic.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2015 00:30:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPcyv4i6SFziAr_O1YB7hdpPTUdXM3FEsi-3AMF9-KBLJmtT2g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Vetter, Daniel" <daniel.vetter@intel.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>

On Tue, Oct 13, 2015 at 09:24:26AM -0700, Dan Williams wrote:
> On Tue, Oct 13, 2015 at 1:24 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Oct 12, 2015 at 09:12:57PM +0000, Williams, Dan J wrote:
> >> On Mon, 2015-10-12 at 09:01 +0200, Daniel Vetter wrote:
> >> > On Fri, Oct 09, 2015 at 06:16:25PM -0400, Dan Williams wrote:
> >> > > i915 expects the OpRegion to be cached (i.e. not __iomem), so explicitly
> >> > > map it with memremap rather than the implied cache setting of
> >> > > acpi_os_ioremap().
> >> > >
> >> > > Cc: Daniel Vetter <daniel.vetter@intel.com>
> >> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> >> > > Cc: intel-gfx@lists.freedesktop.org
> >> > > Cc: David Airlie <airlied@linux.ie>
> >> > > Cc: dri-devel@lists.freedesktop.org
> >> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> >
> >> > Assuming you've run sparse over this to make sure you've caught them all,
> >> > and with the nit below addressed this is
> >> >
> >> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >>
> >> Indeed, re-running sparse again found a few conversions of ioread* I
> >> missed as well as moving the force casting out of validate_vbt() to
> >> find_vbt().
> >>
> >> > Feel free to pull v2 into whatever tree you think it's suitable for (but
> >> > you can also resend and I'll pick it up).
> >>
> >> Please pick up v2 below.
> >
> > Queued for -next, thanks for the patch. Aside: Attached or separate mail
> > seems easier, somehow git apply-mbox can't auto-eat this for of patch.
> > -Daniel
> >
> 
> "git am --scissors" should detect the "8<---" cut line.

TIL, works nice indeed. Thanks for the hint.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
