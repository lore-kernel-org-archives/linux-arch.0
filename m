From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Sun, 27 Mar 2016 15:51:15 +0800
Message-ID: <56F790F3.1080801@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com>
 <20160324152815.3489c6d54270f278e5dc7db4@linux-foundation.org>
 <5C852AF0-E161-4219-B8C8-7CE3140B73C3@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34920 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbcC0Hvx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Mar 2016 03:51:53 -0400
In-Reply-To: <5C852AF0-E161-4219-B8C8-7CE3140B73C3@posteo.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Kepplinger <martink@posteo.de>, Andrew Morton <akpm@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 2016/3/27 6:08, Martin Kepplinger wrote:
> We do.
>=20
> Am 24. M=C3=A4rz 2016 23:28:15 MEZ, schrieb Andrew Morton <akpm@linux=
-foundation.org>:
>> On Thu, 24 Mar 2016 09:38:21 +0100 Denys Vlasenko <dvlasenk@redhat.c=
om>
>> wrote:
>>
>>> On 03/24/2016 04:03 AM, Zhaoxiu Zeng wrote:
>>>> +/*
>>>> + * Type invariant interface to the compile time constant parity
>> functions.
>>>> + */
>>>> +#define PARITY(w)    PARITY64((u64)w)
>>>
>>> Can result in incorrect expansion of w. Should be PARITY64((u64)(w)=
)
>>
>> And we seem to be missing the other 30 patches.
>=20

Sorry=EF=BC=8CI got some problems with my gmail.
