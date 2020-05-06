From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Date: Wed, 6 May 2020 19:36:11 -0400
Message-ID: <20200506233611.GC205881@optiplex-lnx>
References: <20200506231353.32451-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40929 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgEFXgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 19:36:22 -0400
Content-Disposition: inline
In-Reply-To: <20200506231353.32451-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de, willy@infradead.org, keescook@chromium.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:13:53PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.
               s/it/its

same goes for the subject, as I think there is a minor typo: s/expland/expand

> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> I sent this 2 years ago, but it fell through the cracks. This time
> I'm adding Andrew Morton now, the fix0r-of-falling-through-the-cracks.
> 
> Resending as I just saw a patch which doesn't clearly justifiy the
> merits of the use of __read_mostly on it.
> 

That would be my fault! (sorry) given the rationale below, the patch I sent
really doesn't need the hint. Thanks for the extra bit of education here.

(not an excuse) In a glance over the source tree, though, it seems most 
of the hinting cases are doing it in the misguided way.


>  include/linux/cache.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 750621e41d1c..8106fb304fa7 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -15,8 +15,14 @@
>  
>  /*
>   * __read_mostly is used to keep rarely changing variables out of frequently
> - * updated cachelines. If an architecture doesn't support it, ignore the
> - * hint.
> + * updated cachelines. Its use should be reserved for data that is used
> + * frequently in hot paths. Performance traces can help decide when to use
> + * this. You want __read_mostly data to be tightly packed, so that in the
> + * best case multiple frequently read variables for a hot path will be next
> + * to each other in order to reduce the number of cachelines needed to
> + * execute a critial path. We should be mindful and selective of its use.
> + * ie: if you're going to use it please supply a *good* justification in your
> + * commit log
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> -- 
> 2.25.1
> 

Acked-by: Rafael Aquini <aquini@redhat.com>
