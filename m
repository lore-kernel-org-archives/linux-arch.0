Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64340C2B9F4
	for <linux-arch@archiver.kernel.org>; Mon, 14 Jun 2021 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364EF6120E
	for <linux-arch@archiver.kernel.org>; Mon, 14 Jun 2021 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhFNQCo (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 14 Jun 2021 12:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhFNQCo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 12:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A191661246;
        Mon, 14 Jun 2021 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623686441;
        bh=2JwNAlHxyWTFi/4FCMBxlmr3JnzYTkYJaGT+sBiV1U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEPIg7CyQVAAS4fjgzJzhJ863sGqbDaOeF5DGkw/Otd5dyH74uvBU8ItpNDM/Yabm
         hTVLAvA274nrfWzr55NkUTRsy2WcVldHPwWcLPCSHKDL8ZYUYQrhfwUk/OlQRhi4eB
         ss0jR0c2RtxzWpYFS3xVu272veq3637NdGpcPBNx/sxlgH3nJYC3hMTuOzCidQXzwV
         HcdShzy15KbpPM221M6PoP2zKzFC6Ep/MtB5KqeLAsLKaLFAQfk0m3MxiIN7SL6+un
         2zDizkGRX2FMCyaOTD2VfJ4W76djLwYqRoM7EPxPvH401JXuw3VdwmHrXeD2gD3Br1
         EMZxID8NWd6cA==
Date:   Mon, 14 Jun 2021 17:00:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2 0/3] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20210614160022.GD5646@sirena.org.uk>
References: <20210604112450.13344-1-broonie@kernel.org>
 <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 10, 2021 at 11:28:12AM -0500, Jeremy Linton wrote:

> Of course, there is a good chance I've messed something up or i'm missing
> something. I should really validate the /lib/ld-linux behavior itself too. I
> guess this could just as well be a glibc issue (f34 has glibc 2.33-5 which

If it were a glibc issue that'd mean that glibc would have to somehow
manage to disable PROT_BTI after the kernel set it.  I think I've found
the issue, will send a new version out shortly - we just weren't
actually parsing the properties on the main executable properly.  A new
version should appear shortly.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDHfRUACgkQJNaLcl1U
h9AViAf7BQlBEp1qfFrcbTv9BB7RBU0iHWkfYy+AKB9GoPYYLoDvlohzR126bXfA
Hxj+jdxOhQKlfpj5cI1TPGkLgz4WqQZam16q1G6otbiCJoBS4wIYWhDzgR5I2PoV
WAaImFLt98lGbE2fyR8Wgt4eyrcgEa53RHjUEXHKnDsDrqSiEwoYzrRTBbR/qorJ
b6yCV6onhNvUHUNiEZPDNPgm2k+U/KOJOyKVNe8qEZJnDT0Oto0XGPvb00SuIgJB
vnNOWvTJ9rb27rRnHXqzEkDfLEvufCmpoUMqFxpSNYPTw4yZHriArituaIZDDxvL
PcARtbiD2f41ItW7KZunNPr1rz2fmA==
=02Sb
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
