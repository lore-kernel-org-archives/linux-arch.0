Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:2781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264156AbUDGTFK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2004 15:05:10 -0400
Date: Wed, 7 Apr 2004 12:07:20 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: posix message queues
Message-Id: <20040407120720.6b937deb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Manfred, if/when this gets merged up the long-suffering arch maintainers
might appreciate a little test app to exercise the syscalls which must be
added.  Do you have something suitable at hand?


Also, before we go too far the 64-bit guys may like to comment on the
syscall interface.   For example, this:

struct mq_attr {
	long	mq_flags;	/* message queue flags			*/
	long	mq_maxmsg;	/* maximum number of messages		*/
	long	mq_msgsize;	/* maximum message size			*/
	long	mq_curmsgs;	/* number of messages currently queued	*/
	long	__reserved[4];	/* ignored for input, zeroed for output */
};

looks like it will require emulation for 32-bit apps.  But if we were to
make these __u32 perhaps that could be avoided?

The patches are at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-01-codemove.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-02-syscalls.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-03-core-update.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-03-core.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-04-linuxext-poll.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-05-linuxext-mount.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-security-fix.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/broken-out/mq-update-01.patch
