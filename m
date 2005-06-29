Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j5TB6wYM031875
	for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2005 07:06:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j5TB6wKI249068
	for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2005 07:06:58 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j5TB6vAF009143
	for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2005 07:06:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: is_compat_task
Date: Wed, 29 Jun 2005 13:01:12 +0200
References: <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628.134736.45885284.davem@davemloft.net> <20050629164127.58e97376.sfr@canb.auug.org.au>
In-Reply-To: <20050629164127.58e97376.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506291301.14117.arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, matthew@wil.cx, ak@suse.de, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Middeweken 29 Juni 2005 08:41, Stephen Rothwell wrote:
> How about the patch below which defines is_compat_syscall() for ppc64 (and
> all the non-compat-requiring archs)?  (Yes, the ppc64 syscall entry really
> checks the thread flag.) The patch alos includes the fixes for the input
> layer mess.

Looks ok to me (as in better than all the previous alternatives), though I've
been wondering what is_compat_task() should return outside of syscall context,
e.g. in the exception path or in softirq. I guess the safe choice here would
be to BUG(), but maybe it's just not important.

> If this is acceptable, I will try to figure out what the macro should be
> for the other 64 bit architectures.

Martin Schwidefsky is on holidays this week, so he won't be able to comment
on the s390 part. Testing TIF_31BIT should be the right thing to do there,
for a reason similar to what you wrote about ppc64. The s390 entry code checks
the addressing mode of the user task, which is always set together with the
TIF bit.

	Arnd <><
