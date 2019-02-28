From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 00/23] Unify vDSOs across more architectures
Date: Thu, 28 Feb 2019 15:51:45 +0000
Message-ID: <0b7d7219-cc7f-9ef1-7945-b609b2f36597@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <CAK8P3a1Q1uMFLs6eq26Rkv8hQdu0FkPUoq0gDnZPju-Eu1oHgQ@mail.gmail.com>
 <b02ee1da-e756-f7c7-ad8d-944b9b9e56e0@arm.com>
 <CAK8P3a3__F6jRn6JC2hLWG5yvgV38rBRtjwZKN4cV=yAusuo8Q@mail.gmail.com>
 <d4ffe6da-cd47-31eb-f219-3ee064e411ca@arm.com>
 <CAK8P3a0FtUC2Akr7HdqrkMPv-FHEbX+WNik=WH70aEtC66f0uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0FtUC2Akr7HdqrkMPv-FHEbX+WNik=WH70aEtC66f0uw@mail.gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On 28/02/2019 13:54, Arnd Bergmann wrote:
> On Thu, Feb 28, 2019 at 1:42 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> On 28/02/2019 12:38, Arnd Bergmann wrote:
>>> On Thu, Feb 28, 2019 at 1:09 PM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>>
>>>> thank you for testing my code.
>>>>
>>>> On 28/02/2019 11:40, Arnd Bergmann wrote:
>>>>> On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
>>>>> <vincenzo.frascino@arm.com> wrote:
>>>>>   ^
>>>>>
>>>>> I think this is all harmless, but we need to limit the set of header files
>>>>> that can be included indirectly when compiling the vdso in arm32 mode.
>>>>>
>>>>
>>>> I agree with you on the principle, but I am unable to replicate the warnings.
>>>> Did you make any customization to the default defconfig? What is the top
>>>> commit-id you have on your tree?
>>>
>>> I observed this on top of v5.0-rc7 earlier, and have since rebased to
>>> today's linux-next, where it still happens with the regular 'make defconfig',
>>> on all compiler versions I have (4.8 through 8.1).
>>>
>>
>> Thanks, I will try to rebase my patches on linux-next and see if I can reproduce it.
> 
> I just found a related issue: when CONFIG_CPU_BIG_ENDIAN is
> set, everything breaks in the compat vdso because of the included
> arm64 headers in arm32 code. That should be easier to reproduce.
> For the moment, I'm using this patch:
> 
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -103,7 +103,7 @@ config ARM64
>         select GENERIC_STRNLEN_USER
>         select GENERIC_TIME_VSYSCALL
>         select GENERIC_GETTIMEOFDAY
> -       select GENERIC_COMPAT_VDSO
> +       select GENERIC_COMPAT_VDSO if !CPU_BIG_ENDIAN
>         select HANDLE_DOMAIN_IRQ
>         select HARDIRQS_SW_RESEND
>         select HAVE_PCI
> 
> 

Thanks for this, but I can't still reproduce the issue.

I rebased my patches on:
commit 42fd8df9d1d9c83046226e771a4f5f3d05a706ff (tag: next-20190228,
linux-next/master)

and enabled CONFIG_CPU_BIG_ENDIAN.

>          Arnd
> 

-- 
Regards,
Vincenzo
