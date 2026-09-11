Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91C320CBE
	for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150868; cv=pass; b=io10xHwLFDm0jiGQYll7VWw5cSPoqHQBqFj9u6IR8KhdpOSLcX4RmQU64gUDO9ecjqPugnYEDeGGf3eXgCwQzYkE8ZnDCiOK6LRp+KV63yxoP0AjxgEFiGvzoFfbJu910guVKxlJ3UikuW3lvVdVjLYMU2B2zRWVzhIE38pFoyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150868; c=relaxed/simple;
	bh=ospiNi4mvJbHDyKvltQYpdK+X0l90zSr5sr0fKih89Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaQrQ2tEIbRdfQAvDPhnYF2hfjRdj2y2Af/LUS06SfRSAsvAnnQ8Wop9GnKt+x5dWiOtOhrKywZGlEJcWZ+H7a9YAFy2JqyiK5fkOBCMRYuFp5464f2rIJS+KVeQ0TsbyrLR8PZ/69B2wUX6UFsQZRozX+cJYEtyWg7tkIqjopw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZy1O7nY; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZy1O7nY"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-86d43cdee51so13114257b3.2
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 11:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150865; cv=none;
        d=google.com; s=arc-20260327;
        b=HPMtUY0q+l1qQ7eZEOPTLyRgs8XKYGqGXT3Qh584oyTvrjgkTL1MaQ4Ua38rLzjVms
         5CNWXJrjmlyjcKZKFECe27/XStSm3FKogv6God9uHh9dp5MpBZsROFofxrCbGJ49+N2A
         V9+ba2U/xRClcXH8Tevcha1gFq4VJxn4aaPx9djVGRz5egnV/5uuJ30Xu6kaQKBhwk0i
         BVrNjBITE46KRU36PuPw2N5M0+AuVxEo8ZEUUrv7g7sErNQfpxVwffkCblycInH5llDz
         MRQeLMnGnCG927/ugDbt92br+2MH2cGphvw2M3PVES3yjrVJLTXxzNXsW/+nrHSTXo5D
         ICmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
        fh=tLkQ1kgxSgYlzMuubuzKz98+nQnIPLLw736Sq0XFxRY=;
        b=LA8T2E/K6WrZ81q2INuWsRp+1YomiOMvurdEUNX2kWz2nwfbRt22vX1JX7n4G5HFUx
         J23JpWphPFCSQUemBsG64gEOCo2E0ZvWZY+X5fpsUgZPKmcx958QM5Q8dnKC5hJLPFIO
         C/+H7DhKU4kvYk1awmOPNJoBsk7zUs4/vwVN4el+yTZibRl4a+PXPTo5snUUEjrtOLuT
         xUZ0UhlBSE2H4lru7+iysI3X/R2KVuBbUo6+1WSPCsFwozrSk8SCKiQGqO5HNvlmeVtq
         bdi1EwVDgiUaLEZMAVULLg+eXd8wJ3kddOwbrstBW5th1j+IeuE0cPaY0sKs74pzCmE7
         QBaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150865; x=1789755665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
        b=fZy1O7nYX4F8RpCBL719cejwO2JBZBHCsQ4M29xWe4J1TICgnhFF4vaFKW0LcVXdmJ
         7JdqsQw8HdHi3qOgLEDUvZWJMdsBhJvjcwAlk7s4SAP6Ge1bQDyq7QlkphqhoqP2sjxu
         hlvtKZOtj97s5AEkAIFBG6SfqtoFA9gozAIKE/u7v19trAtrqTj1kwsXEWMxfPpYViU1
         A6r7wP8ya52+HMgnFwqsiTQib+gLaQKrY4yT8f7y2bOXz5s2XRFZO4o9qvbLDU28U4sZ
         lUNz9mwfWNtI+Bz1r1H2qcuU/MZANI+qNPsIsj2VRtTm7dbTNkjPC+WsuM/oSxn58NcQ
         vk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150865; x=1789755665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
        b=aTC8FVdO3UjA/XxL4ak+xQaJW12QQFvob/rePk7qBAwncqosW6mCrsj0yrWaXxLOMy
         LbqZaRnHfOzH31Zo7CshlTDTgbO0NUDcZ7xhKfB7FIhS2olUruDK9jjERcZBBLSwc8Sn
         fcfg9XrYSmuFh/zoBo3pRToRDNSlWlkSn1YncV5GzhWN2JRhdBi/4UWtR8vAUMJLXGRM
         +4MhGL1kXFup1Ot2mbQX3+Y0Lk5miPS3hestzL58vqnsyxIUu/wzmym0umxkRdvu6V1b
         +4V3eh/6bXesehM6bFfk4HqcnSZ6pfz91EC/XAPfBSkN6lPTRPOB6cCwNLNE99zAisvL
         JM7g==
