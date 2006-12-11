Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762783AbWLKLEk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Dec 2006 06:04:40 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061208190403.GH31068@flint.arm.linux.org.uk> 
References: <20061208190403.GH31068@flint.arm.linux.org.uk>  <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org> 
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it 
Date: Mon, 11 Dec 2006 11:04:00 +0000
Message-ID: <17007.1165835040@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Yes you can.  Well, you can on ARM at least.  Between the load exclusive
> you can do anything you like until you hit the store exclusive.

How come atomic_set() on arm6 is implemented as:

	static inline void atomic_set(atomic_t *v, int i)
	{
		unsigned long tmp;

		__asm__ __volatile__("@ atomic_set\n"
	"1:	ldrex	%0, [%1]\n"
	"	strex	%0, %2, [%1]\n"
	"	teq	%0, #0\n"
	"	bne	1b"
		: "=&r" (tmp)
		: "r" (&v->counter), "r" (i)
		: "cc");
	}

Why LDREX/STREX and not direct assignment?

David
