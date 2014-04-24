From: Chung-Lin Tang <cltang@codesourcery.com>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Thu, 24 Apr 2014 16:55:25 +0800
Message-ID: <5358D17D.1040609@codesourcery.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>	<5354AD36.5090809@zytor.com>	<CAFiDJ5861HE4AXtio-8uNJppWE2oaPt9_OKyGV=Myb_3vPrOVA@mail.gmail.com>	<16597012.pEkDc99HDN@wuerfel> <CAFiDJ5_dUpVTSeC36AfNKVN7BOa9GQ5vwSEWricm=8Sam9mR2A@mail.gmail.com>,<5357FF8E.9010809@codesourcery.com> <E780DB23-B6A3-427B-8F33-71378088A3F5@caviumnetworks.com> <5358AE96.9010006@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5358AE96.9010006@codesourcery.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Cc: Ley Foon Tan <lftan@altera.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Catalin.Marinas@arm.com" <Catalin.Marinas@arm.com>, Andrew Pinski <apinski@cavium.com>, "Tang, Chung-Lin" <ChungLin_Tang@mentor.com>
List-Id: linux-arch.vger.kernel.org

On 2014/4/24 02:26 PM, Chung-Lin Tang wrote:
> On 2014/4/24 =E4=B8=8A=E5=8D=88 02:15, Pinski, Andrew wrote:
>>
>>>> On Apr 23, 2014, at 10:59 AM, "Chung-Lin Tang" <cltang@codesourcer=
y.com> wrote:
>>>>
>>>>>> On 2014/4/22 07:20 PM, Ley Foon Tan wrote:
>>>>>> On Tue, Apr 22, 2014 at 6:56 PM, Arnd Bergmann <arnd@arndb.de> w=
rote:
>>>>>>>>>> On Tuesday 22 April 2014 18:37:11 Ley Foon Tan wrote:
>>>>>>>>>>>>>> Hi Arnd and Peter Anvin,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Other than 64-bit time_t, clock_t and suseconds_t, can y=
ou confirm
>>>>>>>>>>>>>> that we don't need to have 64 bit off_t? See detail in l=
ink below.
>>>>>>>>>>>>>> I can submit the patches for 64-bit time changes
>>>>>>>>>>>>>> (include/asm-generic/posix_types.h and other archs) if e=
veryone is
>>>>>>>>>>>>>> agreed on this.
>>>>>>>>>>
>>>>>>>>>> Yes.
>>>>>> Okay, will doing that.
>>>>
>>>> I believe that arm64 ILP32 will also be affected. What is the stat=
us of
>>>> this configuration? Has the glibc/kernel ABI been finalized?
>> Not yet.  I am still working out the signal handling part. But we al=
ready agreed on 64bit time_t, clock_t, and suseconds_t.  And we agreed =
to a 64bit offset_t too.=20
>>
>> On a related note suseconds in the timespec in posix is defined to b=
e long. So it would nice if the kernel ignores the upper 32bits so we (=
glibc developers) can fix this for new targets including x32 and arm64/=
ilp32.=20
>=20
> Hmm, but that means for purely 32-bit architectures like nios2, which
> unlike x86_64 or arm64, never has a 64-bit mode, suseconds_t as a 64-=
bit
> type in the kernel is simply wasted.
>=20
> Chung-Lin

The more I think of this, the more I feel that suseconds_t should jsut
be 'long', not strictly 64-bitified. An ILP32 sub-mode in a 64-bit
kernel should be using compat_* code paths, something like a
COMPAT_USE_32BIT_SUSECONDS case.

suseconds_t is for micro-seconds in struct timeval, 32-bit is more than
enough.

Chung-Lin

