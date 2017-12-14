Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:40236 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbdLNX7b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Dec 2017 18:59:31 -0500
Received: by mail-it0-f67.google.com with SMTP id f190so15069500ita.5
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2017 15:59:30 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-ID: <BD3E2B25-B09B-497B-A017-C95C59BDEB83@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D4D046B6-A0DF-45FA-8CB1-C07A3D813374";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2 4/4] Allow to trace fd usage with rlimit-events
Date: Thu, 14 Dec 2017 16:59:23 -0700
In-Reply-To: <20171214220012.10103-5-k.opasiak@samsung.com>
References: <20171214220012.10103-1-k.opasiak@samsung.com>
 <CGME20171214220049epcas2p222a0a63c7aa70908ae316644e121100b@epcas2p2.samsung.com>
 <20171214220012.10103-5-k.opasiak@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com
Message-ID: <20171214235923.ZC65BiRavRu8tG_c5OAl7LdBd6sOwoCrR7_P72O-QNY@z>


--Apple-Mail=_D4D046B6-A0DF-45FA-8CB1-C07A3D813374
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 14, 2017, at 3:00 PM, Krzysztof Opasiak <k.opasiak@samsung.com> wrote:
> 
> Add rlimit-events calls to file descriptors management
> code to allow tracing of FD usage.
> 
> This allows userspace process (monitor) to get notification when
> other process (subject) uses given amount of file descriptors.
> 
> This can be used to for example asynchronously monitor number
> of open FD's in system services instead of polling with
> predefined interval.

I'm not involved in this area of code, but one optimization question:

> +static unsigned int count_open_fds(struct fdtable *fdt)
> +{
> +	unsigned int maxfd = fdt->max_fds;
> +	unsigned int maxbit = maxfd / BITS_PER_LONG;
> +	unsigned int count = 0;
> +	int i;
> +
> +	i = find_next_zero_bit(fdt->full_fds_bits, maxbit, 0);
> +	/* If there is no free fds */
> +	if (i > maxbit)
> +		return maxfd;
> +#if BITS_PER_LONG == 32
> +#define HWEIGHT_LONG hweight32
> +#else
> +#define HWEIGHT_LONG hweight64
> +#endif
> +
> +	count += i * BITS_PER_LONG;
> +	for (; i < maxbit; ++i)
> +		count += HWEIGHT_LONG(fdt->open_fds[i]);
> +
> +#undef HWEIGHT_LONG
> +	return count;
> +}

Since find_next_zero_bit() needs to process all of the words anyway
as well as lots of extra operations that add overhead, it looks more
efficient to just compute HWEIGHT_LONG(open_fds[]) for the whole array.

Cheers, Andreas






--Apple-Mail=_D4D046B6-A0DF-45FA-8CB1-C07A3D813374
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFaMxBdpIg59Q01vtYRAvzFAKCNiNo3+ZVkwMsWLzeY9Deo2m19BwCg6ijg
VkoTljFFE3m5OqHmmcWLgVg=
=sGGo
-----END PGP SIGNATURE-----

--Apple-Mail=_D4D046B6-A0DF-45FA-8CB1-C07A3D813374--
