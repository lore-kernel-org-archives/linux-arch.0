Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:39304 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeJBXPJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Oct 2018 19:15:09 -0400
Subject: Re: [RFC PATCH v4 02/27] x86/fpu/xstate: Change some names to
 separate XSAVES system and user states
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-3-yu-cheng.yu@intel.com>
 <20181002152903.GB29601@zn.tnic>
 <ba13d643c21de8e1e01a8d528457fb5dd82c42aa.camel@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <498c8824-9255-96be-71c2-3ebfa684a9d3@linux.intel.com>
Date: Tue, 2 Oct 2018 09:30:52 -0700
MIME-Version: 1.0
In-Reply-To: <ba13d643c21de8e1e01a8d528457fb5dd82c42aa.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181002163052.YqOSUOo9uaPIHIyARsKnAMLP31DCY0mrWz8iX8tgWCE@z>

On 10/02/2018 09:21 AM, Yu-cheng Yu wrote:
> On Tue, 2018-10-02 at 17:29 +0200, Borislav Petkov wrote:
>> On Fri, Sep 21, 2018 at 08:03:26AM -0700, Yu-cheng Yu wrote:
>>> To support XSAVES system states, change some names to distinguish
>>> user and system states.
>> I don't understand what the logic here is. SDM says:
>>
>> XSAVES—Save Processor Extended States Supervisor
>>
>> the stress being on "Supervisor" - why does it need to be renamed to
>> "system" now?
>>
> Good point.  However, "system" is more indicative; CET states are per-task and
> not "Supervisor".  Do we want to go back to "Supervisor" or add comments?

This is one of those things where the SDM language does not match what
we use in the kernel.  I think it's fine to call them "system" or
"kernel" states to make it consistent with our existing in-kernel
nomenclature.

I say add comments to clarify what the SDM calls it vs. what we do.
