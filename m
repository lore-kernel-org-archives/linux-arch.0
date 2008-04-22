From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 9/11] parisc: convert to generic helpers for IPI  function calls
Date: Tue, 22 Apr 2008 16:27:38 +0200
Message-ID: <20080422142738.GH12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-10-git-send-email-jens.axboe@oracle.com> <20080422140914.GD19802@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080422140914.GD19802-EK4dZfYtfFRW/gs8oUvUg/d9D2ou9A/h@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Kyle McMartin <kyle-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>

On Tue, Apr 22 2008, Kyle McMartin wrote:
> On Tue, Apr 22, 2008 at 09:57:35AM +0200, Jens Axboe wrote:
> > This converts mips to use the new helpers for smp_call_function() and
> > friends, and adds support for smp_call_function_single(). Not tested,
> > not even compiled.
> > 
> 
> At first glance, this looks alright. +1 from me.

Is that an official parisc ack? :-)

And I'll make sure the patch comment matches... I wish that Andrews xb
compiler collection had all the supported archs covered.

-- 
Jens Axboe
