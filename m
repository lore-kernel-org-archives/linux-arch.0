From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 0/2] Kill unused parameter to smp_call_function and friends
Date: Thu, 29 May 2008 13:49:34 +0200
Message-ID: <20080529114934.GB25504@kernel.dk>
References: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com> <483E80E4.6030403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:20910 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbYE2Lth (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 07:49:37 -0400
Content-Disposition: inline
In-Reply-To: <483E80E4.6030403@goop.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

On Thu, May 29 2008, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> >It bothers me how the smp call functions accept a 'nonatomic' or 
> >'retry'
> >parameter (depending on who you ask), but don't do anything with it.
> >So kill that silly thing.
> >
> >Two patches here, one for smp_call_function*() and one for 
> >on_each_cpu().
> >This patchset applies on top of the generic-ipi patchset just sent 
> >out.
> >  
> 
> Yay!
> 
> Acked++-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Thanks Jeremy, added!

-- 
Jens Axboe
