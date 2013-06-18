From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH v6] arm: Preserve the user r/w register TPIDRURW on context,
 switch and fork
Date: Tue, 18 Jun 2013 20:58:27 +0200
Message-ID: <51C0ADD3.7030102@dawncrow.de>
References: <51BF8A1C.5070403@dawncrow.de> <20130618100715.GA3539@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54601 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314Ab3FRS6f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jun 2013 14:58:35 -0400
In-Reply-To: <20130618100715.GA3539@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>

On 18.06.2013 12:07, Will Deacon wrote:
> On Mon, Jun 17, 2013 at 11:13:48PM +0100, Andr=E9 Hentschel wrote:
>> From: Andr=E9 Hentschel <nerv@dawncrow.de>
>>
>> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed=
 to
>> prevent it from being used as a covert channel between two tasks.
>>
>> There are more and more applications coming to Windows RT,
>> Wine could support them, but mostly they expect to have
>> the thread environment block (TEB) in TPIDRURW.
>>
>> This patch preserves that register per thread instead of clearing it=
=2E
>> Unlike the TPIDRURO, which is already switched, the TPIDRURW
>> can be updated from userspace so needs careful treatment in the case=
 that we
>> modify TPIDRURW and call fork(). To avoid this we must always read
>> TPIDRURW in copy_thread.
>>
>> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>=20
>>
>> ---
>> This patch is against Linux 3.10-rc6 (7d132055814ef17a6c7b69f342244c=
410a5e000f)
>>
>> v2: rework and fixup of v1, based on a suggested patch by Will Deaco=
n
>> v3: total rework and fixup of v2
>> v4: removed condition on assembler instruction,
>>     adapted my code to kernel-style, both based on comments by Will =
Deacon
>> v5: rebased v4 on 3.10-rc2 and adding this version history
>> v6: moved loading the TLS registers to the macros
>>     (fixing the "LDRD is not supported on all the CPUs we have" prob=
lem)
>=20
> You've changed quite a lot with this version, including the way the m=
acro
> parameters are passed. Why not just replace the problematic ldrd with=
 two
> ldr instructions and be done with it? I don't think the simple build =
error
> warrants an overhaul of the code we already had.

Wantig that patch to be in 3.11 i thought i should do more now to push =
it.
I'm still not that familiar with the process, but i think Russell King =
would
have done this easy change himself when he would be happy with it.
=46urther this patch seems cleaner and much likely performing better.
I'm off till saturday, hopefully i'm enlighted by feedback till then :)
(just to be clear: i'm also happy with replacing ldrd with two ldr inst=
ructions)
