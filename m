Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:42936 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeGDRXM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Jul 2018 13:23:12 -0400
References: <20180622194752.11221-1-logang@deltatee.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
 <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com>
 <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com>
 <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com>
 <55236e2b-a2a5-493a-5696-19c5926885b3@deltatee.com>
 <CAHp75VfCFdFh3eMpdpNYdNtbuVKG60PbUnYVsEbCrxP5pUZwMQ@mail.gmail.com>
 <bf8df451-ddda-8c6f-ad0a-bda7f7905f69@deltatee.com>
 <CAHp75VdtkYRWyKnD+wXo_Z_t=EK9dAOTFzbnHmraSt80sAmyHA@mail.gmail.com>
 <CAHp75Vfd2wcUV_dY5ns28+9aC32=OiVExuxOFu7ZjMU2dYuA4Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d633fa61-c5ef-5e0d-cac7-19adef80fe0f@deltatee.com>
Date: Wed, 4 Jul 2018 11:23:04 -0600
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfd2wcUV_dY5ns28+9aC32=OiVExuxOFu7ZjMU2dYuA4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Horia Geanta <horia.geanta@nxp.com>, Aymen Sghaier <aymen.sghaier@nxp.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20180704172304.WKB4qB3MWc6ocxA8PaLckfvOBC32YIUOJY5f6V9seJA@z>

On 7/4/2018 11:21 AM, Andy Shevchenko wrote:
> I think it doesn't contradict with what you are saying rather supports it.
> 
> I would expect to have lo-hi and hi-lo semantics done according to the
> data flow, not to the address.

Hmm, no, I expected the opposite...

Logan
