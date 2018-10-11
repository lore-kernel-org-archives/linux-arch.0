Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55988 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeJLESI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Oct 2018 00:18:08 -0400
Subject: Re: [PATCH v5 07/27] mm/mmap: Create a guard area between VMAs
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-8-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <20167c74-9b98-6fa1-972e-bcd2c9c4a1c8@linux.intel.com>
Date: Thu, 11 Oct 2018 13:49:09 -0700
MIME-Version: 1.0
In-Reply-To: <20181011151523.27101-8-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181011204909.9toOna-Qtv4jlto-A3dbbHjbC7wlsa0ztnH6jb4RVF0@z>

On 10/11/2018 08:15 AM, Yu-cheng Yu wrote:
> Create a guard area between VMAs to detect memory corruption.

This is a pretty major change that has a bunch of end-user implications.
 It's not dependent on any debugging options and can't be turned on/off
by individual apps, at runtime, or even at boot.

Its connection to this series is also tenuous and not spelled out in the
exceptionally terse changelog.
