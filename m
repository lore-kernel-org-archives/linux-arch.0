Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42978 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387934AbeGMCCr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jul 2018 22:02:47 -0400
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-19-yu-cheng.yu@intel.com>
 <bbb487cc-ac1c-f734-eee3-2463a0ba7efc@linux.intel.com>
 <1531436398.2965.18.camel@intel.com>
 <46784af0-6fbb-522d-6acb-c6248e5e0e0d@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <167645aa-f1c7-bd6a-c7e0-2da317cbbaba@intel.com>
Date: Thu, 12 Jul 2018 18:50:29 -0700
MIME-Version: 1.0
In-Reply-To: <46784af0-6fbb-522d-6acb-c6248e5e0e0d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180713015029.yWe6-RddUoUrTrXFCYL-heKS4P-Majslgim6JOmIC8o@z>

On 07/12/2018 04:49 PM, Dave Hansen wrote:
>>> That seems like something we need to call out if so.  It also means we
>>> need to update the SDM because some of the text is wrong.
>> It needs to mention the WRUSS case.
> Ugh.  The documentation for this is not pretty.  But, I guess this is
> not fundamentally different from access to U=1 pages when SMAP is in
> place and we've set EFLAGS.AC=1.

I was wrong and misread the docs.  We do not get X86_PF_USER set when
EFLAGS.AC=1.

But, we *do* get X86_PF_USER (otherwise defined to be set when in ring3)
when running in ring0 with the WRUSS instruction and some other various
shadow-stack-access-related things.  I'm sure folks had a good reason
for this architecture, but it is a pretty fundamentally *new*
architecture that we have to account for.

This new architecture is also not spelled out or accounted for in the
SDM as of yet.  It's only called out here as far as I know:
https://software.intel.com/sites/default/files/managed/4d/2a/control-flow-enforcement-technology-preview.pdf

Which reminds me:  Yu-cheng, do you have a link to the docs anywhere in
your set?  If not, you really should.
