Return-Path: <SRS0=BIEI=4P=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgB0SDh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 13:03:37 -0500
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
References: <CAMe9rOqhf4y+e6h8i7P8+70pwLSg8n=ise6LEqABNPKarECdeA@mail.gmail.com>
 <FF42D299-D7A4-4884-9E45-DBEB5853FE56@amacapital.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e4027ef5-8e35-aeb2-c090-d3074aafe4cb@intel.com>
Date: Thu, 27 Feb 2020 10:03:36 -0800
MIME-Version: 1.0
In-Reply-To: <FF42D299-D7A4-4884-9E45-DBEB5853FE56@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, "H.J. Lu" <hjl.tools@gmail.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200227180336.i7VomPFQqQfFwkZBo-tXuhhOXx94coBbiXlDInXYHyg@z>

On 2/26/20 7:57 PM, Andy Lutomirski wrote:
>> GCC 8 or above is needed since vDSO must be compiled with 
>> --fcf-protection=branch.
> Fair enough. I don’t particularly want to carry a gross hack to add
> the ENDBRANCHes without compiler support.

Yeah, that's not worth it.

But my main issue the shadow stack instructions:

>> +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
>> +  ifeq ($(call as-instr, saveprevssp, y),)
>> +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
>> +  endif
>> +endif

Which are unrelated to ENDBRANCH.

But, in any case, let's say Kconfig says we should try to use IBT, but
we get to building the vDSO and don't have the right toolchain.  Do we
just stop the build?  Or do we let the build go on and then decline to
let folks enable IBT at runtime?
