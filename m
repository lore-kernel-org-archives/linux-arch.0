Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34549 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeCOOte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 10:49:34 -0400
MIME-Version: 1.0
In-Reply-To: <1521111028-19856-18-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com> <1521111028-19856-18-git-send-email-aaron.wu@analog.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 15:49:33 +0100
Message-ID: <CAK8P3a3qT-s5vp317tZYYZHBmbumdwhWrw-tDpw1bP2_Bpiv5g@mail.gmail.com>
Subject: Re: [Blackfin removal] [PATCH 18/28] crypto: Remove Blackfin crypto support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aaron Wu <aaron.wu@analog.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Fabien Dessenne <fabien.dessenne@st.com>

On Thu, Mar 15, 2018 at 11:50 AM, Aaron Wu <aaron.wu@analog.com> wrote:
> Signed-off-by: Aaron Wu <aaron.wu@analog.com>
>
> Remove Blackfin crypto support
> ---
>  crypto/testmgr.c          |   6 -
>  crypto/testmgr.h          |  88 ------

I'm not sure about this one: while the function name indicates that this is
blackfin specific, my reading of the code is that it would also apply to
any other crc32 accelerator like drivers/crypto/stm32/stm32_crc32.c

Should I include this removal in my series or not?

       Arnd

> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index d5e23a1..8dacd69 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -3070,12 +3070,6 @@ static const struct alg_test_desc alg_test_descs[] = {
>                         .hash = __VECS(ghash_tv_template)
>                 }
>         }, {
> -               .alg = "hmac(crc32)",
> -               .test = alg_test_hash,
> -               .suite = {
> -                       .hash = __VECS(bfin_crc_tv_template)
> -               }
> -       }, {
>                 .alg = "hmac(md5)",
>                 .test = alg_test_hash,
>                 .suite = {
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index 6044f69..021e953 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -35045,94 +35045,6 @@ static const struct hash_testvec crc32c_tv_template[] = {
>         }
>  };
>
> -/*
> - * Blakcifn CRC test vectors
> - */
> -static const struct hash_testvec bfin_crc_tv_template[] = {
> -       {
> -               .psize = 0,
> -               .digest = "\x00\x00\x00\x00",
> -       },
> -       {
> -               .key = "\x87\xa9\xcb\xed",
> -               .ksize = 4,
> -               .psize = 0,
> -               .digest = "\x87\xa9\xcb\xed",
> -       },
> -       {
> -               .key = "\xff\xff\xff\xff",
> -               .ksize = 4,
> -               .plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
> -                            "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
> -                            "\x11\x12\x13\x14\x15\x16\x17\x18"
> -                            "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
> -                            "\x21\x22\x23\x24\x25\x26\x27\x28",
> -               .psize = 40,
> -               .digest = "\x84\x0c\x8d\xa2",
> -       },
> -       {
> -               .key = "\xff\xff\xff\xff",
> -               .ksize = 4,
> -               .plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
> -                            "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
> -                            "\x11\x12\x13\x14\x15\x16\x17\x18"
> -                            "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
> -                            "\x21\x22\x23\x24\x25\x26",
> -               .psize = 38,
> -               .digest = "\x8c\x58\xec\xb7",
> -       },
> -       {
> -               .key = "\xff\xff\xff\xff",
> -               .ksize = 4,
> -               .plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
> -                            "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
> -                            "\x11\x12\x13\x14\x15\x16\x17\x18"
> -                            "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
> -                            "\x21\x22\x23\x24\x25\x26\x27",
> -               .psize = 39,
> -               .digest = "\xdc\x50\x28\x7b",
> -       },
> -       {
> -               .key = "\xff\xff\xff\xff",
> -               .ksize = 4,
> -               .plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
> -                            "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
> -                            "\x11\x12\x13\x14\x15\x16\x17\x18"
> -                            "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
> -                            "\x21\x22\x23\x24\x25\x26\x27\x28"
> -                            "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
> -                            "\x31\x32\x33\x34\x35\x36\x37\x38"
> -                            "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
> -                            "\x41\x42\x43\x44\x45\x46\x47\x48"
> -                            "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50"
> -                            "\x51\x52\x53\x54\x55\x56\x57\x58"
> -                            "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
> -                            "\x61\x62\x63\x64\x65\x66\x67\x68"
> -                            "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
> -                            "\x71\x72\x73\x74\x75\x76\x77\x78"
> -                            "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
> -                            "\x81\x82\x83\x84\x85\x86\x87\x88"
> -                            "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
> -                            "\x91\x92\x93\x94\x95\x96\x97\x98"
> -                            "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0"
> -                            "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
> -                            "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
> -                            "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
> -                            "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
> -                            "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8"
> -                            "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
> -                            "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
> -                            "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
> -                            "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
> -                            "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
> -               .psize = 240,
> -               .digest = "\x10\x19\x4a\x5c",
> -               .np = 2,
> -               .tap = { 31, 209 }
> -       },
> -
> -};
> -
>  static const struct comp_testvec lz4_comp_tv_template[] = {
>         {
>                 .inlen  = 255,
