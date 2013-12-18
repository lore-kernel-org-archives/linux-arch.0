From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v7 1/4] qrwlock: A queue read/write lock implementation
Date: Wed, 18 Dec 2013 11:38:29 -0800
Message-ID: <878uvilzka.fsf@tassilo.jf.intel.com>
References: <1385147087-26588-1-git-send-email-Waiman.Long@hp.com>
	<1385147087-26588-2-git-send-email-Waiman.Long@hp.com>
	<20131217192128.GA15969@linux.vnet.ibm.com>
	<CA+55aFzNSZCKnuEm+CDWUN2G4bfrN+HafX8r13NcfT2tJ4h-jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31819 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805Ab3LRTib (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Dec 2013 14:38:31 -0500
In-Reply-To: <CA+55aFzNSZCKnuEm+CDWUN2G4bfrN+HafX8r13NcfT2tJ4h-jw@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 17 Dec 2013 11:27:29 -0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>

Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> In this case, we seem to want the xadd() semantics. I guess we can use
> "atomic_add_return(val,&atomic)-val" and just assume that the compiler
> gets it right (with the addition and the subtraction cancelling out).

It can't, as we use inline assembler. 

In theory it could with __sync_* or __atomic_* intrinsics but we
traditionally don't use them as they don't support patchable LOCK

(maybe it would be time to get rid of the patchable LOCK though?)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
