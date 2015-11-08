From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 21/28] lkl tools: host lib: posix host operations
Date: Sun, 08 Nov 2015 11:35:46 +0100
Message-ID: <3793143.1m2WrnCXBd@wuerfel>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com> <42449799.QsmXDGnQ4P@wuerfel> <CAE1zotLiR_4KdPtVr8MANb2kKVhUZKzCCaUdEV=0cBTfkV2KQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60908 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbKHKf5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 8 Nov 2015 05:35:57 -0500
In-Reply-To: <CAE1zotLiR_4KdPtVr8MANb2kKVhUZKzCCaUdEV=0cBTfkV2KQw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Sunday 08 November 2015 06:01:08 Octavian Purdila wrote:
> >> +static void *sem_alloc(int count)
> >> +{
> >> +     struct pthread_sem *sem;
> >> +
> >> +     sem = malloc(sizeof(*sem));
> >> +     if (!sem)
> >> +             return NULL;
> >> +
> >> +     pthread_mutex_init(&sem->lock, NULL);
> >> +     sem->count = count;
> >> +     pthread_cond_init(&sem->cond, NULL);
> >> +
> >> +     return sem;
> >> +}
> >
> > What is the reason to have generalized semaphores in the
> > host API rather than a simple mutex?
> >
> 
> Currently waking up from idle after an IRQ event requires a semaphore.
> I'll see if we can use a simple mutex for this.

According to the pthread_mutex_unlock() man page, you are not allowed
to unlock a mutex from any thread other than the one that owns the
mutex through pthread_mutex_lock(), so if the IRQ event is sent to
another thread, that would not be safe even if it happens to work
on linux+glibc.

Another option would be to use futexes as the basic primitive, which
might make the implementation for Linux hosts a bit more efficient,
but complicates the implementation for hosts that do not implement
those.

	Arnd
