Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794408666;
	b=G5klWzeurjcsxRmFD56FuuoJdlwkRY/Z6HWj3Af9NYScDIB/LLJbGU2GXpzVtX5dEMf4
	 qLWafoZOBDSk9rDsqW/NIKNnLvp/UPx+B+3aTwZMLFg4p8d4wOhhXcXX6ifBQxnBP0w4n
	 nIJSJrB/mzq5Q20dSNFrGlZGgd9o0PJ1xBkRB36gj5Elb5Ki3j2pHCBf3GQISFR9aHA9k
	 +MYkFFBqzA70xFTjTcMf4qRaO8e13ForE+Hi+ebte335EYNihX6w16Z6rJfKFdJrMM8dR
	 GUefHdk12tWgvOSed4sjff6B9QuRIjhKHi7D1F1zVzE1O9ROpjyrlMC3I8MvcKh8OmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408666;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
	b=BiIRGx10CFLwZqYZ0hNWXOsF7pcWguBno9da3WIaWfYrsoJ4mbvf01ItEsSdC2KrEEpS
	 L3sy2Di4omY7d0jVfiWNFGr6G3cHuZ6QXHdreoazYuEVHtM6mqcIjaSHhX5aTSfKo8gpT
	 GorVtiIK4lRityQIYsV9SCgtvks2zR4DJVRH4YuMoQj0CK6vJirwThmjz14Y+9hVeAcHB
	 v1PWfUJeB2eMYk6T/r6QhdCs2RqTbVLXpa/OSFuF7jxjM9+uyZvauSkR9Md330CF8Om6u
	 g++7ZnFCQzQ/d2iIfSq3FATkTeDJFyXqyJgJwGSoS748kFaYjHRXuE2E69BqcHWDvIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GmZ0XR4m;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B1teWHin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1A606A8BA
	for <linux-arch@vger.kernel.org>; Wed, 11 Nov 2026 14:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC1A606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GmZ0XR4m;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B1teWHin
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794408664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
	b=GmZ0XR4mrCF/5G2oOrASvh4Muy7Ntl1Ixqb9Si3KUnWBuncP1Y4NBsi6SzsSWisxbmEFuO
	pHz8qrdfRqp8bBd/kNnwIgmkmgG0LD5d6osIG/1CA6tRXbzo4md9pcbXtzh+IUlrrMTqWb
	ulGQT0zrSTF5SAmm9Icu5JNFuU4Exn8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-3J87ecbdPYy-eq_IAV5zQg-1; Wed, 11 Nov 2026 09:51:03 -0500
X-MC-Unique: 3J87ecbdPYy-eq_IAV5zQg-1
X-Mimecast-MFC-AGG-ID: 3J87ecbdPYy-eq_IAV5zQg_1794408662
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4d1684d1b3so296372066b.1
        for <linux-arch@vger.kernel.org>; Wed, 11 Nov 2026 06:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794408662; cv=none;
        d=google.com; s=arc-20260327;
        b=K8GY8majAszt8ty6caBo6WcaVDyP/FMc6REJzmJbEbsyj6drHTS9pHo6nDMtGAfPwE
         7Nb1+mX7zybZtP5W6s7IRfvINYknr8BmJTbqc2SsZfvlnawW1ubOu2gwi7K81Kj9YUgm
         fcLeZE5lPmsxor463w5lGKxQKtFAZDkpgbdQxwzBjUqKB405JYZYx3UskeNGR3+4FnlN
         cQgGKjbmyQ9woVrKLE9qMrfFRfaxuUaixefEdYQRR6KxbzT/K+QG9yaq0wrIs3ca15k2
         J0mDUsfn+5iREaAOavKT0+xUtfyeqoD6OSG3djkX/E7D0pRB4ER7efSSlDFU7Iinsqwu
         uIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
        fh=xB20zK6raiugDDuxYygiaSNFJfgtgf/tII+9x7dtUD4=;
        b=kyu6IimFzOpEEEBZV6EY0AOJ3iejegU8kDueU8gkr0bdeR/banjeDiP2cZhaoi+fs2
         tSkxVhzIYATIdfV3HLQ1F2VNjglVt8Qx3XTH0TO8ZUkfsqyrHCKfovQWGpStXWciRdKn
         vgek2kKt0Uqq2ux/ANksR+3uSv7mogVmwhKkui63CrtA5++EPpi8jLSeB5ruf2wF98Xy
         4nDBIQ48ZyVPWP9+mUaVJNy0EsqXv/5bOXwKTMnASCB5xyON9bhvHvz8ZpoGQ3cKZhra
         g6RZFUdvUNOVF+83507y1ahgrttTqd1mr4GP4NkXusVL3Gr1vXZtY/n4hDqPVMTyF3tv
         aOig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794408662; x=1795013462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
        b=B1teWHinaoAB0q7eCy3QOwI0RPrgyFDZxTwxOLKwZz7RzL4XBGeHd100YY1v4ps6HV
         iQFRooZ//QGEP9ltk3ggWqr5NVi+0sjxIjGJUuLMnxer4XzImDDBomOJR9vRL/alNayI
         Eep+LFtKxgYbdMYDbSBa22Dmn3pna12B51QagiGwp1zpE3OnCbJZcyEvtS2QnNJSAflb
         nEeZY/QJievxhxZEFV1Vx2juhRTOxSrTuWCxPwu6BIrihwD/I5U7UY/fjnBAEz2SlsJR
         3AQA6Vum4CpBhApvSKtQ9BqUkhnnK1F3y31aWabaz6dHvz2BV5BacuTySXNE5r5MXL8D
         T3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408662; x=1795013462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
        b=JlQAgwtpctD5ESwij8MFvfM+7eWNq388/xbaseIRCkRGZhUx5tVG+5/Onn9wpAQdpM
         1f1F9Mn2m+5Wznff16gd8bnd3Cd4TmJvzYi5MsgM60bcgHnnos4cxZxQRsZs+5c0nnsG
         /IOF9jWV8koiaDXa0Jo4vKXqJzRJR3/5wZc/bDUGIYsWXvJ6AX0GSD4S6dq1NmJGL3TK
         GbOeomYM1gKMFLiy/muSqe85+fysqFXp+eFfKmqblyuZi8evbogMy4UnEiIR35IIA+Fx
         /z8HjoKC0apS3nXBxv5zVXx9k00uITcIHN2rgs3I69QxtkD1QHOZiVPrTh8gVIQ7H27P
         cR4Q==
