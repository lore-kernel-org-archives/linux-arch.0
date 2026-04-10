Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996B2D877A
	for <linux-arch@vger.kernel.org>; Fri, 10 Apr 2026 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810133; cv=none; b=ncOVZecqpv7/46luQJSjbqDRC4FoPHs198lz8niWYFXFazcJ+LPI/p7evqJFgTv2RyMXTbdSI7+a8fNf+rgJ158LHLMvJ6EmrgIv0JawUjH/P2/tcH4ch8PWK0XGSwv9dzNnaBmKPLjbEg+vxwQVffE+DzsCb0A/7s4BRlqXAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810133; c=relaxed/simple;
	bh=r3o7TyAvYn90Ww2v104Gl1JFBfu4uAg42L7TMid5ils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrtBXeflwPIGjAeplIU8DHqUFvVukZULtoRBMFafvwARj3BAkAZxQR3i1RqMp/1pBGqsB1m8bKN2PJHGAf3xTPWUw5uSBKvUcjjZP19/+9OX9McBafiw3y2zfslAHmpcnx2f82dia4M8u6QLUuMceJqEmFPK82P46jrx91sGbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeBBSPat; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeBBSPat"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ad135063so15715095e9.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Apr 2026 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775810131; x=1776414931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDrRORXqwjO/w1YCwauGfrHI2K78vJz+M9V6gxkImmA=;
        b=NeBBSPatXkARY4wJAhpBXUh5D9EsafolV5UnSA/aM3pviiKSYNoRjr6gLEboV+wLih
         H8r+cO5jAp8I2vG00Ly2KDHQ2ZrRUwU/jM4N7RWUs6HN+n77p2qE7HUA8RSmt+IRyZUx
         RmXWg33H2gmyHW8xv1gdI+aY3YvA3H2NT3Bej8ZP0eQemcLOjYylaNGDyJ6HwiFEBk0x
         LOwLJbdXxk3VqlwoRoYcdBDiet14khYwEkVJLdJDaCdnxLrbL3ocalbByPiIaH/gpQwy
         zkdb2Yfsjo84JC7jp6kD/AowiAb/ZOBf9iPPFFpwccvKmNEY19+EmsQpCZ8RQID/SRnw
         FQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775810131; x=1776414931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDrRORXqwjO/w1YCwauGfrHI2K78vJz+M9V6gxkImmA=;
        b=U1R4Q4tc+1ApV0LgmuQM2r7yvTVdxM0RDSNgdT3GXQC1JSIkEjs+p8EHZpwhYHI2yE
         BxxVVlq6t9IXWhWOaSaXuNbTr99X+LxBXtXpfFsrDBy5dls2xNIFvT2ek7EDDc+6BFBD
         BhdXZ81KPXAv0KWv5wQE32XoFtDxDG+wiFbc+BdgbaYbnD36PQqyENqQA31s5OTIlkhj
         iOGbtf6TLBBiiMsCwfco7V6ZUxTOfq2d87IQE0yz/QjSkBCv6RWhIoONV8KTc6Bl+DfF
         nXBYyWJvDLUTkY4mrq5uKIHIe6kMZPEWUxrc0U0/AboRG/npxvyCmicQEvXV5f3lQyyg
         C+nw==
X-Forwarded-Encrypted: i=1; AJvYcCVsFDwvemp3r53hsoK+RKgeYxmcLtQiMpKhfbN2T6CmAnhEUpwslGaI4X82NKTVDJMVzYMp8p3uSaFo@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgEugqSrTcaA9imqQ5tbuhG/xZcOiMccBEFpsQMqEhDgih6gG
	V2j/oHUNkcCb4fMK3467tcGKpWAi+Al9fm+1jlRX9D/YuIeeZ9JGkvk=
X-Gm-Gg: AeBDievySd7E4sM3cydyyQIlEnLNKsoDfvv53O2EsYV5dP/8HKBp5LVqVEEqGxW1hdu
	kldlaqZcGIHw72lSeOsvLDM+d/LM4q4cMMMmh6Ko0lA47inr41dMOL1Xe9xU/8LdlltxZCa0Jqb
	nhmRtBaBrKnhpmpONqfhxdEtbkFLnhxaeUPSk/RH62BypAk8fgDUnkzNZo596VBHkUfvdMqvTAE
	NZmVvF6FDhnrqlM/dMfYUl23hQAKL7iZLUPqMy6FD6Qv1H8HP7Rgav0ZtjHS9lkplFZmiBfdD2L
	vAyGrfhLUOtfHK0vVGjQp1lJGvZk9GZy1OYRmwJWfYTiyONB5RCGGlfbi9aTS1G77n9Cb9O2wq5
	65Sw38CLgDyCcaQBv5U51ARCgJl6JzGRqX4XO1dtvt4VuwTdRVEEWu948pl9zyEi4qMaYPh3/a6
	bEW05k8FJYL30TBaOytTCPyJSvR1282rbWLtJOArTFhVML84EEmdjd2hekl7kfNzrg3MVDGndvo
	Fzagg==
X-Received: by 2002:a05:600c:674f:b0:488:a82f:bb9b with SMTP id 5b1f17b1804b1-488d68cb47amr27836175e9.30.1775810130619;
        Fri, 10 Apr 2026 01:35:30 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-188.brest.telecom.by. [46.53.134.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5cf2e70sm27761365e9.0.2026.04.10.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:35:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 11:37:23 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
Message-ID: <d095cc40-5217-4318-ae2e-40e5fe3be47a@p183>
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
 <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
 <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>

On Fri, Apr 10, 2026 at 03:40:30PM +0800, H.J. Lu wrote:
> On Fri, Apr 10, 2026 at 3:28 PM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * H. J. Lu:
> >
> > > To enable THP segment load, ld.so opens and reads 2 files under
> > > /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> > > /sys and is expensive.   Is it possible to put such info in vDSO?
> >
> > Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary
> 
> Does it cover
> 
> [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
> 2097152
> [hjl@gnu-tgl-3 linux]$
> 
> > vector a while back, but I don't know the status of that.

Status: nothing happened.

> How can we get
> 
> [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/enabled
> always [madvise] never
> [hjl@gnu-tgl-3 linux]$

This is not covered, see the link:
https://lore.kernel.org/lkml/ecb049aa-bcac-45c7-bbb1-4612d094935a@p183/

PAGE_SHIFT_MASK should be folded into system call probably.
