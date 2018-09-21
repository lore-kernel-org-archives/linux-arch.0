Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbeIVEpT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Sep 2018 00:45:19 -0400
Subject: Re: [RFC PATCH v4 00/27] Control Flow Enforcement: Shadow Stack
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <1ca5178d-60f3-ae70-ce95-7026ac0429b4@linux.intel.com>
Date: Fri, 21 Sep 2018 15:53:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180921150351.20898-1-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180921225308.1OUBoc5gaGLOlhMWNJkT9XxGUtvLkdgW1xaLD6-4w6Q@z>

On 09/21/2018 08:03 AM, Yu-cheng Yu wrote:
> The previous version of CET patches can be found in the following
> link:
> 
>   https://lkml.org/lkml/2018/8/30/608

So, this is an RFC, but there no mention of what you want comments *on*. :)

What do you want folks to review?  What needs to get settled before this
is merged?
