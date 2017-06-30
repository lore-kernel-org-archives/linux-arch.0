Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:55786 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdF3QV1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jun 2017 12:21:27 -0400
References: <20170629161000.15563-1-logang@deltatee.com>
 <20170629161000.15563-5-logang@deltatee.com>
 <HE1PR0401MB2585F67CA6DE08D083AA043998D30@HE1PR0401MB2585.eurprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bc8579cb-cb9e-c20a-a2e2-41d8a30224f1@deltatee.com>
Date: Fri, 30 Jun 2017 10:21:11 -0600
MIME-Version: 1.0
In-Reply-To: <HE1PR0401MB2585F67CA6DE08D083AA043998D30@HE1PR0401MB2585.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 4/4] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20170630162111.ZjMaqyLLXQIHgvDw8MMOsuOBMN5cXDPuBD6KPCclalg@z>



On 30/06/17 12:18 AM, Horia Geantã wrote:
> On 6/29/2017 7:10 PM, Logan Gunthorpe wrote:
>> From: Horia Geantã <horia.geanta@nxp.com>
>>
>> We can now make use of the io-64-nonatomic-hi-lo header to always
> Typo: we are using io-64-nonatomic-lo-hi, not hi-lo.

Yup, thanks. I will fix this for a v4. I've also noticed a couple other
mistakes I need to fix.

Logan
