Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:4566 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261741AbUDHOIU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2004 10:08:20 -0400
Message-ID: <40755CCA.8030507@colorfullife.com>
Date: Thu, 08 Apr 2004 16:08:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: Re: posix message queues
References: <20040407120720.6b937deb.akpm@osdl.org> <40745360.6000709@colorfullife.com> <200404081017.46132.arnd@arndb.de>
In-Reply-To: <200404081017.46132.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann wrote:

>What worries me more than mq_attr compatibility is the conversion
>of struct sigevent, which might turn out really hard when more
>fields in there are used.
>
What is the problem for the wrappers with sigevent?

>+
>+static int get_compat_sigevent(struct sigevent *event,
>+		const struct compat_sigevent __user *u_event)
>+{
>+	if (verify_area(VERIFY_READ, u_event, sizeof(*u_event)))
>+		return -EFAULT;
>+
>+	return __get_user(event->sigev_value.sival_int,
>+			  &u_event->sigev_value.sival_int)
>+	     | __get_user(event->sigev_signo, &u_event->sigev_signo)
>+	     | __get_user(event->sigev_notify, &u_event->sigev_notify)
>+	     | __get_user(event->sigev_notify_thread_id,
>+			  &u_event->sigev_notify_thread_id);
>+}
>+
>
The dangerous case for the wrappers is mq_notify for SIGEV_THREAD: The 
kernel will read (with copy_from_user()) from the pointer 
u_event->sigev_value.sival_ptr. Fixed 32-byte buffer. The data is opaque 
- the kernel copies it back to the same process without any 
interpretation. Would that work on all archs?

--
    Manfred
