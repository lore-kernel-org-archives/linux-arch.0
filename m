From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 1/2] mm: add architecture primitives for software dirty
 bit clearing
Date: Tue, 22 Sep 2015 12:09:35 +0300
Message-ID: <20150922090935.GA10131@uranus>
References: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
 <1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
 <20150921194854.GD3181@uranus>
 <20150922093549.504a5fb3@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20150922093549.504a5fb3@mschwide>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>, Pavel Emelyanov <xemul@virtuozzo.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 22, 2015 at 09:35:49AM +0200, Martin Schwidefsky wrote:
> > 
> > Looks good to me. Thank you, Martin!
> > (I cant ack s390 part 'casuse I simply not familiar
> >  with the architecture).
> 
> Sure, the s390 patch just shows why the new arch functions are needed..

A see, thanks!

> 
> > Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
> 
> Thanks. I have added both patches to the features branch of linux-s390
> for the 4.4 merge window.

The first patch (x86 and general helpers) seems better to go via
Andrew (CC'ed) becase they are not s390 only. And while these
changes are fine for me and you as far as I can say, lets them
floating around for some more review just to make sure we're not
missing something obvious.

And initially the soft-dirty feature has been hittin vanilla by
-mm tree so I suppose we should continue this way, though I
don't mind if it gonna be merged via pull request from s390
side but still ;)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
