Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B8318EC7
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018689; cv=pass; b=Z92Td1Dx2hMFPsBxKHXIcxVyWMdweY8x114fTkxVf3aSoOrFaYd+hDnYXjfAtLliIqDKAoqNqzFr1I9PwhRn17/XaE20fxl6SvGxloxLVuNMAsxZFoOPzKs4Lz4TpZMNbex7qKAPWV1njXHP7chOXnySGkiS/Mr8gG+vQkVPzL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018689; c=relaxed/simple;
	bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSgFe9+pkbgp/rD0dnLp7/WFfakJoRk6R+mCvpolXuac0i2rj7kZIsS8NamZ3S/thM1SzlWKbNoVEQ67E8zfBugeERVquLO/vxs4/BJ/0v1oW4OnYkMONUOkASty/zTQC6u7/+VQwy1Xk2tVVBDkzrdwRvxXipUwGO0rEFfuE9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdGQ+rOk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFE09HNo; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdGQ+rOk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFE09HNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777018687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
	b=KdGQ+rOksMmtNSNpYp7CmknQkKu04JQoI2Szr5eK0qd/KR5uV3VyK9iHh8JC3BKLQll1FE
	0Zn8cyypmqzphga1c/ivjXe9nqDjDKH1VGOHQeSOrWlhGcEDfipOcJZlLkgPWiaCL3iAFf
	m06ieyw1d36sZ/X4AoO7R/a6JtHp1ME=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-2FRavaCxMZOnIy5ZjWAU7w-1; Fri, 24 Apr 2026 04:18:05 -0400
X-MC-Unique: 2FRavaCxMZOnIy5ZjWAU7w-1
X-Mimecast-MFC-AGG-ID: 2FRavaCxMZOnIy5ZjWAU7w_1777018685
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7a1f794a45fso166913407b3.2
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 01:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018685; cv=none;
        d=google.com; s=arc-20240605;
        b=V9+BecAnIKBK4r6PmQW6Xq77uxGlivNQeueUrz/yuat4TIJPFHYm0kZOsErucs26Mu
         yIu83Hb9jEtR0S5LJt4KN0TtrrmzmgBMlWCchDS8Fvmpq6Y12hH6InPH/qcsiCSKjIYZ
         zM+JbIFPz+Xr4gcB4Rv/LD+Ci3DQ2wqf8U0+/Th+u5wSe2tGeYGKq7vQsXNDlfXNx+p9
         1hW+vis8Ydf3DY82PqX9bR1pgDQBons2kbAwt7+wPRYmHsdzk0qam/RoTOb5aTmrSmAd
         6EHmWMfLX4Uh/NtczLr6++sXWxxvLK8ShT3VMBPmCqR9/3lLFygcLbio1/PZeab+gQ0J
         7ATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
        fh=sSAeiUR+xKMxxe16xm9MFLfMWlbZuPQYblPdG1vfuBM=;
        b=bRz2Sn+kVXWwLmUFSZ3rO8pJVmfz8P6yEI+nFIwxLo3EbrPwOfYbnRma5Rp8Ah4QYc
         curO22maj8mSD53vekD39F0j7khe3VHkUnXp+vXofveDo2o2s9AFfjSrAwnrzhw7z5rg
         yq7fA4ymkcyaULLfDnSTyAjt83iQPZg2HVGcWYIuI08Y845JR24JDCHdMOSoI/wEHlba
         +xpr/kSZl2AgGBxA9DRI8hg1LaAnId8O86YYqpjd9RbEWpTvf5/7ii18XaAgjbKnroOK
         TCiyo12SLofMq5gF3ew4LbiCM5+vbnhdmRlxCHYNNtPxST5/hq2CmASlkLLNCh2bdTXN
         pEgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777018685; x=1777623485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
        b=UFE09HNo4IGvA8BUZdlOUfb5zSlXe1AzSU3lpqk9eEWyX/ESq1QT64fOcmWUKlybCd
         sk5NholQlm5fwRG/RzNqL0i8tdBdEIDic3/1WfOqSGgmMTEWxaSwoUc/TjJj5Gigrl86
         fib5FKeNBDtEAEAdonFGPNDj2pxqVdFzZ0LI1RKkE0terFZzTLOHiWXVYo4y93Qmlpzn
         LPt9zxwWmz41MWYORXZmQZivzcPzn2Ti7pAmcudKpl0UzOZhuF8DLgB+CBFciUl7jeFi
         5MxiLj4PoNvKquSqbkIAxeMLTtrNAXtDvxXjLrhXdkL9B4qPdWGsemdSOD1rsyYqEdgY
         FRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018685; x=1777623485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
        b=d0eN5bSRgO1SQxVu9KIDrtm/JGMwEXIbWYWr8s0F0zExiZ3bC7ueibXqDNKicviUQj
         hLXRddFZy49wOR7S/nf+XfR9MwtaOs8cVzbl369V//fbFGxULy7QbkaoFnTaaGQF02uo
         ETc5WzUfOkEglBh31ftSULSy4tap8u99arp7NseBSgWLdtd7SAQcJowSwiHhtn6FsHyE
         NTIoWRjA9iyZ5dESHG1krgVlU7SgoL2R62Q4pWU1TJbEp1YhggdDSlCssZzDb/3l8JqZ
         lPCg3BIJu3Foc5/iewEOEPB8gtA5i5yhgh6JIjXMpNMjveb82XjsPh7cy2zz+qyYU2X8
         ZCsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6XfzcLt7V88o78ZUf+phrpq9S/7eDr2mOyBVmRQWSSNhFrjHZqWv+gwzOkxTeuV/ZaAJFroQI1rzs@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTguutVv87Y4S3iVrJyKJDtq9Ik6IigUB0cXfAszI9EOLt/4s
	1DKHcRMblfUjC1b6Xh4ihyI72uUa54mKvOSZGMMiz9j6WVNC+iiUFigjwXRsLhjMUE1E3zH628i
	cIrYxpvd8t9qOuuV/KYi6Sulc1dnNO+wGz5ztx+qCit2rgn5Rv1ParS8LWLeVXc8zcJUgz+n5ax
	hToOtA4DgBxyEwgrqKTEGJsYmeGu1dSr/wf5tPs/h7RUvOryLxuz8=
