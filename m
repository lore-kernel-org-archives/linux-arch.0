From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: Behavior of BUG() [Was: Re: [PATCH 2/5] of/fdt: add kernel
 command line option for dtb_compat string]
Date: Tue, 16 Nov 2010 23:29:57 -0500
Message-ID: <AANLkTinz27cfdNKEtyUo9f3nuw+XbZ2Osz0ThRiOQnnL@mail.gmail.com>
References: <AANLkTinop4_JT4JLtdmWkydPgDDU=TyZNbtiBbgeh1dj@mail.gmail.com>
	<AANLkTimQtXeCE1Gu4YuPBBZ_J3ieW6Z5JtvzF=hF7pWX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <AANLkTimQtXeCE1Gu4YuPBBZ_J3ieW6Z5JtvzF=hF7pWX@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Tue, Nov 16, 2010 at 11:13 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Tue, Nov 16, 2010 at 8:45 PM, Arnaud Lacombe <lacombar@gmail.com> =
wrote:
>> Hi,
>>
>> [CC: list reduced as starting a new thread, most on the context
>> removed as this concern a different issue.]
>>
>> On Tue, Nov 16, 2010 at 7:16 PM, Grant Likely <grant.likely@secretla=
b.ca> wrote:
>>> On Tue, Nov 16, 2010 at 3:41 PM, =A0<dirk.brandewie@gmail.com> wrot=
e:
>>>> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>>>> [...]
>>> The kernel needs to complain *loudly* if this occurs because it
>>> represents a bug. =A0I'm tempted to say use BUG, but that would hal=
t the
>>> kernel and prevent any possibility of kernel log output.
>>> [...]
>> does it ? if CONFIG_BUG is not enabled and the arch has no define fo=
r
>> it, the default does _nothing_:
>>
>> from `include/asm-generic/bug.h':
>>
>> #else /* !CONFIG_BUG */
>> #ifndef HAVE_ARCH_BUG
>> #define BUG() do {} while(0)
>> #endif
>>
>> #ifndef HAVE_ARCH_BUG_ON
>> #define BUG_ON(condition) do { if (condition) ; } while(0)
>> #endif
>> [...]
>>
>> gcc is triggering about ~30 warnings (like [0]) on code path using
>> BUG(). Most of these path assume BUG() will never return, which is n=
ot
>> true.
>
> As far as I know, BUG() is not supposed to return. =A0Period.
>
but the code I pointed out _do_ return.

> The patch
> below is part of the linux-tiny work, and should only ever be used on
> embedded systems where small size is more important than debugability=
=2E
>
AFAIK, this is not precised anywhere, but I may not have search enough.

Matt, any reason the generic code does not just spin (or OOPS) and
marked __noreturn in any case ?

 - Arnaud
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
