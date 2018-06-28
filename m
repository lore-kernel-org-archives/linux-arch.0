From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Date: Thu, 28 Jun 2018 21:30:16 +0200
Message-ID: <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com> <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 27, 2018 at 5:05 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Tue, Jun 26, 2018 at 7:29 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> While I support this work, as a maintainer I'd like to understand
>> whether we'd be in a continuous chase of ABI breaks with every kernel
>> release or we have a better way to identify potential issues. Is there
>> any way to statically analyse conversions from __user ptr to long for
>> example? Or, could we get the compiler to do this for us?
>
>
> OK, got it, I'll try to figure out a way to find these conversions.

I've prototyped a checker on top of clang static analyzer (initially
looked at sparse, but couldn't find any documentation or examples).
The results are here [1], search for "warning: user pointer cast".
Sharing in case anybody wants to take a look, will look at them myself
tomorrow.

[1] https://gist.github.com/xairy/433edd5c86456a64026247cb2fef2115
