From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC, PATCHv1 22/28] x86/espfix: support 5-level paging
Date: Thu, 8 Dec 2016 10:40:41 -0800
Message-ID: <CALCETrXXNfL1OyZBa4tHm0cGz3trHV_FiJv=gtk2QRm-HrRXRg@mail.gmail.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com> <20161208162150.148763-24-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161208162150.148763-24-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> XXX: how to test this?

tools/testing/selftests/x86/sigreturn_{32,64}

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
