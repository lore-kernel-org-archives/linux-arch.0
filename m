From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] mm: expland documentation over __read_mostly
Date: Wed, 6 May 2020 17:03:15 -0600
Message-ID: <CAB=NE6WnO+6Mn-t9coVHKSVY5iNpTcb+VGCAfBJWrwj3jNNAKA@mail.gmail.com>
References: <20180508181924.19939-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgEFXDZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 May 2020 19:03:25 -0400
In-Reply-To: <20180508181924.19939-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Christopher Lamenter <cl@linux.com>, Rafael Aquini <aquini@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Waiman Long <longman@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Randy Dunlap <rdunlap@infradead.org>, joel.opensrc@gmail.com, linux-arch <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 8, 2018 at 12:19 PM Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.
>
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

After 2 years, this patch was never applied... and so people can
easily keep misusing this. I'll resend now.

  Luis
> ---
>  include/linux/cache.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 750621e41d1c..4967566ed08c 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -15,8 +15,16 @@
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
> + * commit log.
> + *
> + * If an architecture doesn't support it, ignore the hint.
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> --
> 2.17.0
>
