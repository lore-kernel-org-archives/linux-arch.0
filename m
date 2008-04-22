From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/11] arm: convert to generic helpers for IPI function  calls
Date: Tue, 22 Apr 2008 20:43:10 +0200
Message-ID: <20080422184310.GR12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-7-git-send-email-jens.axboe@oracle.com> <1208876447.31997.30.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1208876447.31997.30.camel-hhZApKj8DF/YkXV2EHHjLW3o5bpOHsLO@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

On Tue, Apr 22 2008, Catalin Marinas wrote:
> On Tue, 2008-04-22 at 09:57 +0200, Jens Axboe wrote:
> > This converts arm to use the new helpers for smp_call_function() and
> > friends, and adds support for smp_call_function_single(). Not tested
> > at all, not even compiled.
> 
> With the minor fixes below, it compiles and seems to run OK on RealView
> EB + ARM11MPCore (4 CPUs):

Pretty silly errors, missing the cross compiler... Thanks a lot for
checking and testing, I've added your changes!

-- 
Jens Axboe
