Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C775431E6F
	for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698209; cv=pass; b=kzp+SrAvK5r3Y9QWLA2OuH4ZHru4fF26QsPqz3ZWNSDK778TVNyFVLLNBXvjcQs5YCaPQPh/ledzp2WWIiGhVUMeaXawVdamEUF8wtz8U/g+zPCYf0xUNkgqJS6miZVpyG0wpv3xWihVv/JBzgpmLcXWgrDJkPJucO8afy9FlXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698209; c=relaxed/simple;
	bh=SIP3TprJxk9f7sZwXPXIEhZyUNkSDUUk4StLKXdW3xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiH4GF0zWQPbWkBz/DUSp8wAk9mTtizGTOSGOhPq6yL6QI2wukPOqZz0F1Y9WEIciZl/HTQ6Wdz3bGlmnaef0bfyQOo6OYNvnpd8P3i+8x9f5ACH85e/Dj9ynj43tiQzJSAoOSEemoJpS5Cj+Bogrii0xIlnTd+0iioYzsrpRyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9qCgyR4; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9qCgyR4"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so363151cf.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 08:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783698206; cv=none;
        d=google.com; s=arc-20260327;
        b=ksR+sArkD6k9jK82M1WzUTPaVec6QzySrqDNW5rVOtj46feVDm1PG62x8KUAjP8hKq
         9K3a8EGgYv0PnIskUV5O/ldYaeZlj3PfCZ0SneN2KiYU8eFSeoFIXnuTRaOZZ5d5yMIQ
         rW9MI+tNNdsfsJNw3KHQ3pOBT3AcoNjpV1kkls7avhnTeYrr+hwOdMl43Y7UuQvXd6Lr
         NCiV5ZH094SjE8qff7fUUsCDWJ+3P8dcfcctMSoHNsng2G2konHJqzUcsVBmRqJE42ju
         VDW76HRNitYB3UI8A0UaoEk9z5n0a77sUIfcjuFVoHier7ZCwOUOBus8rUym3hvJnM4i
         SpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eiWuhZx3fx/3kwPRGWti1RYKNclAJ7EyzHkbsfNA19c=;
        fh=Yek+ZXzCnhxk06vRxWmSqAsN7hLVcT/tRLBayQBgNQI=;
        b=re9JEnr93b9t7CGpZKbi4lilQ2ZBR4h0bmcMc1LkJQA49kA00mHsI+C44UOoK+yOvO
         KbNGz35W1AyTMNxt0az5gYh3pYas8mxx4kLS8yu7bbW3AO0GZN8CRnmjnTy3l1SdSQmY
         rDgNneSw+0trtPfHrRpfe/woDlgIGru4LE+HjbdoRUhMk7hUnnx7GJ75XtOdi6Elhabf
         818LiWxqLQVpH7Yva2eDRuzIMwZCDhyvAZ5lteokpGqZ6rkt4ZMJPTKY9xVmbiFjFXD8
         m1MnftZOSo+jKJZmR4ihS0By4dh1eEtNyhfidsNXVkutwwrZ1dORtGIkTCDPh9vu47qp
         UNMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783698206; x=1784303006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eiWuhZx3fx/3kwPRGWti1RYKNclAJ7EyzHkbsfNA19c=;
        b=j9qCgyR4NGWJlEPkgXXWxToAwmFJRYNqrWHN7j9Jmo02W4IloIsfcd5L4rH7fTKc+Z
         1Cm21MwOyHLU8Yivb0xABmjkht4JOpqIoNnpjB1z2FRzYxyZKxaaTNlHWPMmhIfQDMy+
         DVp79hoz2o1nOn4vCxsBzF988uWtrS2VVtUXGkIdT935+zhiVC3tQCvx4CW8zo7vxNa8
         HZBrqOxfy7WEosM8FKLmI9GC3LJ5OhvdJVHUgOdfRyYjQi6KGYFMjnJd+Kc6fFRZ9hod
         JnN4n7OYCKE1u6zGH5kYy5PQoOgWTyX5LJlEWL/CVtTH6H+Ika/K/7mEtlQPH83tBt4A
         0gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783698206; x=1784303006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiWuhZx3fx/3kwPRGWti1RYKNclAJ7EyzHkbsfNA19c=;
        b=kELD31vmluG7voMe7ymg8L7uRFR+IIaXagLyeqvu1Qx8BxBv/ojiM51F+TKI6CnCxB
         wgWGpfBT+x755wCEwebLDRegMjuNt/BBiXjaIT7YStFb4QHbdIpiY9ZOVtLMkthfKqd8
         R3Om+2bPJSCxihNM23PhCCO7Pquq+wgc86I6GvG0mnFTEKpcdE05ljNzAkkNGymokgrg
         ydlLFQqJArqRX3ByYOTB6BLuZyAOJYVrhTVKRgFykZPqpjl3+cleaMOJ5iXgveKg7zQ0
         uorxw5v/Qzj066rcw2fcC9ERfkwRqwXFCTU6aaeXy1CdTO+lcXf8/1nAiSJjIT2S+SpE
         rBAA==
