From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
Date: Tue, 13 Nov 2018 10:24:22 +0000
Message-ID: <61f77f06-396e-9293-c8cc-28fe7ea32af5@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
 <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
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


On 10/11/2018 16:18, Arnd Bergmann wrote:
> On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
>>
>> This patch tries to unify the gettimeofday vdso implementation
>> introducing lib/vdso. The code contained in this library can
>> ideally be reused by all the architectures avoiding, where
>> possible, code duplication.
>>
>> In doing so, tries to maintain the performances using inlining as much
>> as possible and consequently reduces the surface for ROP type of attacks.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> I just noticed that this new version misses some of the cleanups
> that Thomas recently did in the x86 version, e.g. f3e839384164
> ("x86/vdso: Replace the clockid switch case").
> 
> I haven't looked at all the details, but I'd suggest using the latest
> x86 code as a base.
> 

Ok, I will have a look at Thomas' work. Thanks for pointing this out. 

>         Arnd
> 

-- 
Regards,
Vincenzo
