From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 21/28] lkl tools: host lib: posix host operations
Date: Sun, 08 Nov 2015 00:16:40 +0100
Message-ID: <42449799.QsmXDGnQ4P@wuerfel>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com> <1446582059-17355-22-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58970 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091AbbKGXQu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 18:16:50 -0500
In-Reply-To: <1446582059-17355-22-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, thehajime@gmail.com

On Tuesday 03 November 2015 22:20:52 Octavian Purdila wrote:
> +struct pthread_sem {
> +	pthread_mutex_t lock;
> +	int count;
> +	pthread_cond_t cond;
> +};
> +
> +static void *sem_alloc(int count)
> +{
> +	struct pthread_sem *sem;
> +
> +	sem = malloc(sizeof(*sem));
> +	if (!sem)
> +		return NULL;
> +
> +	pthread_mutex_init(&sem->lock, NULL);
> +	sem->count = count;
> +	pthread_cond_init(&sem->cond, NULL);
> +
> +	return sem;
> +}

What is the reason to have generalized semaphores in the
host API rather than a simple mutex?

> +static unsigned long long time_ns(void)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +
> +	return tv.tv_sec * 1000000000ULL + tv.tv_usec * 1000ULL;
> +}

clock_gettime() has been around since POSIX.1-2001 and provides the
nanosecond resolution you use in the interface.

	Arnd
