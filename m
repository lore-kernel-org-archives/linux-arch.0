Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:33711 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbeGJWp7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Jul 2018 18:45:59 -0400
Subject: Re: [RFC PATCH v2 11/27] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-12-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <fbf45667-5388-44a6-1f22-07bcc03e1804@linux.intel.com>
Date: Tue, 10 Jul 2018 15:44:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180710222639.8241-12-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180710224432.ShxPJ9xDaZds6NthAdBiCcxq9dQQvwxEZhZaEEznHHI@z>

On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> +	/*
> +	 * On platforms before CET, other threads could race to
> +	 * create a RO and _PAGE_DIRTY_HW PMD again.  However,
> +	 * on CET platforms, this is safe without a TLB flush.
> +	 */

If I didn't work for Intel, I'd wonder what the heck CET is and what the
heck it has to do with _PAGE_DIRTY_HW.  I think we need a better comment
than this.  How about:

	Some processors can _start_ a write, but end up seeing
	a read-only PTE by the time they get to getting the
	Dirty bit.  In this case, they will set the Dirty bit,
	leaving a read-only, Dirty PTE which looks like a Shadow
	Stack PTE.

	However, this behavior has been improved and will *not* occur on
	processors supporting Shadow Stacks.  Without this guarantee, a
	transition to a non-present PTE and flush the TLB would be
	needed.
	
