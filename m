From: =?windows-1252?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH v2] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
Date: Thu, 28 May 2015 20:43:30 +0200
Message-ID: <556761D2.9040908@dawncrow.de>
References: <555CB3D5.7000307@dawncrow.de> <20150527143648.GA4232@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150527143648.GA4232@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Nathan Lynch <nathan_lynch@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Am 27.05.2015 um 16:36 schrieb Will Deacon:
> Hi Andr=E9,
> =

> On Wed, May 20, 2015 at 05:18:29PM +0100, Andr=E9 Hentschel wrote:
>> From: Andr=E9 Hentschel <nerv@dawncrow.de>
>>
>> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable=
 TLS
>> register on ARM is preserved per thread.
>>
>> This patch does it analogous to the ARM patch, but for compat mode on AR=
M64.
>>
>> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>
>> ---
>> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa7=
4a031)
>>
>> v2: Trying to address suggestions by Will Deacon
>>
>> @Will Deacon: 	The macro you suggested is not helpful it seems, instead =
i introduced
>> 		static functions. They also could be macros i guess, but it seems
>> 		much cleaner to me to use functions as it only affects one file.
> =

> I wanted to understand in more detail why the macro didn't work out for
> you, so I trued hacking together my own version of the patch (see below).
> It seems to hold up to light testing, so it would be good to know where
> you ran into problems.
> =

>> Should the final version be send to rmk's patchtracker or will someone
>> else pick it up?
> =

> This is an arm64 patch, so either Catalin or me will pick it up directly
> when it's ready to be merged.
> =

> Will

Your patch works, you can add me as Tested-by. :)
My bad was that i didn't know that macro style (returning a variable condit=
ionally with c code)
Sadly no new commit by me :(
