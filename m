Return-Path: <zaitcev@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:27275 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263923AbUFCSCZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2004 14:02:25 -0400
Date: Thu, 3 Jun 2004 11:02:21 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
Subject: FUTEX_CMP_REQUEUE and 6-argument syscall
Message-Id: <20040603110221.1fe58b53.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, zaitcev@redhat.com, akpm@osdl.org, jakub@redhat.com
List-ID: <linux-arch.vger.kernel.org>

Hi, Martin,

the following changeset adds an extra argument for sys_futex:
 http://linux.bkbits.net:8080/linux-2.5/gnupatch@40bca55f9uSk3jznb3RD7ltnQvJKbA

So, now we have a syscall with 6 arguments. Do you have any suggestions
how to handle it on s390? The main decision would be if we stick to
the C calling convention and put a pointer to the list into %r7, or
if we just put the argument into %r7 (thus precluding syscalls with
7 arguments for sure, but saving a get_user somewhere). After that
we need to change arch/s390/kernel/entry.S:trace_svc, and the 31 bit
compat wrapper.

I'm curious if any other architecture was caught out by this.

-- Pete
