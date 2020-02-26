Return-Path: <SRS0=ZbOS=4O=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH v9 08/27] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-9-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ff814814-b17f-f610-ab32-3d85348b184f@intel.com>
Date: Wed, 26 Feb 2020 10:20:25 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-9-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226182025.DUyPP8yQX2LrXTc5T_rlCxpGV0oRWYLpHeHX0B1WZxw@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> Before introducing _PAGE_DIRTY_SW for non-hardware memory management
> purposes in the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and
> _PAGE_BIT_DIRTY to _PAGE_BIT_DIRTY_HW to make these PTE dirty bits
> more clear.  There are no functional changes from this patch.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