X-Forwarded-Encrypted: i=1; AKwUvBwUoPsxUvwiRpKXhi9ZKxO6ID3myVVHF6pxXv5zObgLsCPycBWNhEs3DOzN3CYRu5Tp3mJ8PSSQhnYi@vger.kernel.org
X-Gm-Message-State: AFuF++lUXMElp+C6O/dmYoAPiudCMvionAfdNrg0wwIYzZhbkXlZ9I5k
	OkewgyTDzzcMktNHL3LE8r+wTE3Ke4RSl0O9ab3Zcn6768wONquhCexr2JWa+JK9DLm7aw+x6ZP
	9PL+bCtYXRBgJj8a5JU2qzgSmk95yUZY=
X-Gm-Gg: AYBFou1ncYiDTfsQZweyL9cqkKlGr36gspFrW8OIOINnu+A0GJi0M+YOFGsoL/hL4Q2
	gBrA9NqTkDDrgNx/QWUMg0Em8qoj9UJlG+FiOeAPk7CBsoBRBEYUSnDxys9Lbsiy3YefpnTO0+T
	5ZUPSOUbDaPSG39f6f0CITzs/+Kb/tnsz1RcmV3cjL/zMyTz6gK8X/atz7PgHT4Yw6nntD4Txq6
	RTv15jqEOCVAN8Fl2r2Ivbiz4zrIx65vGK+OW1FeZXFsh7E3uaLGywFDmmM5IurE5qMG1FwnmRB
	BjdeWufHRyJllmeAtv7LTaA/I7I5s53g4vDakXfbnFzIlo6zrlKENvNJZrwPydNm8P4DLyvj6qx
	res29miF6Dl6owRYDppwa/tiqyUQh5NvQ/Q==
X-Received: by 2002:a05:690e:450f:20b0:66f:c1bc:c072 with SMTP id
 956f58d0204a3-671246c1531mr1637688d50.58.1789150864802; Fri, 11 Sep 2026
 11:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-15-3a3f621f4a10@gmail.com> <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
In-Reply-To: <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
From: jim.cromie@gmail.com
Date: Fri, 11 Sep 2026 12:20:38 -0600
X-Gm-Features: AcwNN1UJu3AgSAwYav9ulJp2R_HPP-fzpsFCD13LL3sQevEBQ_irSbDy0UqSCw8
Message-ID: <CAJfuBxx0VFCS820JLqawLdcpb49Nj-=xnSYdg6ytOub6NidM4A@mail.gmail.com>
Subject: Re: [PATCH v9 15/39] kbuild, dyndbg: Clean up builtin module-name ambiguities
To: Nicolas Schier <n.schier@fritz.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:50=E2=80=AFAM Nicolas Schier <n.schier@fritz.com> =
wrote:
>
> On Tue, Sep 08, 2026 at 06:55:11PM -0600, Jim Cromie via B4 Relay wrote:
> [...]
>
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 9c2f096ed1d8..99bbae37d34e 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> [...]
> > @@ -161,17 +161,21 @@ file
> >       file kernel/freezer.c   # ie column 1 of control file
> >       file drivers/usb/*      # all callsites under it
> >       file inode.c:start_*    # parse :tail as a func (above)
> > -     file inode.c:1-100      # parse :tail as a line-range (above)
> > +     file inode.c:1-100      # parse :tail as a line-range (below)
> >
> >  module
> > -    The given string is compared against the module name
> > -    of each callsite.  The module name is the string as
> > -    seen in ``lsmod``, i.e. without the directory or the ``.ko``
> > -    suffix and with ``-`` changed to ``_``.  Examples::
> > -
> > -     module sunrpc
> > -     module nfsd
> > -     module drm*     # both drm, drm_kms_helper
> > +    The query string is compared against the subsystem module name of
> > +    each callsite, as shown in the control file, or its simple name.
> > +    The simple module name is the string as seen in ``lsmod``,
> > +    i.e. without the directory or the ``.ko`` suffix and with ``-``
> > +    changed to ``_``.
> > +    Examples::
> > +
> > +        module nfsd        # simple modname (as from lsmod)
> > +     module init/main   # subsystem modname (as in control file)
> > +     module */main      # any subsystem ending in main
> > +        module main     # simple modname, selects same as above
> > +     module drm*        # both drm, drm_kms_helper
>
> The five lines above have mixed indentation, please switch them all to
> one tab (no spaces).
>

