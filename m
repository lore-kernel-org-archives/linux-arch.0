Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:7997 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933167Ab3GQQqV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2013 12:46:21 -0400
Message-ID: <51E6CA5B.6030501@tilera.com>
Date: Wed, 17 Jul 2013 12:46:19 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] arch: tile: include: asm: add cmpxchg64() definition
References: <51CA6D21.3090901@asianux.com> <51CC492C.1040105@tilera.com> <51CCD891.8000806@asianux.com> <51CCEC27.8050508@asianux.com> <20130628150941.GA22767@linux-mips.org> <51D0E4B3.6080402@asianux.com> <51D0E7BF.9030206@asianux.com>
In-Reply-To: <51D0E7BF.9030206@asianux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@logfs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <20130717164619.ud3SsiVNR_ScMqP6cbApd9W-fCV6-YKiSnCi5TTlycM@z>

On 6/30/2013 10:21 PM, Chen Gang wrote:
> Need add cmpxchg64(), or will cause compiling issue.
>
> Need define it as cmpxchg() only for 64-bit operation, since cmpxchg()
> can support 8 bytes.
>
> The related error (with allmodconfig):
>
>   drivers/block/blockconsole.c: In function ‘bcon_advance_console_bytes’:
>   drivers/block/blockconsole.c:164:2: error: implicit declaration of function ‘cmpxchg64’ [-Werror=implicit-function-declaration]
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Thanks, taken into the tile tree.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

