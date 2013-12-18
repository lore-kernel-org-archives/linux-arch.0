From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 1/4] qrwlock: A queue read/write lock implementation
Date: Wed, 18 Dec 2013 20:46:15 +0100
Message-ID: <20131218194615.GG16438@laptop.programming.kicks-ass.net>
References: <1385147087-26588-1-git-send-email-Waiman.Long@hp.com>
 <1385147087-26588-2-git-send-email-Waiman.Long@hp.com>
 <20131217192128.GA15969@linux.vnet.ibm.com>
 <CA+55aFzNSZCKnuEm+CDWUN2G4bfrN+HafX8r13NcfT2tJ4h-jw@mail.gmail.com>
 <878uvilzka.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57585 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3LRTqk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2013 14:46:40 -0500
Content-Disposition: inline
In-Reply-To: <878uvilzka.fsf@tassilo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>

On Wed, Dec 18, 2013 at 11:38:29AM -0800, Andi Kleen wrote:
> (maybe it would be time to get rid of the patchable LOCK though?)

With the argument that Intel simply doesn't ship UP chips anymore, with
the exception of quark which should probably run custom UP kernels due
to size constraints anyway?
