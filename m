Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8353556BA1;
	Wed,  9 Sep 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969041; cv=none; b=T0ufzPhO6r/mE94afG3s5d/SXcegL4K0m0ssjaxtuoEhPLZxfn6qrb3rTZitWeeX+qcAtlSt713dUZbAidn0z0S9eN9i2U08jquFy4Um7lhxfs0MfcRqGJUKvfa6jA10J7NAcUe88FNVbuNZAxiOc8RiFq+IE6d6OTywSE87Bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969041; c=relaxed/simple;
	bh=LqBQ9RCZWmkZ1w31q/klK3NOgGoEtUX3UlKGrYnFi0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BborVGNifDCe2osDIvvWs9ABcIRnFGBzzl5ZJQkiyRRDTFtnXkRLS+5WuhwNjsLiJ4dBsaUv7WN7SpVbOKjaw1c1ZjEI4BT5YHAcDILDVT/qtEqaSHFOexqIxLckLamDPXQaZZq2c75GRU8G3GLkY8jFXnAeD+NzwFr4ej8mpVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=LQE01HXD; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="LQE01HXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1788969026; bh=LqBQ9RCZWmkZ1w31q/klK3NOgGoEtUX3UlKGrYnFi0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQE01HXDl15hpX77X1BngZEktl5EEsxTLs5FtlisTxv7PkvI7+k/zoI46O8AI+NAA
	 Bk7npWIs1FXzziq1yyJkrcftWioXfwUSFzAG+Dl0T2NCjGLbw8DpnM7fkGPHPLmKWc
	 f7O3ljAd9oHxhMwWRKSoPXxGKm1SXdDFSPErWMs8s7PZop6+5CnGNzukjzoGd7+p3D
	 6t1U6CVlaJHDqhduKgeFDY+ddSMnXo6qD6fes0QXMAkUrfYe6LLpYKsscfsqeezOkJ
	 8gKo7EmMr5tWg6fWE6yn7T18FaY3+nGICr159pAye4goQWblmLym+A97e6pu7cGDX/
	 rCLvtaEwiDBdg==
Received: from [2001:bf0:244:244::78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6aa18042-8182-7f0000032729-7f00000189ca-1
	for <multiple-recipients>; Wed, 09 Sep 2026 17:50:26 +0200
Received: from mail-auth.fritz.com (unknown [IPv6:2001:bf0:244:244::78])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 17:50:26 +0200 (CEST)
Date: Wed, 9 Sep 2026 17:50:25 +0200
From: Nicolas Schier <n.schier@fritz.com>
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@net.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 15/39] kbuild, dyndbg: Clean up builtin module-name
 ambiguities
Message-ID: <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-15-3a3f621f4a10@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gxR88jqO9rNjCGhR"
Content-Disposition: inline
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-15-3a3f621f4a10@gmail.com>
Organization: FRITZ! Technology GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1788969026-45F91CAC-7D6342DD/0/0
X-purgate-type: clean
X-purgate-size: 5293
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-03  mail-id: 84D9DA0454  external: no


--gxR88jqO9rNjCGhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 06:55:11PM -0600, Jim Cromie via B4 Relay wrote:
[...]

> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Document=
ation/admin-guide/dynamic-debug-howto.rst
> index 9c2f096ed1d8..99bbae37d34e 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
[...]
> @@ -161,17 +161,21 @@ file
>  	file kernel/freezer.c	# ie column 1 of control file
>  	file drivers/usb/*	# all callsites under it
>  	file inode.c:start_*	# parse :tail as a func (above)
> -	file inode.c:1-100	# parse :tail as a line-range (above)
> +	file inode.c:1-100	# parse :tail as a line-range (below)
> =20
>  module
> -    The given string is compared against the module name
> -    of each callsite.  The module name is the string as
> -    seen in ``lsmod``, i.e. without the directory or the ``.ko``
> -    suffix and with ``-`` changed to ``_``.  Examples::
> -
> -	module sunrpc
> -	module nfsd
> -	module drm*	# both drm, drm_kms_helper
> +    The query string is compared against the subsystem module name of
> +    each callsite, as shown in the control file, or its simple name.
> +    The simple module name is the string as seen in ``lsmod``,
> +    i.e. without the directory or the ``.ko`` suffix and with ``-``
> +    changed to ``_``.
> +    Examples::
> +
> +        module nfsd        # simple modname (as from lsmod)
> +	module init/main   # subsystem modname (as in control file)
> +	module */main	   # any subsystem ending in main
> +        module main	   # simple modname, selects same as above
> +	module drm*	   # both drm, drm_kms_helper

The five lines above have mixed indentation, please switch them all to=20
one tab (no spaces).


