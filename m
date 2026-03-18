Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E023C1995
	for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833224; cv=pass; b=gnU0CuUnlyx19q4Nj0qVPeeA3DG1L0tk+6qqBiWMgR8TvUjLDjHeUmCcJ6uC7VsZ51kPKqDOVfpXxbJk9u5WWiF82fjbeoHt0O85Gp6tU/UufarGFq+sFXxZGLipnQTowlbWflmBvdkNFJi7F3hzQ2rMQF5q3LXX+XdQpltgukY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833224; c=relaxed/simple;
	bh=VfT45Tp5CSJoetVLljVdY7D3CpsS5udvkcVehYkltbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlLU1U4IJduZfEn3frybD7OhZoa2Pp24DZE0hGe4pRXNDyvxoA5nN5Yfu/5Pvc9dcasbRAVZH9n7NsUN2He6Kx4yV5yDogzoouXEZcVYEE5pwd+P/mBXaizOgSx7jI2vcuMCEgK9/DNQ6KidWrgdLgg1T1SIv7V0/HXNaVjn7yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5GLDfhw; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5GLDfhw"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986fb839f5so5795527b3.0
        for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 04:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773833218; cv=none;
        d=google.com; s=arc-20240605;
        b=AUeZHmib6ZFC0v9G5/0G/wtPXA5ZkWL4bWJ8/YZGzx4LmDCx6dKMz7ST73sH8EHv1e
         IK/UtTJJ3nMs6VxUcSl9qGVJCAB5jlo/DeuFjTYKAqpm0wrDFvgR2+xhvqi506UOpy7F
         A7jcyHvqOjWUriLuMbSRJb1VaXA/8mMKklKdYtBrRCYGwCoDjzU5GOenj/7zOYNVDs5L
         +Dl9Fx6UFGSujYzYufvnyaf6qNaoAw37CFt9TpXZxhrOgLU9QwoQEM2a2zu4RNsDl9VZ
         uvlWayAtvRQa6lWXBK2P4dRrh2zFM/o4mg3UkpyAYz+1UDQMGJIjA4YYM1UQ6RWQkfKe
         voJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y067c2usVudBMWTyQwZIoaXfwK6OR19DNsDSwXWVTgA=;
        fh=6l0ydD2AyuILDFuoAAFv/ZECeHz8Juq+gNcl6mizKC4=;
        b=NlKxx4a3L4DaQNEYbFnm4vNFwV/+W1MHztKRI+7oHliW+5nIeAZEIXPjJfiCe7ginH
         W8TFIRf2zd2wPueCz/aiNyDW73how9LkibJJDEDP/emqBXPQpdd3PoZfDPf9jbyoFe7Z
         Vz1xCqhNl5HEoXSUq98+d+LAq2o7MZy0F8oWB5YahP0oq4gs8e8nemlTcXw/bgAFKUJC
         ZNM1v3ZVlLes148W7Uk3NFTh+gpARjF8mRfOS2G8UCrGCV89le9ix+2vlFQ4NUhqzPc5
         7s43yl1TthhKz7x52ooRXx8cwfrZLbk3by6v7ZCuqgHHpg8xmgHYxKKoiGkyXA5EYDt4
         zisQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773833218; x=1774438018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y067c2usVudBMWTyQwZIoaXfwK6OR19DNsDSwXWVTgA=;
        b=J5GLDfhwspAner3/02YTKeLOJcOo4/1alME3RzGp12tZinMwTgwRhIebjQlGbIEwne
         0KT7JgDpbCqWEXIxBiha+ImLw5MEGDMd5ZELW4GLIkeG+sVFLVZupjCBDHERejYfpGvx
         ytNUR9+aslU0AnfHygbq3ngsTKsW3AKL2ZLmRChnTEem8EljrBkLTf8Il/nSx+gcmRmk
         gEWsGygmN3cgZYx1gb70F+D1ZAi7MwTbHXhgNnl2CTN2wavX6HSDICpEUoyYxRG/ol3C
         FMmiHpzyDP64FhAXO/QtWly1zx+NVXxcT67NnBwcaPqCsUUVgGtUj9hmWoXFPm/D43+3
         TR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773833218; x=1774438018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y067c2usVudBMWTyQwZIoaXfwK6OR19DNsDSwXWVTgA=;
        b=TKJfpsVsoS5IlQ0kj3IrG4ZcYvrJJauqEryzkna8721CX5jhcE8HUXmzZ+Ba69noja
         4FBkbrBLzejw3VpGunRbeQHX7v04Nk/SxStnyuQjwwjDTyY36KS6IpKOr9+H4LoHHaoQ
         j4Xim78cRxiNC+YrCwcaFR57A/mlPGgmBTVQ475N/4CiORefzlA0CKSUHx8t4n5Os8oR
         kGm44Es0Xo8Q2SodJUXOQ1poq0WCdhl4/TZU9E37F1xZJMG8RfTabIAAVG5uJP1QC5Cx
         TclA0tqs9l0qY2wUF+9GiI5eYRJ5BgTDmu47lD7LyS3rN2Qwe5NQekY3mmN8OAtIHU5a
         ptgA==
X-Forwarded-Encrypted: i=1; AJvYcCWSYbBCNdRynHSU/0F16YSUASU9kAkzVEjsyRQqMCXDAwahj4rwaBLF2Kdou1sqqpHsQ1VswYFqry04@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GfV6ucj9lGkG9KVRkYYurOUDk1HVav8Y6RayGHF+BbQANe18
	eoxpZsxDOpHoR6Od6Mw/SWDs+SEe3ZGe1pNgNK+P3qnvVF2dyYb6qi+qLz5jggf0vmUvSBpO9dE
	jMBTGW9squcJxQSAA6j+hYs4yPdgF74A=
