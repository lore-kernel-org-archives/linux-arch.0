Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbeGKKAq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jul 2018 06:00:46 -0400
Subject: Re: [RFC PATCH v2 05/27] Documentation/x86: Add CET description
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-6-yu-cheng.yu@intel.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <ae3e2013-9c90-af39-f9da-278bf7af6f73@redhat.com>
Date: Wed, 11 Jul 2018 11:57:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180710222639.8241-6-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180711095706.-eoTs8rHPeoEPUP--sUAwO0uMpIYW9DZ0SKLQTyUifM@z>

On 07/11/2018 12:26 AM, Yu-cheng Yu wrote:

> +To build a CET-enabled kernel, Binutils v2.30 and GCC v8.1 or later
> +are required.  To build a CET-enabled application, GLIBC v2.29 or
> +later is also requried.

Have you given up on getting the required changes into glibc 2.28?

Thanks,
Florian
