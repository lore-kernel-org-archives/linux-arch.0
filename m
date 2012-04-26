From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] compiler.h: introduce unused_expression() macro
Date: Thu, 26 Apr 2012 15:29:09 -0700
Message-ID: <20120426152909.b1e653bf.akpm@linux-foundation.org>
References: <20120425112623.26927.43229.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45748 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759413Ab2DZW3L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Apr 2012 18:29:11 -0400
In-Reply-To: <20120425112623.26927.43229.stgit@zurg>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 25 Apr 2012 15:26:23 +0400
Konstantin Khlebnikov <khlebnikov@openvz.org> wrote:

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

hm, maybe.

Thing is, if anyone ever has an expression-with-side-effects within
conditionally-compiled code then they probably have a bug, don't they?
I mean, as an extreme example

	VM_BUG_ON(do_something_important());

is a nice little hand-grenade.  Your patch will cause that (bad) code
to newly fail at runtime, but our coverage testing is so awful that it
would take a long time for the bug to be discovered.

It would be nice if we could cause the build to warn or outright fail
if the unused_expression() argument would have caused any code
generation.  But I can't suggest how to do that.


Your changelogs assert that gcc is emitting code for these expressions,
but details are not presented.  Please give examples - where is this
code generation coming from, what is causing it?


Bottom line: are these patches a workaround for gcc inadequacies, or
are they a bandaid covering up poor kernel code?