X-Forwarded-Encrypted: i=1; AL+hErFyy4C2NmA4P+7U/5pJJizM9tb05tpt50cJ3siXFDyaZ9DFNVesKySlSIQpE1VOb5DKoRSMZnqTiW9Z@vger.kernel.org
X-Gm-Message-State: APuU4Z8szll0U2Ujt8nok6W0x9rFTOcO7rLFNGLNxD1Qc743xraGWIWa
	fEsmQqZBnqpxF0QsIvuS2oT4cjX6kAj+++k5KaiNcVDgK/NpuJoWkJn7lAq06Xbr41hl3e84Zae
	MzpyGUFeiaAXw+k/WpP/X4km9VEVm+1jDJ56AiAQrDtNd6L7rSpbhoD6T9+tSQvaetcgFJGYyv3
	2R52bgQSlRogBWqY+lddZiKnjHjEN+tGHvYBx35GKbfQ4B1Bxk
X-Gm-Gg: AYBFou0ZdLw+niMg4AtKjqzXZyjIYDNwMf/YO9IkvO+Kdzlf+ruFQfw2PxsboXOKgsE
	fCHySjB5Fgx+is0960H/lB+MvR2zOWKstiLH3sXsXWBhrgOb4gS7z3Rk7eKytlvMWgvSpaf9LP1
	vuxrhClCgI3GxtaySISap3U4/A1xfm28pyjEoAF0g0q4Xp/2i5gjW+1h3Nh6BN5wwEtmSBx6y1t
	Jrfogrs/3oIliEYFBJLP/yeZ/c9Xb7rb/u2E+hXMW7Xfg==
X-Received: by 2002:a17:907:3e1e:b0:c50:475d:980e with SMTP id a640c23a62f3a-c5066ca9f9emr181823666b.38.1794408662015;
        Wed, 11 Nov 2026 06:51:02 -0800 (PST)
X-Received: by 2002:a17:907:3e1e:b0:c50:475d:980e with SMTP id
 a640c23a62f3a-c5066ca9f9emr181822066b.38.1794408661612; Wed, 11 Nov 2026
 06:51:01 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111110200.30415-1-jeff@bencteux.fr> <e817126f-83b7-4450-a893-ac4e59460ae1@app.fastmail.com>
 <avRzKRB2f_dP-xEv@ultrabook.localdomain> <6f26e8fd-6198-4c2c-9702-3b7b8dc73f7c@app.fastmail.com>
In-Reply-To: <6f26e8fd-6198-4c2c-9702-3b7b8dc73f7c@app.fastmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 11 Nov 2026 11:50:48 -0300
X-Gm-Features: AclHuK9bWqPtxsq5yiZl7_GWpS_B8DMo81VBx_AeLSjplhjtXPuSUA6-AMhuzyg
Message-ID: <CAABTaaCAhp7n-yNLMPoyJ6=uYaLjkA82KT0CTG4MGfKHdjMvDQ@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to signal class
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeffrey Bencteux <jeff@bencteux.fr>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:31=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Wed, Nov 11, 2026, at 14:52, Jeffrey Bencteux wrote:
> > On Wed, Nov 11, 2026 at 12:18:01PM +0100, Arnd Bergmann wrote:
> >> Why the #ifdef checks? These should be available on all architectures.
> >
> > I included them as convention, should they be removed?
>
> Not sure where the convention comes from, it just seemed
> odd that you have the #ifdef checks for the newly added
> entries but not the ones that are already in this file.
>
> I had not checked the other files that have similar ones.
>
>      Arnd
>

Hello everyone!

It's not a convention. Arnd is right, ifdef checks should only be used
for the ones that are not available on all architectures.

Jeffrey, please take a look in this commit c0d73c09381e ("audit: add
missing syscalls to PERM class tables"). Note that '__NR_statx' is not
guarded by a ifdef.

I hope it helps.

-Ricardo

