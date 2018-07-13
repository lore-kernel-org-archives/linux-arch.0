Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16945 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbeGME3c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Jul 2018 00:29:32 -0400
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-19-yu-cheng.yu@intel.com>
 <bbb487cc-ac1c-f734-eee3-2463a0ba7efc@linux.intel.com>
 <1531436398.2965.18.camel@intel.com>
 <46784af0-6fbb-522d-6acb-c6248e5e0e0d@linux.intel.com>
 <167645aa-f1c7-bd6a-c7e0-2da317cbbaba@intel.com>
 <55A0592D-0E8D-4BC5-BA4B-E82E92EEA36A@amacapital.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <66016722-9872-a3f9-f88b-37397f9b6979@intel.com>
Date: Thu, 12 Jul 2018 21:16:46 -0700
MIME-Version: 1.0
In-Reply-To: <55A0592D-0E8D-4BC5-BA4B-E82E92EEA36A@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180713041646.o4YKTPzD-wgfa_qdQEvmfZEQ6jKRyhuRp4rLkCSs-NI@z>

On 07/12/2018 07:21 PM, Andy Lutomirski wrote:
> I am tempted to suggest that the whole series not be merged until
> there are actual docs. It’s not a fantastic precedent.

Do you mean Documentation or manpages, or are you talking about hardware
documentation?
https://software.intel.com/sites/default/files/managed/4d/2a/control-flow-enforcement-technology-preview.pdf
