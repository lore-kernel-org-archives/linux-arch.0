From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 08/27] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
Date: Wed, 26 Feb 2020 10:20:25 -0800
Message-ID: <ff814814-b17f-f610-ab32-3d85348b184f@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-9-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200205181935.3712-9-yu-cheng.yu@intel.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> Before introducing _PAGE_DIRTY_SW for non-hardware memory management
> purposes in the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and
> _PAGE_BIT_DIRTY to _PAGE_BIT_DIRTY_HW to make these PTE dirty bits
> more clear.  There are no functional changes from this patch.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
