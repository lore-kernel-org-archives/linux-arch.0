Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from orcrist.hmeau.com ([104.223.48.154]:57582 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeCOOzz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 10:55:55 -0400
Date: Thu, 15 Mar 2018 22:55:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Blackfin removal] [PATCH 18/28] crypto: Remove Blackfin crypto
 support
Message-ID: <20180315145538.GD31069@gondor.apana.org.au>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
 <1521111028-19856-18-git-send-email-aaron.wu@analog.com>
 <CAK8P3a3qT-s5vp317tZYYZHBmbumdwhWrw-tDpw1bP2_Bpiv5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3qT-s5vp317tZYYZHBmbumdwhWrw-tDpw1bP2_Bpiv5g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Aaron Wu <aaron.wu@analog.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Fabien Dessenne <fabien.dessenne@st.com>

On Thu, Mar 15, 2018 at 03:49:33PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 11:50 AM, Aaron Wu <aaron.wu@analog.com> wrote:
> > Signed-off-by: Aaron Wu <aaron.wu@analog.com>
> >
> > Remove Blackfin crypto support
> > ---
> >  crypto/testmgr.c          |   6 -
> >  crypto/testmgr.h          |  88 ------
> 
> I'm not sure about this one: while the function name indicates that this is
> blackfin specific, my reading of the code is that it would also apply to
> any other crc32 accelerator like drivers/crypto/stm32/stm32_crc32.c
> 
> Should I include this removal in my series or not?

Please send all these bfin_crc patches through the crypto tree.

> > diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> > index d5e23a1..8dacd69 100644
> > --- a/crypto/testmgr.c
> > +++ b/crypto/testmgr.c
> > @@ -3070,12 +3070,6 @@ static const struct alg_test_desc alg_test_descs[] = {
> >                         .hash = __VECS(ghash_tv_template)
> >                 }
> >         }, {
> > -               .alg = "hmac(crc32)",
> > -               .test = alg_test_hash,
> > -               .suite = {
> > -                       .hash = __VECS(bfin_crc_tv_template)
> > -               }
> > -       }, {

Yes this should be removed.  While we do still have other crc32
implementations and you could apply the hmac template on them,
it makes no sense to do so and nobody provides a direct hmac(crc32)
implementation.

So there is no point for this test vector to exist.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
