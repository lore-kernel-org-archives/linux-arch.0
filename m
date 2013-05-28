From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: xtensa: include: asm: compiling issue, need cmpxchg64()
 defined.
Date: Tue, 28 May 2013 12:57:15 +0800
Message-ID: <51A4392B.5090402@asianux.com>
References: <51A34A0D.5070407@asianux.com> <CAMo8BfKmZjH5ysA=d9xpDAR8kb_WoXFinBQ9nMMGRLmnpjQYcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:46941 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab3E1E6H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2013 00:58:07 -0400
In-Reply-To: <CAMo8BfKmZjH5ysA=d9xpDAR8kb_WoXFinBQ9nMMGRLmnpjQYcA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 05/28/2013 12:19 AM, Max Filippov wrote:
> On Mon, May 27, 2013 at 3:57 PM, Chen Gang <gang.chen@asianux.com> wr=
ote:
>>
>> When compiling with 'allmodconfig', some of drivers need cmpxchg64()=
,
>> xtensa does not supply 64-bit implementation for 'xchg', so use the
>> 'generic' implementation.
>>
>> e.g. (for next-20130527 tree):
>>   drivers/block/blockconsole.c:164:2: error: implicit declaration of=
 function =A1=AEcmpxchg64=A1=AF [-Werror=3Dimplicit-function-declaratio=
n]
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/xtensa/include/asm/cmpxchg.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> Taken to the xtensa-fixes tree. Thanks.
>=20

Thank you too.

--=20
Chen Gang

Asianux Corporation
