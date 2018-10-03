From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
Date: Wed, 3 Oct 2018 15:31:12 +0200
Message-ID: <20181003133110.4y3xhexjrvffivff@ltop.local>
References: <cover.1538485901.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 02, 2018 at 03:12:35PM +0200, Andrey Konovalov wrote:
...

> Changes in v7:
> - Rebased onto 17b57b18 (4.19-rc6).
> - Dropped the "arm64: untag user address in __do_user_fault" patch, since
>   the existing patches already handle user faults properly.
> - Dropped the "usb, arm64: untag user addresses in devio" patch, since the
>   passed pointer must come from a vma and therefore be untagged.
> - Dropped the "arm64: annotate user pointers casts detected by sparse"
>   patch (see the discussion to the replies of the v6 of this patchset).
> - Added more context to the cover letter.
> - Updated Documentation/arm64/tagged-pointers.txt.

Hi,

I'm quite hapy now with what concerns me (sparse).
Please, feel free to add my:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Cheers,
-- Luc Van Oostenryck
