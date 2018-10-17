Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJRHPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2018 03:15:12 -0400
Subject: Re: [PATCH v5 03/27] x86/fpu/xstate: Introduce XSAVES system states
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-4-yu-cheng.yu@intel.com>
 <20181017104137.GE22535@zn.tnic>
 <32da559b-7958-60db-e328-f0eb316e668e@infradead.org>
 <20181017225829.GA32023@zn.tnic>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fde4c237-6210-f4e4-5362-c2e24a9916a2@infradead.org>
Date: Wed, 17 Oct 2018 16:17:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181017225829.GA32023@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181017231701.MtqmKrvjxUBteLCLyX4p0RweBSf0etcJqchXUx38XBg@z>

On 10/17/18 3:58 PM, Borislav Petkov wrote:
> On Wed, Oct 17, 2018 at 03:39:47PM -0700, Randy Dunlap wrote:
>> Would you mind explaining this request? (requirement?)
>> Other than to say that it is the preference of some maintainers,
>> please say Why it is preferred.
>>
>> and since the <type>s above won't typically be the same length,
>> it's not for variable name alignment, right?
> 
> Searching the net a little, it shows you have asked that question
> before. So what is it you really wanna know?

OK, you have shown that your web search skills are better than mine.

I asked what I really wanted to know.

ta.
-- 
~Randy
