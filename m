From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/2] mm: add architecture primitives for software dirty
 bit clearing
Date: Tue, 22 Sep 2015 12:30:01 +0200
Message-ID: <20150922123001.09449feb@mschwide>
References: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
	<1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
	<20150921194854.GD3181@uranus>
	<20150922093549.504a5fb3@mschwide>
	<20150922090935.GA10131@uranus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150922090935.GA10131@uranus>
Sender: owner-linux-mm@kvack.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>, Pavel Emelyanov <xemul@virtuozzo.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 22 Sep 2015 12:09:35 +0300
Cyrill Gorcunov <gorcunov@gmail.com> wrote:

> On Tue, Sep 22, 2015 at 09:35:49AM +0200, Martin Schwidefsky wrote:
> > Thanks. I have added both patches to the features branch of linux-s390
> > for the 4.4 merge window.
> 
> The first patch (x86 and general helpers) seems better to go via
> Andrew (CC'ed) becase they are not s390 only. And while these
> changes are fine for me and you as far as I can say, lets them
> floating around for some more review just to make sure we're not
> missing something obvious.
> 
> And initially the soft-dirty feature has been hittin vanilla by
> -mm tree so I suppose we should continue this way, though I
> don't mind if it gonna be merged via pull request from s390
> side but still ;)
 
Well, the patches will be included in linux-next automatically and
they will get a fair share of testing before the 4.4 merge window
opens. If the patches get picked up via -mm as well, be my guest.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
