From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] mm: expand documentation over __read_mostly
Date: Thu, 7 May 2020 14:04:20 -0400
Message-ID: <20200507180420.GE205881@optiplex-lnx>
References: <20200507161424.2584-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSEd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 14:04:33 -0400
Content-Disposition: inline
In-Reply-To: <20200507161424.2584-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de, willy@infradead.org, keescook@chromium.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:14:24PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over its use.
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> This v2 just has a few spelling fixes.
> 
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
> + * execute a critical path. We should be mindful and selective of its use.
> + * ie: if you're going to use it please supply a *good* justification in your
> + * commit log
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> -- 
> 2.25.1
> 
Acked-by: Rafael Aquini <aquini@redhat.com>
