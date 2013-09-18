From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/4] gcov: add support for gcc 4.7 gcov format
Date: Wed, 18 Sep 2013 14:27:05 -0700
Message-ID: <1379539625.1787.77.camel@joe-AO722>
References: <1378305776-3644-1-git-send-email-fhrbata@redhat.com>
	 <1378305776-3644-3-git-send-email-fhrbata@redhat.com>
	 <20130918142259.8c504e7cfbc8318a0550a891@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130918142259.8c504e7cfbc8318a0550a891@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frantisek Hrbata <fhrbata@redhat.com>, linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com
List-Id: linux-arch.vger.kernel.org

On Wed, 2013-09-18 at 14:22 -0700, Andrew Morton wrote:
> On Wed,  4 Sep 2013 16:42:54 +0200 Frantisek Hrbata <fhrbata@redhat.com> wrote:
> > The gcov in-memory format changed in gcc 4.7. The biggest change, which
> > requires this special implementation, is that gcov_info no longer contains
> > array of counters for each counter type for all functions and gcov_fn_info is
> > not used for mapping of function's counters to these arrays(offset). Now each
> > gcov_fn_info contans it's counters, which makes things a little bit easier.
> > 
> > This is heavily based on the previous gcc_3_4.c implementation and patches
> > provided by Peter Oberparleiter. Specially the buffer gcda implementation for
> > iterator.
> 
> A couple of little tweaks:
[]
> +++ a/kernel/gcov/gcc_4_7.c
[]
> @@ -267,8 +266,8 @@ struct gcov_info *gcov_info_dup(struct g
>  	if (!dup->filename)
>  		goto err_free;
>  
> -	dup->functions = kzalloc(sizeof(struct gcov_fn_info *) *
> -			info->n_functions, GFP_KERNEL);
> +	dup->functions = kcalloc(sizeof(struct gcov_fn_info *),
> +				 info->n_functions, GFP_KERNEL);

kcalloc(n, size_t, flags)

	dup->functions = kcalloc(info->n_functions,
				 sizeof(struct gcov_fn_info *), GFP_KERNEL);
