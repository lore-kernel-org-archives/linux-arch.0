Return-Path: <ralf@linux-mips.org>
Received: from p508B7B0E.dip.t-dialin.net ([80.139.123.14]:10550 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264061AbUFCSOB
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 Jun 2004 14:14:01 -0400
Date: Thu, 3 Jun 2004 20:13:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: FUTEX_CMP_REQUEUE and 6-argument syscall
Message-ID: <20040603181345.GA26083@linux-mips.org>
References: <20040603110221.1fe58b53.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603110221.1fe58b53.zaitcev@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, akpm@osdl.org, jakub@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jun 03, 2004 at 11:02:21AM -0700, Pete Zaitcev wrote:

> So, now we have a syscall with 6 arguments. Do you have any suggestions
> how to handle it on s390? The main decision would be if we stick to
> the C calling convention and put a pointer to the list into %r7, or
> if we just put the argument into %r7 (thus precluding syscalls with
> 7 arguments for sure, but saving a get_user somewhere). After that
> we need to change arch/s390/kernel/entry.S:trace_svc, and the 31 bit
> compat wrapper.
> 
> I'm curious if any other architecture was caught out by this.

6 is the limit on o32 MIPS where we pass 4 arguments in registers and two
on the stack but it would be easy to extend that.  On 64-bit kernels we
only use upto 8 register arguments but no stack arguments ever so I hope
we don't exceed that limit ever ...

  Ralf
