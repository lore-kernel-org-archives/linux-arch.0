Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B543B27E7;
	Mon, 20 Apr 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696304; cv=none; b=KgCFlBdulJR9eYAlbKPHV0ElSKxxvXjlXjV1oZh0Q7JVLp0fCgW09HMEa++pceLkl464/AMhNUzcOHejMyAA+XSgYFZuurpYyZ3a1lVXhGIeTbVy8p1pRNIE0DnJdDA0p+1Orqd5pQEmO1KwW4z+RL00BBjHeyTNH8YTaCdrKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696304; c=relaxed/simple;
	bh=DvjST+yF6CJmtr8D4lRl3C1+kUmqLB75SqPnmUe/vP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1LQaQ0grbx5e13zSFpX1HJXE84C+jKPTtr/uuIjQxgx2VvcGl6LFj77PZm6curmnmTjcP8fiCUHv1z8hMqwBd6zGUsDSOch5eq4lQcenT+EwUx/bpseItPyR0gAi5trbV5MbkEQ0zrKpbTnebS9MSJ5w2cpbhFQdKLrZN48LYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKQaOyxV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKQaOyxV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QGZNObfTdWaDnFdgHvkJWs2GOcArsIQJdC8qtQnQhHk=; b=bKQaOyxV5mdnuEJHEUyNjimtNf
	7gcSTaExcTmzPLU0QBAMIztoUFcUI+nbnU4dQEEWCNozGT2BNXowAItZSjkdw7iiyWuPGFzb4xKnZ
	MaGA6XQFdlhphPBmyeh1GqICN2TDK79GxBY7Qx+HN9WojWJOCwwKhL/UpPAU/kYLXlcd8+sS5rfY8
	2c1QFv07BApR0URfskF73HFcLtxqg1ZqSIzQl7KWGf9i/60pakDLXxx0lICPQVHv0HXBCr48YOLzL
	PdPUIzXWYpirf1IERHRLppXz+A5bHryFJwVS0lDVBp23oeLIC3qFF+ivv9/uYDXT3CIE6sV4xv0h0
	yFTWuSqg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEprq-00000008Da3-1ybW;
	Mon, 20 Apr 2026 14:44:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07FFC301BDE; Mon, 20 Apr 2026 16:44:54 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:44:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: Re: [PATCH v7 2/5] bug/kunit: Reduce runtime impact of warning
 backtrace suppression
Message-ID: <20260420144453.GK3102624@noisy.programming.kicks-ass.net>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>

On Mon, Apr 20, 2026 at 02:28:04PM +0200, Albert Esteve wrote:
> From: Alessandro Carminati <acarmina@redhat.com>
> 
> KUnit support is not consistently present across distributions, some
> include it in their stock kernels, while others do not.
> While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
> features, the fact that some distros ship with KUnit enabled means it's
> important to minimize the runtime impact of this patch.
> 
> To that end, this patch adds an atomic counter that tracks the number
> of active suppressions. __kunit_is_suppressed_warning() checks this
> counter first and returns immediately when no suppressions are active,
> avoiding RCU-protected list traversal in the common case.
> 
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  lib/kunit/bug.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> index 356c8a5928828..a7a88f0670d44 100644
> --- a/lib/kunit/bug.c
> +++ b/lib/kunit/bug.c
> @@ -8,6 +8,7 @@
>  
>  #include <kunit/bug.h>
>  #include <kunit/resource.h>
> +#include <linux/atomic.h>
>  #include <linux/export.h>
>  #include <linux/rculist.h>
>  #include <linux/sched.h>
> @@ -15,11 +16,13 @@
>  #ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
>  
>  static LIST_HEAD(suppressed_warnings);
> +static atomic_t suppressed_warnings_cnt = ATOMIC_INIT(0);
>  
>  static void __kunit_suppress_warning_remove(struct __suppressed_warning *warning)
>  {
>  	list_del_rcu(&warning->node);
>  	synchronize_rcu(); /* Wait for readers to finish */
> +	atomic_dec(&suppressed_warnings_cnt);
>  }
>  
>  KUNIT_DEFINE_ACTION_WRAPPER(__kunit_suppress_warning_cleanup,
> @@ -37,6 +40,7 @@ __kunit_start_suppress_warning(struct kunit *test)
>  		return NULL;
>  
>  	warning->task = current;
> +	atomic_inc(&suppressed_warnings_cnt);
>  	list_add_rcu(&warning->node, &suppressed_warnings);
>  
>  	ret = kunit_add_action_or_reset(test,
> @@ -68,6 +72,9 @@ bool __kunit_is_suppressed_warning(void)
>  {
>  	struct __suppressed_warning *warning;
>  
> +	if (!atomic_read(&suppressed_warnings_cnt))
> +		return false;
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
>  		if (warning->task == current) {
> 

So the thing you're skipping is:

  rcu_read_lock();
  list_for_each_entry_rcu() {
  }
  rcu_read_unlock();

Which is really cheap. Did you actually have performance numbers for
this?

A possibly better option is to add a static_branch() that could elide
any and all memory access.
