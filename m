From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v3 00/24] C6X: New architecture
Date: Wed, 28 Sep 2011 17:49:01 -0400
Message-ID: <22021.1317246541@turing-police.cc.vt.edu>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1317246541_2944P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:58549 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab1I1VtD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 17:49:03 -0400
In-Reply-To: Your message of "Tue, 27 Sep 2011 16:29:41 EDT."
             <1317155405-26235-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

--==_Exmh_1317246541_2944P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Sep 2011 16:29:41 EDT, Mark Salter said:

> This architecture supports members of the Texas Instruments family
> of C6x single and multicore DSPs. The multicore DSPs do not support
> cache coherancy, so are not suitable for SMP.

Is there a usage model for the multicore? I know somebody had some patches for
"HPC dedicated compute cores" that would just basically run a userspace process
and that's it - would those be applicable here?


--==_Exmh_1317246541_2944P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOg5ZNcC3lWbTT17ARAvUNAKCQNKQ3GKe/pAXziry3frgqRubuOgCfXgzR
ea0cd5JWz6qrCamCTDAKsAQ=
=00bY
-----END PGP SIGNATURE-----

--==_Exmh_1317246541_2944P--
