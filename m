From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH 11/11] s390: convert to generic helpers for IPI function calls
Date: Thu, 24 Apr 2008 01:56:27 +1000
Message-ID: <200804240156.27894.rusty@rustcorp.com.au>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <20080423114744.GA29422@osiris.boeblingen.de.ibm.com> <1208954573.5090.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208954573.5090.10.camel@localhost>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
Cc: Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Wednesday 23 April 2008 22:42:53 Martin Schwidefsky wrote:
> Looking at the stop_machine() code it doesn't seem to be to hard to get
> this implemented. stop_machine_run() would get a second function
> argument that replaces the call to cpu_relax() in stopmachine().
> The default if the additional function argument is NULL would be
> cpu_relax(). For the etr sync code it would be etr_sync_cpu_start().

Sure.  I've got changes for stop_machine planned, so please send a patch and 
I'll merge it in.

Cheers,
Rusty.
