Return-Path: <manfred@colorfullife.com>
Received: from zeus.kernel.org ([204.152.189.113]:25792 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262003AbUDJLpb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 10 Apr 2004 07:45:31 -0400
Received: from dbl.q-ag.de (dbl.q-ag.de [213.172.117.3] (may be forged))
	by zeus.kernel.org (8.11.6/8.11.6) with ESMTP id i3ABcsO12303
	for <linux-arch@vger.kernel.org>; Sat, 10 Apr 2004 04:38:55 -0700
Message-ID: <4077D851.7000008@colorfullife.com>
Date: Sat, 10 Apr 2004 13:19:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: Re: posix message queues
References: <20040407120720.6b937deb.akpm@osdl.org>	<40745360.6000709@colorfullife.com> <20040409164506.0611846a.davem@redhat.com>
In-Reply-To: <20040409164506.0611846a.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------000005010409060505030605"
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000005010409060505030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>On Wed, 07 Apr 2004 21:15:44 +0200
>Manfred Spraul <manfred@colorfullife.com> wrote:
>
>  
>
>>No. The unix spec mandates 'long' for the final C-library api. Using u32 
>>would mean that glibc would have to add an emulation layer in user space 
>>for 64-bit archs. In the long run, 64-bit kernels running 64-bit apps 
>>will be the common case. I don't want to add an emulation layer to the 
>>common case.
>>    
>>
>
>We need to support this stuff when running 32-bit apps, you cannot
>avoid this Manfred.
>
Of course. But the compat stuff is only used if a 32-bit app runs on a 
64-bit kernel. If I'd use u32 for the kernel interface, then a compat 
wrappers would be necessary if a 64-bit app runs on a 64-bit kernel, and 
that would be the wrong thing.

>  So we'll need kernel compat layer code to
>translate these structures containing 'long'.  Please code up the
>necessary compat.c code for this posix message queues feature.
>  
>
Arndt did 90% of the coding, it's already in 2.6.5-mm3. The only missing 
part was the SIGEV_THREAD handling, I've attached a patch that adds 
this, together a small user space test app.

--
    Manfred

--------------000005010409060505030605
Content-Type: text/x-csrc;
 name="mq_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mq_test.c"

/*
 * Test app for Linux Kernel posix message queues.
 *
 * Copyright (C) 2004 Manfred Spraul
 *
 * Redistribution of this file is permitted under the terms of the GNU 
 * Public License (GPL)
 * $Header: /home/manfred/cvs-tree/mq/mq_test.c,v 1.3 2004/04/10 11:17:31 manfred Exp $
 */
#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <string.h>
#include <limits.h>


/*
 * Kernel-interface based on the Mqueue library:
 *
 * Copyright (C) 2003 Krzysztof Benedyczak & Michal Wronski

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   It is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this software; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.
 */

/****************** implementation *****************/

#define __NR_mq_open		277

#define __NR_mq_unlink		(__NR_mq_open+1)
#define __NR_mq_timedsend	(__NR_mq_open+2)
#define __NR_mq_timedreceive	(__NR_mq_open+3)
#define __NR_mq_notify		(__NR_mq_open+4)
#define __NR_mq_getsetattr	(__NR_mq_open+5)


#define MQ_PRIO_MAX 	32768

typedef int mqd_t;

struct mq_attr {
	long	mq_flags;	/* message queue flags			*/
	long	mq_maxmsg;	/* maximum number of messages		*/
	long	mq_msgsize;	/* maximum message size			*/
	long	mq_curmsgs;	/* number of messages currently queued	*/
	long	__reserved[4];	/* unused */
};

#include <signal.h>
#include <fcntl.h>
#include <time.h>
#include <stdarg.h>

mqd_t mq_open(const char *name, int oflag, /* mode_t mode, struct mq_attr *attr */ ...);
int mq_close(mqd_t mqdes);
int mq_unlink(const char *name);
int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len, unsigned int msg_prio);
int mq_timedsend(mqd_t mqdes, const char *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec *abs_timeout);
ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len, unsigned int *msg_prio);
ssize_t mq_timedreceive(mqd_t mqdes, char *__restrict msg_ptr, size_t msg_len, unsigned int *__restrict msg_prio, const struct timespec *__restrict abs_timeout);
int mq_notify(mqd_t mqdes, const struct sigevent *notification);
int mq_getattr(mqd_t mqdes, struct mq_attr *mqstat);
int mq_setattr(mqd_t mqdes, const struct mq_attr *__restrict mqstat, struct mq_attr *__restrict omqstat);

/*
 * kernel interfaces.  We use glibc's syscall(3) instead of the macros
 * _syscall1, _syscall2, etc, as the macros generate compilation errors
 * when mqueue.c is built as a dynamic shared library.
 */
