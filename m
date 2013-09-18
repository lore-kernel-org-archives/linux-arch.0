Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:40430 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753885Ab3IRVhb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Sep 2013 17:37:31 -0400
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 8042221175B
	for <linux-arch@vger.kernel.org>; Wed, 18 Sep 2013 21:27:50 +0000 (UTC)
Message-ID: <1379539625.1787.77.camel@joe-AO722>
Subject: Re: [PATCH v2 2/4] gcov: add support for gcc 4.7 gcov format
From: Joe Perches <joe@perches.com>
Date: Wed, 18 Sep 2013 14:27:05 -0700
In-Reply-To: <20130918142259.8c504e7cfbc8318a0550a891@linux-foundation.org>
References: <1378305776-3644-1-git-send-email-fhrbata@redhat.com>
	 <1378305776-3644-3-git-send-email-fhrbata@redhat.com>
	 <20130918142259.8c504e7cfbc8318a0550a891@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frantisek Hrbata <fhrbata@redhat.com>, linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com
Message-ID: <20130918212705.3COVzhftA2DPhgm1n8mTW7ZfkmVJqlkusZM5cH44yTw@z>

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


