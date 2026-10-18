Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F538411FAA
	for <linux-arch@vger.kernel.org>; Sun, 18 Oct 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352854; cv=pass; b=Aj9wRCTtX/M5WAc8IlB5mCjR8ZLBoqRARtjPJAOFiGkwWLcbGfTPquoFCbm9Qnen4Nm/N39n1KpF0WegNe0h6a5KvULAsxlKbo1vRYSaVGFDAmvuIY7pi2GLz1B1MwEIrimqWdfLosig+ttmApIohmeNEVENeNps7gDQ0So/EpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352854; c=relaxed/simple;
	bh=uSwsGj7z13o5NrJE21iC68UKNr7h5yOq6P5JpP5TNDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bcSyPxt62NLdYBfJgzcN7Hs7joe6LqFodeTjNaqnt3EZInXyI1THVLOYPUr7biJJxJfcnjKV0Nj1MblfAU1JzvswmXCPVAon0TX29Bk3+iEV1XvNNPdjTi5L3Pry8zuEtjQimIhB6Qp1WXWQLMO0ejdy64I0y0/NaBhxTiDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=U61hr0Px; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="U61hr0Px"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a75f960be4so8137631fa.2
        for <linux-arch@vger.kernel.org>; Sun, 18 Oct 2026 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352851; cv=none;
        d=google.com; s=arc-20260327;
        b=iZwKkDSsU5AWwznbGHyV9STn9PVh8qVdJjyWgRTFI5zE2wBXrW/Iwh5Qau3N3ImGmd
         mYXXvaqF1yyKp8iNCAHrTwu4Zirx7l2wq6Bq4ws/infmUhyIQi16UpLIOLsSLgSzOKUw
         mUnTp0CKYkotqB59G/V6OcR7X20hp/WNksgNL37OxVjjS/2B9XW7OzhlTx2+Sogfkr5W
         1EPKQ1TAOLiCwbfwIoJURJEDKpYpXkpl1f6IAn0sCRXR/8Wy2AWvMxYCIfnxR8vnNQIu
         rjX2pAL8+QBXLf7DGRA9MA4eOJl8XOn/kw7Q+WYwcV+UTUpHIuQ6Ynn0Dd8dperZy+pm
         2O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        fh=XXRMsDo3THEe2rPH2ePuA1F+wqJxxZDmWIltUXhCDgo=;
        b=EcC00mOmF5nScT3kKx+M00J0013MhAcrKSF+XX0cq/zLGcbv/I+wbMWTUi74kfql0Y
         9DBPaYCfKHxXiwZ//P1vX7NdGGfgONvjCW6wBDlzPiwDfnZ7bsW2MxDP8oNPH4+xG8YC
         SC38Nsm+he6whgC969EZtfdPMhddRd+lyOST47tOvcoGMrnk2HuxNCWP01A+b7aCs3wb
         iwIJolpdU7/FJb0hg/1EU25BsKE6tm3ectIWqonZeovC78v1Va9FLev5F7bRzqinxoeo
         SNvirsp9URsf3z+O8SWq4z2AZaKY4H/sX2IURRr5w7yogjtgGNme9W04SDEvaS+5PuJw
         oMgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1792352851; x=1792957651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=U61hr0PxGjsekFN/Peus8SSvsCkWL+X4cEShlWPsXJwFZsPSOlvUCsybYg9BgwgJRd
         4XnxIJgNM2UxnPRJ7LJ9ePNZaMA3S+v2khZQd28a3QJuiBcuUaNEpSAyegrHLGxeAQOF
         XWhhz9z4gvoj1jD71wUdmMg7TKUgBLlQEbfCfdSDreL0vc42Gwa+0w9MuT0mJeW9FjHk
         InbXbqmJqWqFBCaE7bhMzpyoImihsnstJokhn5vCptf2p7cb0uxL1CtKsrsoOoa51lXm
         tyklrtgAN7N7S853vG7iCSHElYqHLPGyLpCn9vrAZ76I1HHBL84qCv0LlLe1GVF1/qq2
         6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352851; x=1792957651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=i3uoR0pVjv50KGyDr4D8XYz+j4extmVxkb/ZjgzfmIIzU+RntH8O09+RcgIkXGv3X+
         ctgE+3WJOCxyeFH3C10101XfBj3wn2J8Nit4QSBnNshZ8Tn+0FWWe8kiQgo6ce/aXKME
         UretM2iovJ62RwktVtRHDR4bq0ldGf1Lz2oIFbZKssBvq6DUr6ouFzq/KPVSr6JqAKsx
         Qb6cv49WTGWkl8KT5hZdc+q2Ig0MnEGPmAJ02Rk8mk8wBN5jhtldWXnKPo/tHyNM4pcg
         evIN6yEeLRu3h1IVQUD6OiODCn+tsjf2jKAX+RIKRhaKPNnWAQkwArsvvZRihvmhWEcB
         GM4w==
