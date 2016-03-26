From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Sat, 26 Mar 2016 23:08:20 +0100
Message-ID: <5C852AF0-E161-4219-B8C8-7CE3140B73C3@posteo.de>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com> <56F3A77D.6060802@redhat.com> <20160324152815.3489c6d54270f278e5dc7db4@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:42104 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294AbcCZWIa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Mar 2016 18:08:30 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id C7DE620989
	for <linux-arch@vger.kernel.org>; Sat, 26 Mar 2016 23:08:24 +0100 (CET)
In-Reply-To: <20160324152815.3489c6d54270f278e5dc7db4@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

We do.

Am 24. M=C3=A4rz 2016 23:28:15 MEZ, schrieb Andrew Morton <akpm@linux-f=
oundation.org>:
>On Thu, 24 Mar 2016 09:38:21 +0100 Denys Vlasenko <dvlasenk@redhat.com=
>
>wrote:
>
>> On 03/24/2016 04:03 AM, Zhaoxiu Zeng wrote:
>> > +/*
>> > + * Type invariant interface to the compile time constant parity
>functions.
>> > + */
>> > +#define PARITY(w)    PARITY64((u64)w)
>>=20
>> Can result in incorrect expansion of w. Should be PARITY64((u64)(w))
>
>And we seem to be missing the other 30 patches.

--=20
Martin Kepplinger
http://martinkepplinger.com
sent from mobile