thanks, will fix.

>
> [...]
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 0a4fdd8bd975..e129c4d10ed8 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -23,6 +23,32 @@ modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fi=
x,$(modname)) \
> >                -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
> >  modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
> >
> > +# Dynamic debug subsystem modname with clean heuristic and override su=
pport
> > +dd_modname_override =3D $(strip $(firstword $(DD_MODNAME_$(target-stem=
).o) \
> > +                                       $(DD_MODNAME)))
> > +dd_obj :=3D $(strip $(filter-out .,\
> > +             $(patsubst drivers/%,%,\
> > +             $(patsubst arch/$(SRCARCH)/%,%,\
> > +             $(patsubst arch/%/,%,$(obj))))))
>
> May it become problematic if there is a conflict with
>
>   arch/sh/drivers/dma/*
>   arch/sh/drivers/pci/*
>
> vs.
>
>   drivers/dma/*
>   drivers/pci/*
>
> ?

2 questions here really -
- what should happen ?   strip arch/sh/ and then also drivers ?
- what will happen - I will play with the expressions to find out.


>
>
> > +dd_modname_default =3D $(strip $(if $(filter $(notdir $(obj)),$(__modn=
ame)),\
> > +                      $(__modname),\
> > +                      $(if $(filter main core common util init snapsho=
t \
> > +                                    process,$(__modname)),\
> > +                          $(dd_obj),\
> > +                          $(if $(word 2,$(__modname)),\
> > +                              $(dd_obj),\
> > +                              $(if $(dd_obj),$(dd_obj),$(__modname))))=
))
>
> This looks quite complex.  I _think_ this should be equivalent, but
> perhaps a bit more simple to maintenance:
>
> dd_modname_default =3D \
>     $(or \
>         $(filter $(notdir obj), $(__modname)), \
>         $(filter-out main core common util init snapshot process, $(__mod=
name)), \
>         $(dd_obj)))
>
> (Removed $(strip) and the last $(__modname) fallback as both are already
> in definition of 'dd_modname'.)
>
> What do you think?

it does read better.  I will try it too.





> > +dd_modname =3D $(strip $(or $(dd_modname_override),\
> > +                       $(dd_modname_default),\
> > +                       $(__modname)))
> > +dd-name-subst =3D $(subst $(comma),_,$(subst -,_,$(strip $1)))
> > +dd-name-fix-token =3D $(subst $(space),_,$(call dd-name-subst,$1))
> > +dd_tok =3D $(call dd-name-fix-token,$(dd_modname))
> > +dd_modname_flags =3D $(if $(dd_modname),\
> > +     -DKBUILD_DD_MODNAME=3D$(call stringify,$(dd_tok)))
> > +
> > +modfile_flags +=3D $(dd_modname_flags)
>
> dd-name-subst and dd-name-fix-token are not needed, dd_modname_flags is
> used only once and can be folded:
>
>
> dd_tok =3D $(call name-fix,$(subst $(space),_,$(dd_modname)))
>
> modfile_flags +=3D $(if (dd_modname), -DKBUILD_DD_MODNAME=3D$(dd_tok))
>

yes, this all looks cleaner and more comprehensible. thanks.

>

>
>
> --
> Nicolas
