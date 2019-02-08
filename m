Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38930 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHMzr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 07:55:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id x6so2002716qki.6
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 04:55:47 -0800 (PST)
Date: Fri, 8 Feb 2019 07:55:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] drm: tweak header name
Message-ID: <20190208075408-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-4-mst@redhat.com>
 <20190208085659.GI23159@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208085659.GI23159@phenom.ffwll.local>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Message-ID: <20190208125532.fZzZsM6BD5mwZTOlZfuFd9zYjg6J1dgSDGGaVq5q8Z0@z>

On Fri, Feb 08, 2019 at 09:56:59AM +0100, Daniel Vetter wrote:
> On Fri, Feb 08, 2019 at 01:02:58AM -0500, Michael S. Tsirkin wrote:
> > Use linux/mman.h to make sure we get all mmap flags we need.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> drmP.h is seriously deprecated (and a monster mess). If this fixes
> anything, I think would be better to include the right header in the right
> places, and leave drmP.h to die quietly ...
> 
> What exactly does this fix?
> -Daniel

I don't know. I am moving flags from asm/mman.h and if there
are direct users which there should not be, some code
might break. Even if it's a bad header people copy
code around, so why leave wrong examples there?
What's the harm in being proactive?


> > ---
> >  include/drm/drmP.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> > index bdb0d5548f39..a3184416ddc5 100644
> > --- a/include/drm/drmP.h
> > +++ b/include/drm/drmP.h
> > @@ -57,8 +57,7 @@
> >  #include <linux/workqueue.h>
> >  #include <linux/dma-fence.h>
> >  #include <linux/module.h>
> > -
> > -#include <asm/mman.h>
> > +#include <linux/mman.h>
> >  #include <asm/pgalloc.h>
> >  #include <linux/uaccess.h>
> >  
> > -- 
> > MST
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
