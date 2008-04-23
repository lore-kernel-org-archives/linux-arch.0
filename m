From: Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 11/11] s390: convert to generic helpers for IPI
	function calls
Date: Wed, 23 Apr 2008 09:58:31 +0200
Message-ID: <20080423075831.GB15850@osiris.boeblingen.de.ibm.com>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-12-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1208890227-24808-12-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>

On Tue, Apr 22, 2008 at 08:50:27PM +0200, Jens Axboe wrote:
> This converts s390 to use the new helpers for smp_call_function() and
> friends, and adds support for smp_call_function_single(). Not tested,
> but it compiles.
> 
> Cc: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
> Cc: Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Your generic patch changes semantics of smp_call_function(). At least the
s390 version of smp_call_function() mask used to not return unless all IPIs
where received on the target cpus.
Your patch changes that. It will already return as soon as all IPIs have
been sent. Unfortunately Martin's etr code in arch/s390/kernel/time.c
relies on exactly the old semantics.
Since this seems to be an s390 only issue, could you just drop the s390
conversion patch? We'll have to think about how to change the err code
and convert later I guess.
