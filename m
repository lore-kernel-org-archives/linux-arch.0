Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25258 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbeJBXcG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Oct 2018 19:32:06 -0400
Message-ID: <23e8d0a3b0e5649a74ec1fd8ef9975856fdc7eab.camel@intel.com>
Subject: Re: [RFC PATCH v4 02/27] x86/fpu/xstate: Change some names to
 separate XSAVES system and user states
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 02 Oct 2018 09:43:05 -0700
In-Reply-To: <6859a180-8973-e794-7ac4-1ac8f0e1c709@linux.intel.com>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <20180921150351.20898-3-yu-cheng.yu@intel.com>
         <20181002152903.GB29601@zn.tnic>
         <ba13d643c21de8e1e01a8d528457fb5dd82c42aa.camel@intel.com>
         <498c8824-9255-96be-71c2-3ebfa684a9d3@linux.intel.com>
         <20181002163736.GD29601@zn.tnic>
         <6859a180-8973-e794-7ac4-1ac8f0e1c709@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181002164305.bEuxoVkYbCBadC8wZCV6rIYNZhw91-8fWLIGCUsCUVo@z>

On Tue, 2018-10-02 at 09:39 -0700, Dave Hansen wrote:
> On 10/02/2018 09:37 AM, Borislav Petkov wrote:
> > This patch's commit message is not even close. So I'd very much
> > appreciate a more verbose explanation, even if it repeats itself at
> > places.
> 
> Yep, totally agree.

Ok, I will work on that.

Yu-cheng