X-Gm-Gg: ATEYQzxCUbHKDFctTocFgsRDdUsa7p0XU4pOmro3LpD9D375UMN76zr3jIpefJs9gcq
	N/V3jofcAnsZAAvE7W/oG0V8prE4s382XZij2h+8y1hs/mcXvPRW0xG3/WRv3f/15jXK9j8mNzL
	5PhT1kSwvwIwbrdsjqj9sFtCkpS5BNOZfeHmBwyhDd/INAXditxHKBmfwKjaxOGMjOr3jbYuonH
	eqPxy4dOAR1sfMxrez8BxABXVwKLnbiACJx+RlwZnnyP16PcVHA/6XTwbawFz5gCpREPNWyGf58
	6FLNcTK017dOd1IxKzqh8UV2x24dOiQ6jZqV6Ffa
X-Received: by 2002:a05:690c:e3ef:b0:799:182:17d1 with SMTP id
 00721157ae682-79a71c6748amr27101017b3.45.1773833218463; Wed, 18 Mar 2026
 04:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315214656.658590-1-academic1mathura@gmail.com>
 <CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2zj1bsiJfiK5+gr+j7Ow@mail.gmail.com>
 <CA+QNo20REG+nJLCJBYtOJfsTiwr-7L637BJgP7XURE7QdJw=kA@mail.gmail.com> <CA+QNo23jM2_puZGi3FsiyU4VxMuqbTEuz9MaLKt58ss=VQz-nw@mail.gmail.com>
In-Reply-To: <CA+QNo23jM2_puZGi3FsiyU4VxMuqbTEuz9MaLKt58ss=VQz-nw@mail.gmail.com>
From: Mathura <academic1mathura@gmail.com>
Date: Wed, 18 Mar 2026 16:56:47 +0530
X-Gm-Features: AaiRm51yhMGKzsIzsKbMuzqr99CR3F7WQeDsCuyUtwTf17nE3sATZO8G876-gVA
Message-ID: <CA+QNo23xYi3NOZ8BY0FzLQKgmjaCQCTsnAyeppJ7TQWiiPjKHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add new system call for non-destructive peek and
 inspection to posix ipc mqueue
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: brauner@kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert Uytterhoeven,
Just forget everything that about  work submitted in two weeks ago
Patch,that is a waste of time to talk, earlier work is  messed up ,no
modularity , Please focus on the current version that has all related
information in the cover letter.
This is fresh work -
 v1- https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gmail.=
com
 v2-  https://lore.kernel.org/linux-arch/CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2zj=
1bsiJfiK5+gr+j7Ow@mail.gmail.com/T/#t

I am resending this email as I was out of station earlier. The main
list could not be submitted previously because plain text mode was not
accessible on my phone.

Kindly review the resubmitted details.

Thank you for your understanding.


On Wed, 18 Mar 2026 at 15:49, Mathura <academic1mathura@gmail.com> wrote:
>
> Hi Greet,
> Just forget everything that about  work submitted in two weeks ago Patch,=
that is a waste of time to talk, earlier work is  messed up ,no modularity =
, Please focus on the current version that has all related information in t=
he cover letter.
> This is fresh work -
>  v1- https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gmai=
l.com
>  v2-  https://lore.kernel.org/linux-arch/CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2=
zj1bsiJfiK5+gr+j7Ow@mail.gmail.com/T/#t
> Thanks
>
> On Wed, 18 Mar 2026 at 15:20, Mathura <academic1mathura@gmail.com> wrote:
>>
>> I have discarded all previous work and earlier patches, as most of the i=
mplementation has been redone from scratch using a completely new approach.
>> Therefore, please disregard the patches from two weeks ago and review th=
is as a fresh series.
>>
>> Thanks
>>
>>
>> On Wed, 18 Mar, 2026, 2:01=E2=80=AFpm Geert Uytterhoeven, <geert@linux-m=
68k.org> wrote:
>>>
>>> Hi Mathura,
>>>
>>> On Sun, 15 Mar 2026 at 22:47, Mathura_Kumar <academic1mathura@gmail.com=
> wrote:
>>> > Patch series overview:
>>> >
>>> >   1. Add New system call do_mq_timedreceive2() and handler implementa=
tion
>>> >   2. Add system call number in all  most common arch.
>>> >   3. Prepared Documentation and test
>>> >   4. Add entry in performance tools all most common file
>>> >
>>> >
>>> > Short Description:
>>> >
>>> >     POSIX message queues currently lack a mechanism to read
>>> >     a message without removing it from the queue. This is a
>>> >     long-standing limitation,when we require inspection of queue stat=
e
>>> >     without altering it.
>>>
>>> [...]
>>>
>>> Thanks for your series!
>>>
>>> > change since v1:
>>> >  - minor update, header guard was removed from include/uapi/linux/mqu=
eue.h
>>> >  - v1 Link: https://lore.kernel.org/all/20260315040827.156558-1-acade=
mic1mathura@gmail.com/T/#t
>>>
>>> Weren't you at v5 before, so how did you get to v1 and v2 again?
>>> What has changed?
>>>
>>> "[PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
>>> mq_peek syscall] for non-destructive receive and inspection,fix minor
>>> issue,prepared doc."
>>> https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gmail.c=
om
>>>
>>> Gr{oetje,eeting}s,
>>>
>>>                         Geert
>>>
>>> --
>>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
>>>
>>> In personal conversations with technical people, I call myself a hacker=
. But
>>> when I'm talking to journalists I just say "programmer" or something li=
ke that.
>>>                                 -- Linus Torvalds
