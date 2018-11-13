From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Tue, 13 Nov 2018 10:58:31 +0000
Message-ID: <8e306faf-6261-8363-3f18-70e754fa3a9d@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, salyzyn@android.com, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, pcc@google.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 09/11/2018 16:13, Arnd Bergmann wrote:
>> +
>> +extern struct vdso_data _vdso_data;
>> +
>> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
>> +                                                        struct timezone *_tz)
> 
> I'm trying to get rid of the last users of 'struct timeval' in the kernel so
> we can remove the definition (it will clash with future glibc implementations
> in the uapi headers). Could you change this to use __kernel_old_timeval
> instead?
>

Ok, will update all the data types in v2.

... 

>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>> index beca249bc2f3..9de0ffc369c5 100644
>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>> @@ -88,6 +88,7 @@ VERSION
>>                 __kernel_gettimeofday;
>>                 __kernel_clock_gettime;
>>                 __kernel_clock_getres;
>> +               __kernel_time;
>>         local: *;
>>         };
>>  }
> 
> I would  prefer to not add any deprecated interfaces in the VDSO. If we
> have the 64-bit version of clock_gettime, we don't need the 32-bit version
> of it, and we don't need gettimeofday() or time() either. The C library
> can easily implement those by calling into clock_gettime.
> 

I like the idea, this would make the vdso lib code more simple and more maintainable.

In this patchset I tried to cover the widest possible scenario making things configurable: each architecture can select and enable exactly what it needs from the vdso common code. 

Based on what you are proposing, once the C library will implement things in this way, it will be easy to deprecate and remove the unused code.

I am not familiar with the development plans of the various C libraries, but looking at bionic libc currently seems using all the vdso exposed functions [1].

[1] https://github.com/aosp-mirror/platform_bionic/blob/master/libc/bionic/vdso.cpp

...

> 
>         Arnd
> 

-- 
Regards,
Vincenzo
