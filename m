From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: Unify the various copies of libgcc into lib
Date: Fri, 02 Jun 2017 19:59:15 -0700 (PDT)
Message-ID: <mhng-d2e4c1c0-792e-4de2-ae3f-7cceb4c7508a@palmer-si-x1c4>
References: <CAMuHMdUP2RbjV+09UGkzjJcRrsoyy9F6XT8fbCPEd0mQCDFvFw@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CAMuHMdUP2RbjV+09UGkzjJcRrsoyy9F6XT8fbCPEd0mQCDFvFw@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: geert@linux-m68k.org
Cc: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 24 May 2017 02:21:22 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Palmer,
>
> On Wed, May 24, 2017 at 12:05 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> I'm in the process of submitting the RISC-V Linux port, and someone noticed
>> that we were adding copies of some libgcc emulation routines that were the same
>> as some of the other ports.  This prompted me to go through and check all the
>> ports for libgcc.h and to merge the versions that were functionally identical.
>>
>> The only difference in libgcc.h was that there was a #define for little vs big
>> endian.  The differences in the emulation routines were all just whitespace.
>>
>> This patch set comes in two parts:
>>
>>  * Patch 1 adds new copies of all the C files copied from libgcc, as well as
>>    moving libgcc.h to include/lib (that's a new folder, which probably means
>>    it's the wrong place to put it, but I couldn't find anything better).  There
>>    are Kconfig entries for each of these library functions so architectures can
>>    select them one at a time.
>
> I would call the Kconfig symbols GENERIC_* instead of LIB_*, for consistency
> with other generic implementations.

OK.  I'll include that in my v2 patch set.

>>  * The rest of the patches convert each architecture over to the new system.
>
> Thanks! For all but "[PATCH 4/7] mips: ...":
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

>> Unless I screwed something up, this patch set shouldn't actually change any
>> functionality.  Unfortunately I don't actually have all these cross compilers
>> setup so I can't actually test any of this, but I did convert the RISC-V port
>> over to using this system and it appears to be OK there so at least this isn't
>> completely broken.
>
> https://www.kernel.org/pub/tools/crosstool/

Cool.  I'll build everything before I submit a v2.
