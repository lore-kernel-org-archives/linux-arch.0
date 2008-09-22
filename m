From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Export kmap_atomic_pfn for DRM-GEM.
Date: Mon, 22 Sep 2008 10:59:54 -0700
Message-ID: <200809221059.54779.jbarnes@virtuousgeek.org>
References: <1219779789-8368-1-git-send-email-eric@anholt.net> <1219855961.4994.6.camel@vonnegut.anholt.net> <200808281022.14296.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754296AbYIVSAj@vger.kernel.org>
In-Reply-To: <200808281022.14296.nickpiggin@yahoo.com.au>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday, August 27, 2008 5:22 pm Nick Piggin wrote:
> > However, when other DRM drivers get around to doing memory management,
> > I'm sure they'll also be interested in an ioremap_wc that doesn't eat
> > ipi costs.  For us, the ipis for flushing were eating over 10% of CPU
> > time.  If your patch series cuts that cost, we could drop this piece at
> > that point.
>
> It can cut the cost quite significantly on normal vmap/vunmap loads I
> tested. Whether it will work as well on your workload, I don't know
> but I would have liked to find out. I raised this issue quite a while
> back, so I'm disappointed it had not been tried...

I think Eric has code with the vmap changes now?

Given our discussions at KS/Plumbers would you be ok with acking these 
patches?  Or do you want a repost so you can check out the vmap stuff?

After talking a bit more about it, I think we agreed that the ioctl interface 
is actually a better approach then trying to shoehorn this stuff into system 
calls, so aside from the vmap code (which could be done in 2.6.29 or whenever 
the vmap stuff lands) I think this patchset is pretty close to what we want 
in drm-next now...

Thanks,
Jesse
