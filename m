Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeKUHM6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Nov 2018 02:12:58 -0500
Message-ID: <16a0261fbe4b31e2f42b552d6a991a1116d398c2.camel@intel.com>
Subject: Re: [RFC PATCH v6 01/26] Documentation/x86: Add CET description
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 20 Nov 2018 12:36:38 -0800
In-Reply-To: <20181120095253.GA119911@gmail.com>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
         <20181119214809.6086-2-yu-cheng.yu@intel.com>
         <20181120095253.GA119911@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181120203638.8Bq2J5BGkUF0ZlZkJSz6lhnR4tsmcXGfiLqKzuHj8Do@z>

On Tue, 2018-11-20 at 10:52 +0100, Ingo Molnar wrote:
> * Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> > +X86 Documentation
> > [...]
> > +
> > +At run time, /proc/cpuinfo shows the availability of SHSTK and IBT.
> 
> What is the rough expected performance impact of CET on average function 
> call frequency user applications and the kernel itself?

I don't have any conclusive numbers yet; but since currently only user-mode
protection is implemented, I suspect any impact would be most likely to the
application.  The kernel would spend some small amount of time on the setup of
CET.

Yu-cheng
