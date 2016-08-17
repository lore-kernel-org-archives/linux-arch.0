From: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>
Subject: Re: [RFC2 nowrap: PATCH v7 00/18] ILP32 for ARM64
Date: Wed, 17 Aug 2016 14:54:59 +0200
Message-ID: <DF24AFA0-5B5C-47E8-9B78-7C6C8711948E@theobroma-systems.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com> <175AE090-EDA7-4A8D-9044-3FFA74AC1903@suse.de> <20160817124822.GA25751@yury-N73SV>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <libc-alpha-return-72583-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <20160817124822.GA25751@yury-N73SV>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Alexander Graf <agraf@suse.de>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@theobroma-systems.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, szabolcs.nagy@arm.com, Alexey Klimov <klimov.linux@gmail.com>, Nathan Lynch <Nathan_Lynch@mentor.com>, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, geert@linux-m68k.org, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@dav
List-Id: linux-arch.vger.kernel.org


> On 17 Aug 2016, at 14:48, Yury Norov <ynorov@caviumnetworks.com> =
wrote:
>=20
> On Wed, Aug 17, 2016 at 02:28:50PM +0200, Alexander Graf wrote:
>>=20
>>> On 17 Aug 2016, at 13:46, Yury Norov <ynorov@caviumnetworks.com> =
wrote:
>>>=20
>>> This series enables aarch64 with ilp32 mode, and as supporting work,
>>> introduces ARCH_32BIT_OFF_T configuration option that is enabled for
>>> existing 32-bit architectures but disabled for new arches (so 64-bit
>>> off_t is is used by new userspace).
>>>=20
>>> This version is based on kernel v4.8-rc2.
>>> It works with glibc-2.23, and tested with LTP.
>>>=20
>>> This is RFC because there is still no solid understanding what type =
of registers
>>> top-halves delousing we prefer. In this patchset, w0-w7 are cleared =
for each
>>> syscall in assembler entry. The alternative approach is in =
introducing compat
>>> wrappers which is little faster for natively routed syscalls (~2.6% =
for syscall
>>> with no payload) but much more complicated.
>>=20
>> So you=E2=80=99re saying there are 2 options:
>>=20
>>  1) easy to get right, slightly slower, same ABI to user space as 2
>>  2) harder to get right, minor performance benefit
>=20
> No, ABI is little different. If 1) we pass off_t in a pair to =
syscalls,
> if 2) - in a single register. So if 1, we 'd take some wrappers from =
aarch32.
> See patch 12 here.

=46rom our experience with ILP32, I=E2=80=99d prefer to have off_t (and =
similar) in a single register
whenever possible (i.e. option #2).  It feels more natural to use the =
full 64bit registers=20
whenever possible, as ILP32 on ARMv8 should really be understood as a =
64bit ABI with=20
a 32bit memory model.

Cheers,
Philipp.=
