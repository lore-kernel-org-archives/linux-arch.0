From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Fri, 9 Nov 2018 09:23:37 -0800
Message-ID: <ef94c2cb-4573-211d-f69e-57bf90a80e6a@android.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, pcc@google.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 11/09/2018 08:13 AM, Arnd Bergmann wrote:
>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>> index beca249bc2f3..9de0ffc369c5 100644
>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>> @@ -88,6 +88,7 @@ VERSION
>>                  __kernel_gettimeofday;
>>                  __kernel_clock_gettime;
>>                  __kernel_clock_getres;
>> +               __kernel_time;
>>          local: *;
>>          };
>>   }
> I would  prefer to not add any deprecated interfaces in the VDSO. If we
> have the 64-bit version of clock_gettime, we don't need the 32-bit version
> of it, and we don't need gettimeofday() or time() either. The C library
> can easily implement those by calling into clock_gettime.
Alas time() calls are simple and in the order of get_res, the cost of 
which is a five fold
improvement over the alternate higher resolution calls (clock_gettime or 
up to 100 fold
on some architectures over gettimeofday). We could measure a small 
improvement in
cpu utilization (and thus battery life by extension) attributed to arm64 
Android by
calling __kernel_time over __kernel_clock_gettime with coarse 
resolution. A game of
inches admittedly, but super KISS to add, and it is not as-if 
__kernel_time existence
will cause an issue with deprecation of a system call entry point.

-- Mark
