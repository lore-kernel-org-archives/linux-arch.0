Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:37787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264308AbUFCV2Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2004 17:28:16 -0400
Date: Thu, 3 Jun 2004 14:26:30 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: FUTEX_CMP_REQUEUE and 6-argument syscall
Message-Id: <20040603142630.6004d38f.davem@redhat.com>
In-Reply-To: <20040603181345.GA26083@linux-mips.org>
References: <20040603110221.1fe58b53.zaitcev@redhat.com>
	<20040603181345.GA26083@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: zaitcev@redhat.com, schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, akpm@osdl.org, jakub@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 3 Jun 2004 20:13:45 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> > I'm curious if any other architecture was caught out by this.
> 
> 6 is the limit on o32 MIPS where we pass 4 arguments in registers and two
> on the stack but it would be easy to extend that.  On 64-bit kernels we
> only use upto 8 register arguments but no stack arguments ever so I hope
> we don't exceed that limit ever ...

6 is the limit on Sparc/Sparc64 as well, registers %o0 - %o5 carry
arguments.
