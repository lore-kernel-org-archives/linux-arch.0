From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] UNREACHABLE() macro
Date: Fri, 11 Sep 2009 13:45:28 -0700
Message-ID: <20090911134528.cd1782d9.akpm@linux-foundation.org>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
	<20090910020031.87DC68BF6E@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37722 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754001AbZIKUql (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Sep 2009 16:46:41 -0400
In-Reply-To: <20090910020031.87DC68BF6E@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@linux-foundation.org, jakub@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On Wed,  9 Sep 2009 19:00:31 -0700 (PDT)
Roland McGrath <roland@redhat.com> wrote:

> +/*
> + * __builtin_unreachable is available in GCC 4.5+ and
> + * also in Fedora/Red Hat GCC 4.4.1-10+.
> + */
> +#if (__GNUC_MINOR__ > 4					\
> +     || (__GNUC_MINOR__ == 4				\
> +	 && defined __GNUC_RH_RELEASE__			\
> +	 && (__GNUC_PATCHLEVEL__ > 1			\
> +	     || (__GNUC_PATCHLEVEL__ == 1		\
> +		 && __GNUC_RH_RELEASE__ >= 10))))
> +#define UNREACHABLE()		__builtin_unreachable()
> +#endif

That's a bit of a mouthful.  Did you consider a runtime probe with
scripts/Kbuild.include's try-run, cc-option, etc?  
