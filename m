Return-Path: <SRS0=hh2G=62=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
From: Luis Machado <luis.machado@linaro.org>
Message-ID: <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
Date: Tue, 12 May 2020 16:05:15 -0300
MIME-Version: 1.0
In-Reply-To: <20200421142603.3894-20-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200512190515.7bZCFUjXbKiV3yTiihCUoqHaSoYbbU9rH2zjWDNlLpQ@z>

Hi Catalin,

On 4/21/20 11:25 AM, Catalin Marinas wrote:
> Add support for bulk setting/getting of the MTE tags in a tracee's
> address space at 'addr' in the ptrace() syscall prototype. 'data' points
> to a struct iovec in the tracer's address space with iov_base
> representing the address of a tracer's buffer of length iov_len. The
> tags to be copied to/from the tracer's buffer are stored as one tag per
> byte.
> 
> On successfully copying at least one tag, ptrace() returns 0 and updates
> the tracer's iov_len with the number of tags copied. In case of error,
> either -EIO or -EFAULT is returned, trying to follow the ptrace() man
> page.
> 
> Note that the tag copying functions are not performance critical,
> therefore they lack optimisations found in typical memory copy routines.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alan Hayward <Alan.Hayward@arm.com>
> Cc: Luis Machado <luis.machado@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
> 
> Notes:
>      New in v3.
> 
>   arch/arm64/include/asm/mte.h         |  17 ++++
>   arch/arm64/include/uapi/asm/ptrace.h |   3 +
>   arch/arm64/kernel/mte.c              | 127 +++++++++++++++++++++++++++
>   arch/arm64/kernel/ptrace.c           |  15 +++-
>   arch/arm64/lib/mte.S                 |  50 +++++++++++
>   5 files changed, 211 insertions(+), 1 deletion(-)
>
I started working on MTE support for GDB and I'm wondering if we've 
already defined a way to check for runtime MTE support (as opposed to a 
HWCAP2-based check) in a traced process.

Originally we were going to do it via empty-parameter ptrace calls, but 
you had mentioned something about a proc-based method, if I'm not mistaken.

Regards,
Luis
