From: Andreas Schwab <schwab@redhat.com>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Thu, 18 Mar 2010 17:21:06 +0100
Message-ID: <m37hp9y51p.fsf@hase.home>
References: <20100315134449.GB1653@linux-mips.org>
	<4B9E4EB1.9010800@zytor.com> <4B9E59B7.6060405@redhat.com>
	<20100315.120004.209998642.davem@davemloft.net>
	<4B9E8D67.8040209@zytor.com> <1268685311.2335.38.camel@pasglop>
	<1268776570.19726.98.camel@spokane1.rchland.ibm.com>
	<1268785874.2335.137.camel@pasglop> <4BA06E1B.2040706@redhat.com>
	<1268816179.2335.187.camel@pasglop> <4BA11FD2.2090104@zytor.com>
	<1268858134.2335.198.camel@pasglop> <4BA1412C.6070008@zytor.com>
	<1268866720.2335.204.camel@pasglop>
	<1268928480.19726.123.camel@spokane1.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268928480.19726.123.camel@spokane1.rchland.ibm.com> (Steven
	Munroe's message of "Thu, 18 Mar 2010 11:08:00 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: munroesj@us.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Ulrich Drepper <drepper@redhat.com>, David Miller <davem@davemloft.net>, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Steven Munroe <munroesj@linux.vnet.ibm.com> writes:

> extern long int syscall (long int __sysno, ...) __THROW;
>
> #endif	/* Use misc.  */
>
> Changing this would be an ABI change and would have to be versioned. It
> would effect any one using syscall not just SYS_fallocate.
>
> the question is do programmers in practice include unistd.h when they
> use syscall.
>
> If the changed prototype is not in scope then the 1st parm (__sysno)
> defaults to int and is passed in on r3 which gets moved to r0.

int is incompatible with long, so you already get undefined behaviour
anyway.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
