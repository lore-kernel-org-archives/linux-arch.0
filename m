From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH V3 01/29] bitops: add parity functions
Date: Mon, 25 Apr 2016 17:14:11 +0800
Message-ID: <571DDFE3.9010407@gmail.com>
References: <20160419184501.13069.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33521 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbcDYJOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2016 05:14:19 -0400
In-Reply-To: <20160419184501.13069.qmail@ns.horizon.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org, zengzhaoxiu@163.com
Cc: akpm@linux-foundation.org, arnd@arndb.de, dvlasenk@redhat.com, linux-arch@vger.kernel.org, martink@posteo.de, mingo@kernel.org, sasha.levin@oracle.com, yury.norov@gmail.com

=E5=9C=A8 2016=E5=B9=B404=E6=9C=8820=E6=97=A5 02:45, George Spelvin =E5=
=86=99=E9=81=93:
>> Add generic odd parity functions, adapted from
>> "https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel=
"
> Given a PARITY_MAGIC of 0x6996, this is even parity, not odd.
>
> (Which it should be; an XOR of all bits is the "natural" form.)

 From "http://www.encyclopedia.com/doc/1O11-oddparity.html", we can get
the definition of "odd parity":

odd parity A property that holds when a group of binary values contains=
 an odd number of 1s.
