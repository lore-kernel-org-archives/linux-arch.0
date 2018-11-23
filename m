From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 00/27] Unify vDSOs across more architectures
Date: Fri, 23 Nov 2018 11:05:08 +0000
Message-ID: <5c52c92c-2bbc-1d8e-faea-2117ecebfd72@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <CAK8P3a1obPxkJROk5rN7OpL3AE-3Yifu-vUqepUUz+yO_HNd7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1obPxkJROk5rN7OpL3AE-3Yifu-vUqepUUz+yO_HNd7g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 11/10/18 4:33 PM, Arnd Bergmann wrote:
> On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>> vDSO (virtual dynamic shared object) is a mechanism that the Linux
>> kernel provides as an alternative to system calls to reduce where
>> possible the costs in terms of cycles.
>> This is possible because certain syscalls like gettimeofday() do
>> not write any data and return one or more values that are stored
>> in the kernel, which makes relatively safe calling them directly
>> as a library function.
>>
>> Even if the mechanism is pretty much standard, every architecture
>> in the last few years ended up implementing their own vDSO library
>> in the architectural code.
>>
>> The purpose of this patch-set is to identify the commonalities in
>> between the architectures and try to consolidate the common code
>> paths, starting with gettimeofday().
> 
> I'm very happy to see the generalization overall, as this is going
> to make it much easier to add the 64-bit time_t on the 32-bit
> vdso implementations, as well as other extensions we may want
> in the future.
> 

Thanks,

>> This implementation contains the following design choices:
>>  * Every architecture defines the arch specific code in an header in
>>    "asm/vdso/".
>>  * The generic implementation includes the arch specific one and lives
>>    in "lib/vdso".
> 
> Makes sense.
> 
>>  * The arch specific code for gettimeofday lives in
>>    "<arch path>/vdso/gettimeofday.c" and includes the generic code only.
>>  * This approach allows to consolidate the common code in a single place
>>    with the benefit of avoiding code duplication.
> 
> I would prefer to have that named clock_gettime.c and only implement
> that one system call there. We can easily have the gettimeofday(),
> time() and clock_getres() in the common code where that is needed
> for backwards compatibility. As I already mentioned in my comment
> for one of the patches, we won't have time() or gettimeofday() system
> calls on new architectures, and 32-bit architectures won't have them
> with 64-bit time_t.
> 

The reason why I used gettimeofday.c as a filename is because it is the naming
convention that I could see more often in the kernel and I feel that, if we have
even the implementations of gettimeofday(), time() and clock_getres() in the
same file is probably the most representative.

> I suppose we can have the time() and gettimeofday() calls
> implemented in the generic vdso for everyone, but then
> only hook those up on architectures that already had
> them. The implementation of course is trivial based on
> clock_gettime() with CLOCK_REALTIME or CLOCK_REALTIME_COARSE
> respectively.
> 

I agree, and in the long term would be my preferred approach as well, but I
would prefer to keep this "optimization" in a separate patchset for what I
mentioned in my previous email.

>> This implementation contains the portings to the common library for: arm64,
>> compat mode for arm64, arm and mips.
>>
>> The mips porting has been tested on qemu for mips32el. A configuration to
>> repeat the tests can be found at [4].
> 
> Ah, I missed the fact that you didn't do this for x86, so I assumed that
> this work was triggered by Thomas' recent cleanup of the x86 clock_gettime
> vdso code. I think it would be best to get x86 to use the same code and
> get the recent improvements ported to the others as well that way.
>

Yes, I agree it would be great to have have the other architectures to join the
effort because I believe that the whole ecosystem would benefit from it.

>       Arnd
> 

-- 
Regards,
Vincenzo