X-Gm-Gg: AeBDieuPRU4PjeTcZ2FEGZELNE2fflO4XSheCDTMTE2d6HmRtqUkus9BlgrL6KfAYdx
	bT3NcPeVCQr98coBIqyOJGvv4Lay/qXQvWWkOmudqUmx+ovye9SB9tFkzWxF4iL1cvfEOSVyE4k
	rabB54BA91VC7FK/kXHKCCrochn5ypJOcsmq/ieQ5i2tq3oYBwdLD0FoBLeCCBVRTzefBSJ5lWo
	c07MJXfToV3BTrd
X-Received: by 2002:a05:690c:d95:b0:79e:8299:751d with SMTP id 00721157ae682-7b9ecebaa2dmr304557027b3.11.1777018684926;
        Fri, 24 Apr 2026 01:18:04 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:79e:8299:751d with SMTP id
 00721157ae682-7b9ecebaa2dmr304556787b3.11.1777018684469; Fri, 24 Apr 2026
 01:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com> <a1ddabac-8e50-4730-b936-4ddef949487e@davidgow.net>
In-Reply-To: <a1ddabac-8e50-4730-b936-4ddef949487e@davidgow.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 10:17:53 +0200
X-Gm-Features: AQROBzCPgKA61g5jTjlSE5A3sG-gDo7X0r4wi6SlVdjlUQQBr3gtOcBVPcG2A_U
Message-ID: <CADSE00La5sN18OqEmSE7NHwHnS02k5C1Gn2+o9hy4S4zLgC7dg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] bug/kunit: Reduce runtime impact of warning
 backtrace suppression
To: David Gow <david@davidgow.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, peterz@infradead.org, 
	Alessandro Carminati <acarmina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 2:21=E2=80=AFPM David Gow <david@davidgow.net> wrot=
e:
>
> Le 20/04/2026 =C3=A0 8:28 PM, Albert Esteve a =C3=A9crit :
> > From: Alessandro Carminati <acarmina@redhat.com>
> >
> > KUnit support is not consistently present across distributions, some
> > include it in their stock kernels, while others do not.
> > While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
> > features, the fact that some distros ship with KUnit enabled means it's
> > important to minimize the runtime impact of this patch.
> >
> > To that end, this patch adds an atomic counter that tracks the number
> > of active suppressions. __kunit_is_suppressed_warning() checks this
> > counter first and returns immediately when no suppressions are active,
> > avoiding RCU-protected list traversal in the common case.
> >
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> I'm not sure how much of an improvement this is.
>
> It might be worth putting things behind the kunit_running static branch.
>
> You could even add a new kunit_has_suppressed_warnings static branch,
> though I doubt anyone's too worried about the runtime performance of
> WARN() during testing, but with no suppressions, so it's likely not
> worth it.
>
> Have a look at, e.g., kunit_fail_current_test() in
> include/kunit/test-bug.h, which uses the existing hooks implementation
> and static branch to reduce the overhead as much as I'd expect we need.
> That'd also potentially let you move the backtrace suppression code into
> the kunit.ko module, so you're not even paying more than ~a pointer's
> worth of memory if no tests are even loaded.

Agreed. This patch can be removed entirely once I integrate it into
the hooks infrastructure as discussed. The kunit_running static branch
is indeed a better fast-path than the counter, and leverages existing
architecture.

>
> Cheers,
> -- David
>

