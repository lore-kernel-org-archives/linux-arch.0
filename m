Return-Path: <SRS0=jFrJ=EB=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BD1C5517A
	for <linux-arch@archiver.kernel.org>; Mon, 26 Oct 2020 16:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADDE223B0
	for <linux-arch@archiver.kernel.org>; Mon, 26 Oct 2020 16:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780587AbgJZQoc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:44:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28086 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1780389AbgJZQoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 12:44:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-207-h8hdN9cJOPCoHNdXogrewg-1; Mon, 26 Oct 2020 16:44:19 +0000
X-MC-Unique: h8hdN9cJOPCoHNdXogrewg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 26 Oct 2020 16:44:18 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 26 Oct 2020 16:44:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] asm-generic: fix ffs -Wshadow warning
Thread-Topic: [PATCH] asm-generic: fix ffs -Wshadow warning
Thread-Index: AQHWq7EebIuZ4VoVUEKeYhqtQ7gn0qmqFTpQ
Date:   Mon, 26 Oct 2020 16:44:18 +0000
Message-ID: <086e45b325074fc89f51354901aa5af6@AcuMS.aculab.com>
References: <20201026160006.3704027-1-arnd@kernel.org>
In-Reply-To: <20201026160006.3704027-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann
> Sent: 26 October 2020 16:00
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc -Wshadow warns about the ffs() definition that has the
> same name as the global ffs() built-in:
> 
> include/asm-generic/bitops/builtin-ffs.h:13:28: warning: declaration of 'ffs' shadows a built-in
> function [-Wshadow]
> 
> This is annoying because 'make W=2' warns every time this
> header gets included.
> 
> Change it to use a #define instead, making callers directly
> reference the builtin.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/bitops/builtin-ffs.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/builtin-ffs.h b/include/asm-generic/bitops/builtin-ffs.h
> index 458c85ebcd15..1dacfdb4247e 100644
> --- a/include/asm-generic/bitops/builtin-ffs.h
> +++ b/include/asm-generic/bitops/builtin-ffs.h
> @@ -10,9 +10,6 @@
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from the above ffz (man ffs).
>   */
> -static __always_inline int ffs(int x)
> -{
> -	return __builtin_ffs(x);
> -}
> +#define ffs(x) __builtin_ffs(x)
> 
>  #endif
> --
> 2.27.0

An alternative would be to add #define ffs(x) our_inline_ffs(x)
before the inline function definition.

I though the idea of the __builtin_ prefix was that you could
have a function with the same name :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

