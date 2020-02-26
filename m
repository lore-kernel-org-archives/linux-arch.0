From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 06/27] mm: Introduce VM_SHSTK for Shadow Stack
 memory
Date: Wed, 26 Feb 2020 10:07:54 -0800
Message-ID: <021394ef-e552-0639-0294-472e32e0d3fc@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-7-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205181935.3712-7-yu-cheng.yu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

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