X-Forwarded-Encrypted: i=1; AKwUvBwofGlagLrnCX1x4Dd8JLV8/cj9UMi2cnq5iVQMD59BEfXSou+I+BTQY/B13XnSG2huTqgTt2zbhjQ0@vger.kernel.org
X-Gm-Message-State: AFq9FYKaOs6XuXT8sdYS3yPwdDtTgXsQSjdKu8HRZyOgyhbJ0UGbU/Bs
	WkWuuEKdrP+PcLEJd91As1K5xXrIqhPIZW9/wInu2VfSpVusUrD5LbAqF7hXYY8UYwSpHgb5s0q
	STTG6z+u0uSzmWHtzNjU89k6uosSvylhAcdh4iMhT
X-Gm-Gg: AYBFou1ATrxUmdiYdHc1ElZcB4Rqs7wbyweZapbHBZOMxVt5X5N3fqvG02mJ1KcfS7a
	7Zf69e3tP2dEmCHH8n5l7zDzqAqTxZOQp/IqNfPhxcRnYKjk3/KN2r4328WOF5Ck+hQ4zpKrBAs
	4L0Vowy83oSh1t1V1/OO6N538/UpoqZn1p1gQOs5YGKilpugZf/Ds6eEhDceAEJnHrLZm0QJU8h
	V01I8ADIteIQv1jgtoiNmqmRYzyv+2aOOCscX8d5WOEwFiCTPW8ydz8wvd1IyEPuuWQpvKQNuIh
	woUI53jZXfpnfpQGvI8oCReIJQ1bdt0mDMFTZPUvF3Oe2xUdoyKJ
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr9897881fa.15.1792352851051; Sun, 18 Oct 2026
 12:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792346472.git.jan.koester@gmx.net> <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
In-Reply-To: <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 18 Oct 2026 12:47:19 -0700
X-Gm-Features: AclHuK_TjVvADO7YV_Of3nNvklGJn7yisT4mnRNh7189wUPwvl6Zlkl0ZNpg8pA
Message-ID: <CALCETrUjRpHSTBzO65uU-YaEj4espqnwDSaSLcXu653xJyooHg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/41] uidgid: let kuid_t and kgid_t hold a UUID or a GUID
To: Jan Koester <jan.koester@gmx.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:10=E2=80=AFAM Jan Koester <jan.koester@gmx.net> =
wrote:
>
> Make kuid_t and kgid_t (and vfsuid_t and vfsgid_t, which share their
> layout) tagged unions: a classic 32 bit id, an RFC 9562 UUID, or a
> Microsoft GUID. KID_LEGACY is 0, so zeroed memory still holds the root
> ids, and KUIDT_INIT()/KGIDT_INIT() keep building classic ids, so the
> bulk of the kernel needs no change. The member is renamed from val to
> legacy so the compiler finds code that peeks at it directly.
>
> Semantics of the new ids:
>
> - They are not in any uid_map or gid_map: they exist in the initial
>   user namespace only. kuid_has_mapping() is false for them in every
>   other namespace, so no capability in a child namespace gives
>   privilege over them, and from_kuid() and friends give -1 (the
>   overflow id when munged), exactly as for any other id without a
>   mapping. Anything that can only store or report a 32 bit id thereby
>   already treats them safely.

Why?

>
> - Idmapped mounts map classic ids; UUIDs and GUIDs pass through them
>   unchanged, as long as the filesystem itself is in the initial user
>   namespace.

Okay, so they pass through but don't work.  Sounds unfortunate.

> +/* Like kuid_t and kgid_t: a classic id, a UUID or a GUID */
>  typedef struct {
> -       uid_t val;
> +       u32 type;
> +       union {
> +               uid_t legacy;

Linux is Linux.  small numerical uids are not "legacy".

> +               uuid_t uuid;
> +               guid_t guid;

I'm at a complete loss.  Is guid is only unique on Earth but uuid
unique in the entire universe?  Even Microsoft admits that GUID and
UUID are two names for the same thing.

I realize that Microsoft colossally screwed up years ago with their
little endian uuid idea, and I sincerely hope that this is not some
endian thing.
