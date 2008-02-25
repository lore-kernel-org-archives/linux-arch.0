Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbYBYOEU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Feb 2008 09:04:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b647ffbd0802231151w481fdcb5hc2a3972e7fd03f69@mail.gmail.com>
References: <b647ffbd0802231151w481fdcb5hc2a3972e7fd03f69@mail.gmail.com> <200802230733.m1N7XnMu018253@imap1.linux-foundation.org> <20080223162705.GA7686@tv-sign.ru> <alpine.LFD.1.00.0802230937530.21332@woody.linux-foundation.org> <20080223182258.GA19946@tv-sign.ru> <alpine.LFD.1.00.0802231044240.21332@woody.linux-foundation.org> 
Subject: Re: + kthread-add-a-missing-memory-barrier-to-kthread_stop.patch added to -mm tree
Date: Mon, 25 Feb 2008 13:55:50 +0000
Message-ID: <7789.1203947750@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, a.p.zijlstra@chello.nl, apw@shadowen.org, Ingo Molnar <mingo@elte.hu>, nickpiggin@yahoo.com.au, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

Dmitry Adamushko <dmitry.adamushko@gmail.com> wrote:

> (3)
> 
> LOCK
> 
> LOAD(a)
> MODIFY(b)
> 
> UNLOCK
> 
> and this last one is a problem. No?

I assume you meant:

	LOCK
	LOAD(b)
	MODIFY(a)
	UNLOCK

David
