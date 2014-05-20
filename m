From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 14/20] arch,mn10300: Fold atomic_ops
Date: Tue, 20 May 2014 14:05:32 +0100
Message-ID: <26031.1400591132@warthog.procyon.org.uk>
References: <20140508135852.605324173@infradead.org> <20140508135840.956784204@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbaETNGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 May 2014 09:06:21 -0400
In-Reply-To: <20140508135852.605324173@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>

Peter Zijlstra <peterz@infradead.org> wrote:

> +#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)

Can ATOMIC_OP() just be an alias for ATOMIC_OP_RETURN() where that is
appropriate?  I suspect several arches (MN10300 included) are going to return
the value *anyway*.

David