[...]
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 0a4fdd8bd975..e129c4d10ed8 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -23,6 +23,32 @@ modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fix,=
$(modname)) \
>  		 -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
>  modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
> =20
> +# Dynamic debug subsystem modname with clean heuristic and override supp=
ort
> +dd_modname_override =3D $(strip $(firstword $(DD_MODNAME_$(target-stem).=
o) \
> +					  $(DD_MODNAME)))
> +dd_obj :=3D $(strip $(filter-out .,\
> +		$(patsubst drivers/%,%,\
> +		$(patsubst arch/$(SRCARCH)/%,%,\
> +		$(patsubst arch/%/,%,$(obj))))))

May it become problematic if there is a conflict with

  arch/sh/drivers/dma/*
  arch/sh/drivers/pci/*

vs.

  drivers/dma/*
  drivers/pci/*

?


> +dd_modname_default =3D $(strip $(if $(filter $(notdir $(obj)),$(__modnam=
e)),\
> +			 $(__modname),\
> +			 $(if $(filter main core common util init snapshot \
> +				       process,$(__modname)),\
> +			     $(dd_obj),\
> +			     $(if $(word 2,$(__modname)),\
> +				 $(dd_obj),\
> +				 $(if $(dd_obj),$(dd_obj),$(__modname))))))

This looks quite complex.  I _think_ this should be equivalent, but=20
perhaps a bit more simple to maintenance:

dd_modname_default =3D \
    $(or \
	$(filter $(notdir obj), $(__modname)), \
	$(filter-out main core common util init snapshot process, $(__modname)), \
	$(dd_obj)))

(Removed $(strip) and the last $(__modname) fallback as both are already=20
in definition of 'dd_modname'.)

What do you think?

> +dd_modname =3D $(strip $(or $(dd_modname_override),\
> +			  $(dd_modname_default),\
> +			  $(__modname)))
> +dd-name-subst =3D $(subst $(comma),_,$(subst -,_,$(strip $1)))
> +dd-name-fix-token =3D $(subst $(space),_,$(call dd-name-subst,$1))
> +dd_tok =3D $(call dd-name-fix-token,$(dd_modname))
> +dd_modname_flags =3D $(if $(dd_modname),\
> +	-DKBUILD_DD_MODNAME=3D$(call stringify,$(dd_tok)))
> +
> +modfile_flags +=3D $(dd_modname_flags)

dd-name-subst and dd-name-fix-token are not needed, dd_modname_flags is=20
used only once and can be folded:


dd_tok =3D $(call name-fix,$(subst $(space),_,$(dd_modname)))

modfile_flags +=3D $(if (dd_modname), -DKBUILD_DD_MODNAME=3D$(dd_tok))




--=20
Nicolas

--gxR88jqO9rNjCGhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmqhgDoACgkQiMa8nIia
bbiidg/7BYG8ZijzqT3j/cWBGDMsLVNjmGdVCS+irPEL1k9mLd2hBdS6CYcSE73Y
sDq7YXv3sI9JJncvwWrWmhkc843HIu5Tlv4/pEGlrrjS3yTVSBioMa0Kah4/bPFP
JzseiIg4yvMAPkvXQOCEx2OEVD54hlgGb+EzOe80Ls1jV5zLuwZl8g9g8XSJATw9
5BBmQSaw38Glox7/s4tcAM3/wUfr4aU1cxHWVw07b/Xuie5Q66TfGFMPIJg8likY
6i0HFY0zHNx4KnMZb08FUXzAK5RfSPo0QVuq8TZHS/xT0TQxc39jncFfxJJqOuAR
JYWvYpWRwSgNtpJX7IM/u6ug1sXTSY8TWDMsH/7NC/qNnFo3ryhMzNdomtWYmbvy
Pi8vqRfbwYVZuA53U2T/TYMZibt3lP7HzXd9Z8Y9fa84d0rEOmWC1UJgdnlIfsqY
AQWuFQLjwgFzdqjN0C25HtTm4AD/ks+Ekopxl5WFUjpk0ybWB6K8nkW3T7yLp16N
BKmKKnXZ8A/lH7X6PicqKI6k71OXvgjB7mCkoh7ccUsCmG8qVBGr4FZ0eSb+C7Oi
YOBvFciA2TeYzjxI/6bHBHWwdFNDoUKu25kzxQNcHtNryBaj4SBORYyNS9NhuC1+
OZy1sgU6zRhtfNVLK8uR8/iAPE93+YKwD8hWSgRGAoGc4v5O9HM=
=uK5f
-----END PGP SIGNATURE-----

--gxR88jqO9rNjCGhR--
