Return-Path: <SRS0=BIEI=4P=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgB0BQ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 20:16:29 -0500
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
 <CAMe9rOouOwNC873v=LOv5rJWcbe9Zvg+od8229J33V=ZfrB1rg@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <71791bbf-7ee3-fa70-b569-ae643151646e@intel.com>
Date: Wed, 26 Feb 2020 17:16:27 -0800
MIME-Version: 1.0
In-Reply-To: <CAMe9rOouOwNC873v=LOv5rJWcbe9Zvg+od8229J33V=ZfrB1rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200227011627.6bGihzkfbNVRkb9ytJF8Ey5FlGvueoQ0VN_9pI_kM7o@z>

On 2/26/20 5:02 PM, H.J. Lu wrote:
>> That way everybody with old toolchains can still build the kernel (and
>> run/test code with your config option on, btw...).
> CET requires a complete new OS image from kernel, toolchain, run-time.
> CET enabled kernel without the rest of updated OS won't give you CET
> at all.

If you require a new toolchain, nobody even builds your fancy feature.
Probably including 0day and all of the lazy maintainers with crufty old
distros.

The point isn't to actually run CET at all.  The point is to get as many
people as possible testing as much of it as possible.  Testing includes
compile testing, static analysis and bloat watching.  It also includes
functional and performance testing when you've got the feature compiled
in but unavailable at runtime.  Did this hurt anything even when I'm not
using it?
