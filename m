Return-Path: <zaitcev@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:14296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264225AbUFCX1c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2004 19:27:32 -0400
Date: Thu, 3 Jun 2004 16:27:20 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: FUTEX_CMP_REQUEUE and 6-argument syscall
Message-Id: <20040603162720.569a47c5.zaitcev@redhat.com>
In-Reply-To: <20040603142630.6004d38f.davem@redhat.com>
References: <20040603110221.1fe58b53.zaitcev@redhat.com>
	<20040603181345.GA26083@linux-mips.org>
	<20040603142630.6004d38f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: ralf@linux-mips.org, schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, akpm@osdl.org, jakub@redhat.com, zaitcev@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 3 Jun 2004 14:26:30 -0700
"David S. Miller" <davem@redhat.com> wrote:

> > 6 is the limit on o32 MIPS where we pass 4 arguments in registers and two
> > on the stack but it would be easy to extend that.  On 64-bit kernels we
> > only use upto 8 register arguments but no stack arguments ever so I hope
> > we don't exceed that limit ever ...
> 
> 6 is the limit on Sparc/Sparc64 as well, registers %o0 - %o5 carry
> arguments.

It seems that bumping the limit just to 6 would bring s390 in line
with sparcs, this is why I even considered using %r7 to pass the
argument itself instead of a pointer to stack. It's such a bother
to have things in memory.

-- Pete

P.S. Ralf, et. al.: do not forget to keep me on the cc: list, please.
