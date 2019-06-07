Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64825 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfFGQjp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 12:39:45 -0400
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net>
 <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <00421c4e-c64b-57cf-882e-aa7b9a007661@intel.com>
Date: Fri, 7 Jun 2019 09:39:41 -0700
MIME-Version: 1.0
In-Reply-To: <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607163941.3efCd0g3FX4f2Ld6KHzgDiiJYrY5gIkmqRhIwAU1ra4@z>

On 6/7/19 9:35 AM, Andy Lutomirski wrote:
> One might reasonably wonder why this state is privileged in the first
> place and, given that, why we’re allowing it to be written like
> this.

I think it's generally a good architectural practice to make things like
this privileged.  They're infrequent so can survive the cost of a trip
in/out of the kernel and are a great choke point to make sure the OS is
involved.  I wish we had the same for MPX or pkeys per-task "setup".
