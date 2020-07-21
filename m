From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] objtool, kcsan: Add __tsan_read_write to uaccess
 whitelist
Date: Tue, 21 Jul 2020 16:04:48 +0200
Message-ID: <20200721140448.GZ10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-3-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgGUOE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:04:56 -0400
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-3-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:10PM +0200, Marco Elver wrote:
> Adds the new __tsan_read_write compound instrumentation to objtool's
> uaccess whitelist.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 63d8b630c67a..38d82e705c93 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
>  	"__tsan_write4",
>  	"__tsan_write8",
>  	"__tsan_write16",
> +	"__tsan_read_write1",
> +	"__tsan_read_write2",
> +	"__tsan_read_write4",
> +	"__tsan_read_write8",
> +	"__tsan_read_write16",
>  	"__tsan_atomic8_load",
>  	"__tsan_atomic16_load",
>  	"__tsan_atomic32_load",
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
