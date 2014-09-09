From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] asm-generic/io.h: Implement read[bwlq]_relaxed()
Date: Tue, 09 Sep 2014 14:03:16 +0100
Message-ID: <540EFA94.1010905@linaro.org>
References: <1410264760-29756-1-git-send-email-daniel.thompson@linaro.org> <20140909122818.GI1754@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56297 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbaIINDP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Sep 2014 09:03:15 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so1136228wib.17
        for <linux-arch@vger.kernel.org>; Tue, 09 Sep 2014 06:03:14 -0700 (PDT)
In-Reply-To: <20140909122818.GI1754@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 09/09/14 13:28, Will Deacon wrote:
> Hi Daniel,
>=20
> On Tue, Sep 09, 2014 at 01:12:40PM +0100, Daniel Thompson wrote:
>> Currently the read[bwlq]_relaxed() family are implemented on every
>> architecture except blackfin, m68k[1], metag, openrisc, s390[2] and
>> score. Increasingly drivers are being optimized to exploit relaxed
>> reads putting these architectures at risk of compilation failures fo=
r
>> shared drivers.
>>
>> This patch addresses this by providing implementations of
>> read[bwlq]_relaxed() that are identical to the equivalent read[bwlq]=
().
>> All the above architectures include asm-generic/io.h .
>>
>> Note that currently only eight architectures (alpha, arm, arm64, avr=
32,
>> hexagon, microblaze, mips and sh) implement write[bwlq]_relaxed() me=
aning
>> these functions are deliberately not included in this patch.
>>
>> [1] m68k includes the relaxed family only when configured *without* =
MMU.
>> [2] s390 requires CONFIG_PCI to include the relaxed family.
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> ---
>>  include/asm-generic/io.h | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>=20
> I have a larger series adding these (and the write equivalents) to al=
l
> architectures that I periodically post and then fail to get on top of=
=2E

That's why you're on Cc:...


> The key part you're missing is defining some generic semantics for th=
ese
> accessors. Without those, I don't think it makes sense to put them in=
to
> asm-generic, because drivers can't safely infer any meaning from the =
relaxed
> definition.

Currently the semantics are described as:
--- cut here ---
PCI ordering rules also guarantee that PIO read responses arrive after
any outstanding DMA writes from that bus, since for some devices the
result of a readb call may signal to the driver that a DMA transaction
is complete. In many cases, however, the driver may want to indicate
that the next readb call has no relation to any previous DMA writes
performed by the device. The driver can use readb_relaxed for these
cases, although only some platforms will honor the relaxed semantics.
Using the relaxed read functions will provide significant performance
benefits on platforms that support it. The qla2xxx driver provides
examples of how to use readX_relaxed . In many cases, a majority of the
driver=92s readX calls can safely be converted to readX_relaxed calls,
since only a few will indicate or depend on DMA completion.
--- cut here ---

The implementation provided in the patch trivially meets this definitio=
n
(by not honouring the relaxedness).


> Ben and I agreed on something back in May:
>=20
>   https://lkml.org/lkml/2014/5/22/468

=2E.. and didn't you also conclude with hpa that the very relaxed x86
implementation of readl_relaxed() already meets this definition (as do
these changes to asm-generic/io.h).

Thus allowing its use to perculate more widely really shouldn't do an h=
arm.


> but I need to send a new version including:
>=20
>   - ioreadX_relaxed and iowriteX_relaxed
>   - Strengthening non-relaxed I/O accessors on architectures with non=
-empty
>     mmiowb()
>=20
> I'll bump it up the list. In the meantime, you can have a look at my =
io
> branch on kernel.org

I'd really like to see your work included (which I spotted after I wrot=
e
the patch and when it occured to me to visit
https://www.google.com/search?q=3Dasm-generic+readl_relaxed to see if
there was a well known reason not to make this change).

However... I really can't see why we should delay introducing an alread=
y
documented function to the remaining architectures.


Daniel.
