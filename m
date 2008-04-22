From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 16:53:29 +0200
Message-ID: <20080422145329.GK12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <480DACDD.7040108@qumranet.com> <20080422092230.GW12774@kernel.dk> <20080422111403.GX12774@kernel.dk> <1208869254.7115.258.camel@twins> <20080422142543.GG12774@kernel.dk> <480DF861.6000705@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764633AbYDVOxt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <480DF861.6000705@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 22 2008, Avi Kivity wrote:
> Jens Axboe wrote:
> >>Introducing this fallback will make any usage from irq disabled context
> >>deadlock prone.
> >>
> >>I rather like the current interface.
> >>    
> >
> >Hmm good point, I'll back that bit out again.
> >  
> 
> But then you need to fix all callers to handle errors.

They should already, there were various error conditions before
depending on the arch. I'm aware that some do not, so I'd consider that
a general cleanup (that must also be done, agree).

> Perhaps we need a new flag for failable async IPIs (or better, API).  
> I'm pretty sure no one uses s_c_f_s() from irq disabled context on x86, 
> since it will WARN_ON(irqs_disabled()).

That'd work. I tried to keep things really simple here, I have other
ideas for cleanups and improvements once this batch goes in.

-- 
Jens Axboe
