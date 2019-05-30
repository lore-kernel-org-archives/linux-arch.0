Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21818 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 21:46:24 -0400
From: Maciej Rozycki <macro@wdc.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Date: Thu, 30 May 2019 01:46:18 +0000
Message-ID: <alpine.DEB.2.20.1905300243200.18422@tpp.hgst.com>
References: <20190412143538.11780-1-hch@lst.de>
In-Reply-To: <20190412143538.11780-1-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A88CFBB7AEBF874388829DAF30C86426@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mick@ics.forth.gr" <mick@ics.forth.gr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20190530014618.Ly6oXHJzFny-uB-AOhLuBIJS8EJLJRd3G4QVhQ-PHYg@z>

On Fri, 12 Apr 2019, Christoph Hellwig wrote:

> diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/lin=
ux/byteorder/big_endian.h
> index 2199adc6a6c2..34a5864526d2 100644
> --- a/include/uapi/linux/byteorder/big_endian.h
> +++ b/include/uapi/linux/byteorder/big_endian.h
> @@ -2,6 +2,10 @@
>  #ifndef _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
>  #define _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
> =20
> +#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ !=3D __ORDER_BIG_ENDIAN__
> +#error "Unsupported endianess, check your toolchain"

 Typo here: s/endianess/endianness/.

> diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/=
linux/byteorder/little_endian.h
> index 601c904fd5cd..0cdf3583e19f 100644
> --- a/include/uapi/linux/byteorder/little_endian.h
> +++ b/include/uapi/linux/byteorder/little_endian.h
> @@ -2,6 +2,10 @@
>  #ifndef _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
>  #define _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
> =20
> +#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ !=3D  __ORDER_LITTLE_ENDIA=
N__
> +#error "Unsupported endianess, check your toolchain"

 Likewise.

  Maciej=
