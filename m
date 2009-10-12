From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Date: Mon, 12 Oct 2009 20:10:37 +0200
Message-ID: <87ws30fppe.fsf@basil.nowhere.org>
References: <1255016123.17055.17.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757502AbZJLSLQ@vger.kernel.org>
In-Reply-To: <1255016123.17055.17.camel@laptop> (Peter Zijlstra's message of "Thu, 08 Oct 2009 17:35:23 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, David Howells <dhowells@redhat.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> -
> -static inline void debug_kmap_atomic(enum km_type type)
> +static inline int kmap_atomic_push_idx(void)
>  {
> +	int idx = __get_cpu_var(__kmap_atomic_depth)++;

The counter needs to be of local atomic type. Otherwise kmap_atomic cannot
be done from interrupts/nmis, which is unfortunately occasionally needed.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
