Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54926 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbeJSCgf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2018 22:36:35 -0400
Subject: Re: [PATCH v5 03/27] x86/fpu/xstate: Introduce XSAVES system states
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-4-yu-cheng.yu@intel.com>
 <20181017104137.GE22535@zn.tnic>
 <32da559b-7958-60db-e328-f0eb316e668e@infradead.org>
 <20181017225829.GA32023@zn.tnic>
 <fde4c237-6210-f4e4-5362-c2e24a9916a2@infradead.org>
 <20181018092603.GB20831@zn.tnic>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <17222925-1c4c-0acd-c92c-637228326b66@infradead.org>
Date: Thu, 18 Oct 2018 11:33:44 -0700
MIME-Version: 1.0
In-Reply-To: <20181018092603.GB20831@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181018183344.5WvXnK2SOkD52T4B3cpoT0xXBOv9zlXYj00KY6-qZWQ@z>

On 10/18/18 2:26 AM, Borislav Petkov wrote:
> On Wed, Oct 17, 2018 at 04:17:01PM -0700, Randy Dunlap wrote:
>> I asked what I really wanted to know.
> 
> Then the answer is a bit better readability, I'd guess.
> 

Thanks for the reply.

-- 
~Randy
