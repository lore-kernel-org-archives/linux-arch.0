Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33194 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH0Wqc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 18:46:32 -0400
Message-ID: <6c3dc33e16c8bbb6d45c0a6ec7c684de197fa065.camel@intel.com>
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 27 Aug 2019 15:37:12 -0700
In-Reply-To: <20190823140233.GC2332@hirez.programming.kicks-ass.net>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
         <20190813205225.12032-12-yu-cheng.yu@intel.com>
         <20190823140233.GC2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190827223712.6cgfI4w3pAcZ2ooHKYaYEjX1K2EWrd3Mz_cUDhrv2P4@z>

On Fri, 2019-08-23 at 16:02 +0200, Peter Zijlstra wrote:
> On Tue, Aug 13, 2019 at 01:52:09PM -0700, Yu-cheng Yu wrote:
> 
> > +static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
> > +{
> > +	if (pte_flags(pte) & from)
> > +		pte = pte_set_flags(pte_clear_flags(pte, from), to);
> > +	return pte;
> > +}
> 
> Aside of the whole conditional thing (I agree it would be better to have
> this unconditionally); the function doesn't really do as advertised.
> 
> That is, if @from is clear, it doesn't endeavour to make sure @to is
> also clear.
> 
> Now it might be sufficient, but in that case it really needs a comment
> and or different name.
> 
> An implementation that actually moves the bit is something like:
> 
> 	pteval_t a,b;
> 
> 	a = native_pte_value(pte);
> 	b = (a >> from_bit) & 1;
> 	a &= ~((1ULL << from_bit) | (1ULL << to_bit));
> 	a |= b << to_bit;
> 	return make_native_pte(a);

There can be places calling pte_wrprotect() on a PTE that is already RO +
DIRTY_SW.  Then in pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW) we do not
 want to clear _PAGE_DIRTY_SW.  But, I will look into this and make it more
obvious.

Thanks,
Yu-cheng  