static inline mqd_t __mq_open(const char  *name,
				int oflag, mode_t mode, struct mq_attr* attr)
{
	return syscall(__NR_mq_open, name, oflag, mode, attr);
}

static inline int __mq_unlink(const char *name)
{
	return syscall(__NR_mq_unlink, name);
}

static inline int __mq_notify(mqd_t mqdes, const struct sigevent *notification)
{
	return syscall(__NR_mq_notify, mqdes, notification);
}

static inline int __mq_getsetattr(mqd_t mqdes, const struct mq_attr *mqstat, struct mq_attr *omqstat)
{
	return syscall(__NR_mq_getsetattr, mqdes, mqstat, omqstat);
}

static inline int __mq_timedsend(mqd_t mqdes, const char *msg_ptr,
				size_t msg_len, unsigned int msg_prio,
				const struct timespec *abs_timeout)
{
	return syscall(__NR_mq_timedsend, mqdes, msg_ptr, msg_len,
		msg_prio, abs_timeout);
}

static inline ssize_t __mq_timedreceive(mqd_t mqdes, char *msg_ptr,
				size_t msg_len, unsigned int *msg_prio,
				const struct timespec *abs_timeout)
{
	return syscall(__NR_mq_timedreceive, mqdes, msg_ptr, msg_len,
		msg_prio, abs_timeout);
}

static inline int is_valid_path(const char *name)
{
	if (name[0] != '/') {
		errno = EINVAL;
		return -1;
	}
	return 0;
}
/*
 * application-visible wrappers around the kernel interfaces
 */

mqd_t mq_open(const char *name, int oflag, ...)
{
	unsigned long 	mode;
	struct mq_attr 	*attr;
	va_list 	ap;

	va_start(ap, oflag);
	mode = va_arg(ap, unsigned long);
	attr = va_arg(ap, struct mq_attr *);
	va_end(ap);

	if (is_valid_path(name) < 0)
		return (mqd_t)-1;

	/* omit leading slash */
	return __mq_open(name + 1, oflag, mode, attr);
}

int mq_close(mqd_t mqdes)
{
	return close(mqdes);
}

int mq_unlink(const char *name)
{
	if (is_valid_path(name) < 0)
		return -1;
	
	return __mq_unlink(name+1);
}

int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
					unsigned int msg_prio)
{
	return __mq_timedsend(mqdes, msg_ptr, msg_len, msg_prio, NULL);
}

ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len,
					unsigned int *msg_prio)
{
	return __mq_timedreceive(mqdes, msg_ptr, msg_len, msg_prio, NULL);
}

int mq_timedsend(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
					unsigned int msg_prio,
					const struct timespec *abs_timeout)
{
	return __mq_timedsend(mqdes, msg_ptr, msg_len, msg_prio, abs_timeout);
}

ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr, size_t msg_len,
					unsigned int *msg_prio,
					const struct timespec *abs_timeout)
{
	return __mq_timedreceive(mqdes, msg_ptr, msg_len, msg_prio,
		abs_timeout);
}

int mq_getattr(mqd_t mqdes, struct mq_attr *mqstat)
{
	return __mq_getsetattr(mqdes, NULL, mqstat);
}

int mq_setattr( mqd_t mqdes, const struct mq_attr *mqstat,
					struct mq_attr *omqstat)
{
	return __mq_getsetattr(mqdes, mqstat, omqstat);
}

int mq_notify(mqd_t mqdes, const struct sigevent *notification)
{
	return __mq_notify(mqdes, notification);
}

int got_signal = 0;
void usr1_handler(int unused)
{
	printf("usr1 signal caught.\n");
	got_signal = 1;
}

char buffer[131072];

