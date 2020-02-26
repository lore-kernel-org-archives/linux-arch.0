Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36691 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZSH5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:07:57 -0500
Subject: Re: [RFC PATCH v9 06/27] mm: Introduce VM_SHSTK for Shadow Stack
 memory
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-7-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <021394ef-e552-0639-0294-472e32e0d3fc@intel.com>
Date: Wed, 26 Feb 2020 10:07:54 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-7-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200226180754.7F5zQOP29WHHu9YR6Ois_NpQeOjVe_A4z_DLIqBCIkg@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> A Shadow Stack (SHSTK) PTE must be read-only and have _PAGE_DIRTY set.
> However, read-only and Dirty PTEs also exist for copy-on-write (COW) pages.
> These two cases are handled differently for page faults and a new VM flag
> is necessary for tracking SHSTK VMAs.
> 
> v9:
> - Add VM_SHSTK case to arch_vma_name().
> - Revise the commit log to explain why a new VM flag is needed.

To be honest, a flag is not strictly *needed*.  It is certainly
convenient and straightforward, but it's far from being truly necessary.