X-Forwarded-Encrypted: i=1; AHgh+Rpt1k8/bBTTuNBE/nceHXEdYaypwqEx+JFCmttMbA/dJQ6/iu37RW5O+FFPFMqaDL/tRLjmYSMnE6q5@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmVdHT9qhHRoAmG1hbaq8jicreusZ0ZnVoU7vsRFoNWsuxM25
	HKwXXRruMjh8e/2gfocQbfwMPvH4TnqcrALw4lWxK9Oj0FzwWlx53WyEusZEwl3NignV2vwotUg
	uVs/YFqEEGSD26O5V5UkOpyB15OzrEWhuNM10dMzEq+jEMCr+3da8lEkg
X-Gm-Gg: AfdE7cmhuX1B4MnmUQ5Voc0wH0ot2BihhNnEfh8GvVIplK4XoTI1WjIlUfWwBcj6k1i
	LfpewVCClXQZtj5O63FYL3ggjAjOS1tmlGz6si+h5rJTtkyCNhAGmpObJkgwjAEZ86UZCGsI0Hy
	XRVK/EqS2v7Nswh2y77r33BOJqopYEHiHa1afH1zNuN1TqDIypewYvqYdhjLsbVsAU86x3rzoCO
	8eejU/kIvCvkr3x4FS53+LHdJfnWC+NVI3m8nBEkQVZ16eL8cb4AEkixlZNgd1GPKgbYA==
X-Received: by 2002:a05:622a:4e:b0:51c:7a8b:c401 with SMTP id
 d75a77b69052e-51caa49039fmr10222971cf.26.1783698205823; Fri, 10 Jul 2026
 08:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708020007.55728-1-atomlin@atomlin.com>
In-Reply-To: <20260708020007.55728-1-atomlin@atomlin.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 10 Jul 2026 08:42:49 -0700
X-Gm-Features: AUfX_mymkLg6O86WvMfSVNUd1VOB0p_rGM5VJHexLUldDKSDY_UVK2hUt0TDUHM
Message-ID: <CABCJKufGH621Vh6JBxmk5XVrFETSvX2tJP1bNiBRg0T-=n+GRw@mail.gmail.com>
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mhiramat@kernel.org, 
	neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, 
	steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Tue, Jul 7, 2026 at 7:00=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> +static const char *initcall_get_modname(initcall_t fn)
> +{
> +       struct initcall_modname *p;
> +       unsigned long addr =3D (unsigned long)dereference_function_descri=
ptor(fn);
> +
> +       if (system_state >=3D SYSTEM_FREEING_INITMEM)
> +               return NULL;
> +
> +       if (!is_kernel_text(addr) &&
> +           !is_kernel_inittext(addr))
> +               return NULL;
> +
> +       for (p =3D __start_initcall_modnames; p < __stop_initcall_modname=
s; p++) {
> +               if (dereference_function_descriptor(p->initcall_fn) =3D=
=3D
> +                   dereference_function_descriptor(fn))
> +                       return p->modname;
> +       }
> +       return NULL;
> +}
> +
>  int __init_or_module do_one_initcall(initcall_t fn)
>  {
>         int count =3D preempt_count();
>         char msgbuf[64];
> +       const char *modname;
>         int ret;
>
> +       modname =3D initcall_get_modname(fn);

If I'm reading this correctly, this ends up scanning the
initcall_modnames list for every initcall. Have you measured whether
this has any boot time impact? Can we at least skip this scan if no
module denylist is provided?

Sami