int main(int argc, char **argv)
{
static const char qname[] = "/test_123";
        int err;
        mqd_t m, m2;
	struct mq_attr ma;

	printf("Test 1: mq_open()\n");
	m = mq_open(qname, O_CREAT|O_RDWR, S_IRUSR | S_IWUSR, NULL);
	if (m == -1) {
	        printf("mq_open() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 2: check exclusive open()\n");
	m2 = mq_open(qname, O_EXCL|O_CREAT|O_RDWR, S_IRUSR | S_IWUSR, NULL);
	if (m2 != -1 || errno != EEXIST) {
	        printf("mq_open() succeeded or wrong errno (%d).\n", errno);
		return 1;
	}

	printf("Test 3: close handle\n");
	err = mq_close(m);

	if (err) {
		printf("mq_close() failed.\n");
	}

	printf("Test 4: mq_unlink\n");
	err = mq_unlink(qname);
	if (err) {
	        printf("mq_unlink() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 4: mq_unlink on nonexisting file\n");
	err = mq_unlink(qname);
	if (err != -1 || errno != ENOENT) {
	        printf("mq_unlink() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 5: mq_open()\n");
	m = mq_open(qname, O_CREAT|O_EXCL|O_RDWR, S_IRUSR | S_IWUSR, NULL);
	if (m == -1) {
	        printf("mq_open() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 6: mq_getattr()\n");
	err = mq_getattr(m, &ma);
	if (err || ma.mq_curmsgs != 0) {
	        printf("mq_getattr() failed,  errno %d, curmsg %ld.\n", errno, ma.mq_curmsgs);
		return 1;
	}

	printf("Test 7: setup signal based notify().\n");

	signal (SIGUSR1,usr1_handler);

	struct sigevent event;
	event.sigev_notify = SIGEV_SIGNAL;
	event.sigev_signo = SIGUSR1;
	err = mq_notify(m, &event);
	if (err) {
	        printf("mq_notify() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 8: mq_send()\n");
	err = mq_send(m, qname, strlen(qname), 1);
	if (err) {
	        printf("mq_send() failed,  errno %d.\n", errno);
		return 1;
	}
	if (!got_signal) {
		printf("No signal received.\n");
		return 1;
	}

	printf("Test 9: mq_getattr() with one pending message\n");
	err = mq_getattr(m, &ma);
	if (err || ma.mq_curmsgs != 1) {
	        printf("mq_getattr() failed,  errno %d, curmsg %ld.\n", errno, ma.mq_curmsgs);
		return 1;
	}

	printf("Test 10: mq_receive()\n");
	err = mq_receive(m, buffer, sizeof(buffer), NULL);
	if (err < 0) {
	        printf("mq_receive() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 11: data comparison\n");
	if (strcmp(qname, buffer)) {
		printf("Data mismatch!!!.\n");
		return 1;
	}

	printf("Test 12: request notification cookie.\n");
	{
		int fd, i;
		char inc[32], outc[64];


		fd = socket(PF_NETLINK, SOCK_RAW, 0);
		if (fd == -1) {
			printf("opening netlink socket failed, errno %d.\n", errno);
			return 1;
		}

		for (i=0;i<32;i++)
			inc[i] = 64+2*i;

		event.sigev_notify = SIGEV_THREAD;
		event.sigev_signo = fd;
		event.sigev_value.sival_ptr = inc;
		err = mq_notify(m, &event);
		if (err < 0) {
			 printf("mq_notify() failed,  errno %d.\n", errno);
			return 1;
		}
		err = mq_send(m, qname, strlen(qname), 1);
		if (err) {
		        printf("mq_send() failed,  errno %d.\n", errno);
			return 1;
		}
		err = recv(fd, outc, sizeof(outc), MSG_NOSIGNAL|MSG_DONTWAIT);
		if (err != 32) {
			printf("recv unexpected result %d, errno %d.\n", err, errno);
			return 1;
		}
		for (i=0;i<31;i++) {
			if (outc[i] != 64+2*i) {
				printf("Data mismatch in cookie at offset %d: %d.\n",
						i, outc[i]);
				return 1;
			}
		}
		if (outc[31] != 1) {
			printf("state mismatch in cookie: got %d.\n", outc[31]);
		}
	}

	printf("Test 13: another mq_unlink\n");
	err = mq_unlink(qname);
	if (err) {
	        printf("mq_unlink() failed,  errno %d.\n", errno);
		return 1;
	}

	printf("Test 14: mq_close()\n");
	err = mq_close(m);
	if (err) {
		printf("mq_close() failed, errno %d.\n", errno);
		return 1;
	}
	return 0;
}

--------------000005010409060505030605
Content-Type: text/plain;
 name="patch-mqueue-compat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mqueue-compat"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 5
//  EXTRAVERSION = -mm3
--- 2.6/ipc/compat_mq.c	2004-04-10 09:59:40.000000000 +0200
+++ build-2.6/ipc/compat_mq.c	2004-04-10 13:15:40.414231437 +0200
@@ -139,6 +139,7 @@
 {
 	mm_segment_t oldfs;
 	struct sigevent notification;
+	char cookie[NOTIFY_COOKIE_LEN];
 	long ret;
 
 	if (!u_notification)
@@ -147,6 +148,14 @@
 	if (get_compat_sigevent(&notification, u_notification))
 		return -EFAULT;
 
+	if (notification.sigev_notify == SIGEV_THREAD) {
+		if (copy_from_user(cookie, u_notification.sigev_value.sival_ptr,
+					NOTIFY_COOKIE_LEN)) {
+			return -EFAULT;
+		}
+		notification.sigev_value.sival_ptr = cookie;
+	}
+
 	oldfs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_mq_notify(mqdes, &notification);

--------------000005010409060505030605--
