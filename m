From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] compiler.h: introduce unused_expression() macro
Date: Fri, 27 Apr 2012 01:16:44 -0700
Message-ID: <4F9A55EC.20804@zytor.com>
References: <20120425112623.26927.43229.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33894 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254Ab2D0IQw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Apr 2012 04:16:52 -0400
In-Reply-To: <20120425112623.26927.43229.stgit@zurg>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 04/25/2012 04:26 AM, Konstantin Khlebnikov wrote:
> Sometimes we want to check some expressions correctness in compile-time without
> generating extra code. "(void)(e)" does not work if expression has side-effects.
> This patch introduces macro unused_expression() which helps in this situation.
> 
> Cast to "long" required because sizeof does not work for bit-fields.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
> ---
>  include/linux/compiler.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 923d093..46fbda3 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -310,4 +310,6 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
>   */
>  #define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
>  
> +#define unused_expression(e) ((void)(sizeof((__force long)(e))))
> +

OK, bikeshedding a bit:

"unused_expression()" doesn't sound like something that inhibits side
effects, especially since "unused" applied to an argument or variable
means "don't make a fuss over this not being used."

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
