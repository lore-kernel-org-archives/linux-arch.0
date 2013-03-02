Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab3CBRJE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Mar 2013 12:09:04 -0500
Date: Sat, 2 Mar 2013 18:06:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] lglock: add read-preference local-global rwlock
Message-ID: <20130302170656.GB29769@redhat.com>
References: <512C7A38.8060906@linux.vnet.ibm.com> <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com> <512CC509.1050000@linux.vnet.ibm.com> <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com> <512D0D67.9010609@linux.vnet.ibm.com> <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com> <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com> <20130301182854.GA3631@redhat.com> <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michel Lespinasse <walken@google.com>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Lai Jiangshan <eag0628@gmail.com>, linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org, rjw@sisk.pl, vincent.guittot@linaro.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20130302170656.r6V4X82HvQXQ8aIpWJfPLyBwjYmgVVFDCPUvN1mRDUY@z>

On 03/02, Michel Lespinasse wrote:
>
> My version would be slower if it needs to take the
> slow path in a reentrant way, but I'm not sure it matters either :)

I'd say, this doesn't matter at all, simply because this can only happen
if we race with the active writer.

Oleg.

