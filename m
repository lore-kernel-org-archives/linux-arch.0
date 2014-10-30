From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Thu, 30 Oct 2014 18:44:37 +0800
Message-ID: <CAFiDJ59LZSwKBzVuuzfH_5772-BR74EH=d=FeBbWvEXjfpisug@mail.gmail.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
	<1414139071-3818-30-git-send-email-lftan@altera.com>
	<2095416.INZmt8AD1y@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <2095416.INZmt8AD1y@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 28, 2014 at 9:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 October 2014 16:24:31 Ley Foon Tan wrote:
>> +DECLARE_EXPORT(__gcc_bcmp);
>> +DECLARE_EXPORT(__divdi3);
>> +DECLARE_EXPORT(__divsi3);
>> +DECLARE_EXPORT(__moddi3);
>> +DECLARE_EXPORT(__modsi3);
>> +DECLARE_EXPORT(__udivdi3);
>> +DECLARE_EXPORT(__udivmoddi4);
>> +DECLARE_EXPORT(__udivsi3);
>> +DECLARE_EXPORT(__umoddi3);
>> +DECLARE_EXPORT(__umodsi3);
>> +DECLARE_EXPORT(__muldi3);
>>
>
> I don't remember what all of these are, but at least some of them seem
> to be concerned with 64-bit division. By convention, we don't provide those
> in the Linux kernel but instead require all code to use the do_div()
> macro instead.
Do you mean kernel doesn't support 64 bit division result for a 32-bit
architecture? Because do_div() only support 32-bit division result for
32-bit architecture.
Compiler will auto generate call to __divdi3() for the following
example code. This means loadable module will have compilation error
if we don't export symbol for __divdi3, but built-in module is fine.
Is this an expectation? Or we can keep 64-bit division symbols here
since they are no harm (they are software emulation when without
hardware divider).

long long a, b, c;
a = b / c;

Regards
Ley Foon
