From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/11] sh: convert to generic helpers for IPI function calls
Date: Fri, 25 Apr 2008 11:16:36 +0200
Message-ID: <20080425091635.GI12774@kernel.dk>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-11-git-send-email-jens.axboe@oracle.com> <20080425085637.GA30569@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080425085637.GA30569-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Fri, Apr 25 2008, Paul Mundt wrote:
> On Tue, Apr 22, 2008 at 08:50:26PM +0200, Jens Axboe wrote:
> > This converts sh to use the new helpers for smp_call_function() and
> > friends, and adds support for smp_call_function_single(). Not tested,
> > but it compiles.
> > 
> > Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>

Thanks Paul!

-- 
Jens Axboe
