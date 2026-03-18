Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752C36B056
	for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822693; cv=none; b=U/VC2MxU0kX3DkHy4pE5XoRemIOt5W4Q/thljyQonGrV6tyLZLTk2CoTCo+F9ijGUO+ydx3KQOTZtusCMXjeGX+H3uwhf+o0sOSAkmtmAXFULNxIv9BfVuk6rGJBM5kWuetd/6lfjrB6uXvGqlK5hCIHdhzPoBW8CjxdrnCzKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822693; c=relaxed/simple;
	bh=q0uH7nPVSKym/I6RVa0a0sYjUwRzNvGaPFeMIrsm9Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M13Upbjh22S9Z21xz7nEZYOKU43yn8faS1pcEcLWmOPcJsAUy3QmpSnh6qdJa2DtCXX52I0i2LRoZ8R0hiw7wQJxGziYAWyvWwVgV10uAVlM0MQbF8t/2sRml5uc/zVTNYx3Fmob4jRKArZiKu1WjYxhh5lRw1uvj8sNutIkKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56b890d1687so2289504e0c.3
        for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 01:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773822691; x=1774427491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwixgHnIrq2NIu4akG4GQIAEnmNYXXBC/KI0BlCcVos=;
        b=kcSZEDe0GW7wExX+/oD+kB0t85MIuOR4rbePsZPoof4hKAnlOSnE7JdvvhZJ841usn
         PrQuokvQvnpeB3YXLVOVZ1YkAcLPrGhY7mTkLWt4o3LDeslZ2eSIy9omISrkxBM0M5b0
         OLOCh/grVug4/geldfApHu3877MMn0ie6fzMNdt5WlVWCJZOGW7iFnEWUNKEsYl7xelK
         DmuWx2OItAxaILkoL6z6M0sUH4YEat8nsNfiNimsWJgojGguW5ObhHZyO96R9aSHuio/
         svGdESzRns13dF1VK17V8EJoWo41Hi/ilbajnd7daXIX/PIYCvateVl5rM0Xyac7/yOT
         QKWA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLJftRlIo9TIe6nDfCeqyZb+Wc1Lq9Nvtmov3ZTR+am1MNmngo892P0PAon3uxU7uJKIIwTbn2Muw@vger.kernel.org
X-Gm-Message-State: AOJu0YyseThESYDSYzGkJ/OHmFxKUgx9J0GtrVkkeENUb2PIeVkTN6/a
	XTiCdauWayjPro4wBmDutQHW9zhtSR/EM69uwCCer1PyN4Uu3wp3e8wRpGpoz5Y7xgM=
X-Gm-Gg: ATEYQzwQjkV3NFGCa+qB31Dl0A5H2i2cEVaux8qgDUncZsWwaM93YuMZWI4r8UZBUbr
	Ayh1C/cJqrxy2VbOhsMDtUA91rQaVn20z/GcQe5DGTWXvlXIPQ/RrWxdQfEJg9EQu+jzZ/+auYt
	LBc2HWujRgWVDOFDsZy4fRzAIz6HeJgugIJWObxxium+4O0sHAajBceN7TwJzkEHdGpWTEkfhd0
	4YSsA0jOSIuF4U+DD3nkpvxh7hFJkdMm1g9W9+//uuNshCxvHU/64EQ8hPaHvgju1Qb8lqHaLmU
	ChAW4BmtzA0od4QxghIjjjDkFSovbJXGrgFT0sfBj9pTzrpdFI1T5ynX0htUv46GJPCEil0LS5u
	o+7QGg85DLHBhz2uiDS02JFT4Evx0U0uNrP8OSx70B5/Yz2/9I4IYWih5o2UxPzyWyPODmbh910
	Ribj1yJKADDP4ewzIJK1PKHrI92BsjKjm3wwZpiLFjs2nh4VPhS/Ertv29BbpV
X-Received: by 2002:a05:6122:4698:b0:563:7062:2a75 with SMTP id 71dfb90a1353d-56ba7072833mr1681457e0c.8.1773822690710;
        Wed, 18 Mar 2026 01:31:30 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ba6fed64csm1239072e0c.9.2026.03.18.01.31.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:31:30 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffc8987050so4199394137.0
        for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 01:31:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYoZdqHyqPZre7PE7ECMBRV+Z68JzFfkE3edUEaQsparFcQAs3CKabIleE44d1yptkM/Ilz+nuujMG@vger.kernel.org
X-Received: by 2002:a05:6102:c49:b0:5ff:fbe4:8ac with SMTP id
 ada2fe7eead31-6027d2c0317mr1379748137.21.1773822690069; Wed, 18 Mar 2026
 01:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315214656.658590-1-academic1mathura@gmail.com>
In-Reply-To: <20260315214656.658590-1-academic1mathura@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:31:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2zj1bsiJfiK5+gr+j7Ow@mail.gmail.com>
X-Gm-Features: AaiRm53eIEeDb4TV3iilyorOvw50I8NeRxvbQihBvnqCrlWD-pUvRv7evCTCqP8
Message-ID: <CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2zj1bsiJfiK5+gr+j7Ow@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add new system call for non-destructive peek and
 inspection to posix ipc mqueue
To: Mathura_Kumar <academic1mathura@gmail.com>
Cc: brauner@kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Mathura,

On Sun, 15 Mar 2026 at 22:47, Mathura_Kumar <academic1mathura@gmail.com> wrote:
> Patch series overview:
>
>   1. Add New system call do_mq_timedreceive2() and handler implementation
>   2. Add system call number in all  most common arch.
>   3. Prepared Documentation and test
>   4. Add entry in performance tools all most common file
>
>
> Short Description:
>
>     POSIX message queues currently lack a mechanism to read
>     a message without removing it from the queue. This is a
>     long-standing limitation,when we require inspection of queue state
>     without altering it.

[...]

Thanks for your series!

> change since v1:
>  - minor update, header guard was removed from include/uapi/linux/mqueue.h
>  - v1 Link: https://lore.kernel.org/all/20260315040827.156558-1-academic1mathura@gmail.com/T/#t

Weren't you at v5 before, so how did you get to v1 and v2 again?
What has changed?

"[PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
mq_peek syscall] for non-destructive receive and inspection,fix minor
issue,prepared doc."
https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
