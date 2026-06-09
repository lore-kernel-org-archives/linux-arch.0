Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE802F12D4
	for <linux-arch@vger.kernel.org>; Tue,  9 Jun 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024244; cv=none; b=LucHvtw3CqmrE030Llwb0pGemEYiIOceRxFbAaARwIos18k9k+1hwaCUa6lty2rUStvmxW5j8RfN3Fd5EewLplHD+3CYzK7BciKbK4FT3RC7t+o6CJhJMbixtbBuqYfRR/hOIKtcNd7c+UzYCADn+HSmdmyfc0H4JLFPtZRwxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024244; c=relaxed/simple;
	bh=txaHnFd2kEzMn2NCa6kJKZmvPyQwxRlm1pVcMc/jxPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qib3wA294VSbKpyhpWLbSutnlFEzZH/1uIr/ukz2z48qy2O8IeS3zP+hWqSjO7ic+ceG99FysV+7q/n/hMwJeiFquzDZJUO8UIEHrgfFHEDmDmV/8XGEIdZFtWjcDkrdWmBylXZK/iKMlsJ2Dq/xFg70pPN2lb0j7K03pIN6M6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am1oHjsQ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am1oHjsQ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d7aa0ac14so3859655eaf.3
        for <linux-arch@vger.kernel.org>; Tue, 09 Jun 2026 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781024243; x=1781629043; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txaHnFd2kEzMn2NCa6kJKZmvPyQwxRlm1pVcMc/jxPY=;
        b=am1oHjsQrmrVK9phahzHHzAXs11aKqG65g0ce1GmeC/xR2DdQ/15Kp4iO+3LE8VdDy
         b7nNkuiExKFPxdHygHgsv39gtbFSzNeJKmpdI5N2Ew8ngyan47iU+PiI0g7DWKRMpqIV
         pK7ufdOqKY7MHOImA5BXTNpSH+WF1YPUdQ9YP18GOZPttGt/0RYJYy3xiEHKfoymHxmZ
         e3TVCnlQ5qQe84+tITwBLldXQMKd+mkZVKwHaPTOumlZkXdgT3d9IZ7POODFJvMx/vsA
         Yjqr/DKGUsirsjei0R3PZgWAqxxUSx9smPMei/MRw8YrnldCao1fOrytItG96gQGz49x
         L5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024243; x=1781629043;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txaHnFd2kEzMn2NCa6kJKZmvPyQwxRlm1pVcMc/jxPY=;
        b=UigrgpeQGIzBUSK4PnAMWxZjqEucZHr5KyvqWPhgLQ4POB12BSjz8muljXwXHVdXXY
         oI9Rp9ilZthX7km3UY1tKwNNSPpXMFsbSRwKvDjDTSeiKb9o7esp7L2OWqODDPrLfA2B
         Lcv8fRc7gA2pPvbUhPOA1ROS4XK6JHAuLIy6KwOcNfOj3jReowCqUI26d5CNh+X9rIEi
         0t1iizLa6wJsdTrUHOZHFPV2YYVOW+uIrYWnHsNv8yJrLG2gPWlQGhBSR2hK0llK7abm
         ndFJKH1RNoYXPzwXtuTgkWMG8n9Hb9yqLGmWsqA4ZR8xydYf36Q2igUMJ0zu4Lea4mU2
         zJaw==
X-Forwarded-Encrypted: i=1; AFNElJ/O/GMSUDRvW418VH9lcSFbyN3eSfpzn07wKoSM0HB7BIBVgo0VlJUwJuwJcYFDj9i4DQrpCeZpjfG1@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYDqqpbVnrwIwNhjk3aKJ8Yb365flimKRedd2fRhtjhbqTpKs
	DL5FzPOACi1bnp8KKsHBIwvoKr8HX5vUpYunBncP84d5ViBgh/xrvcQu
X-Gm-Gg: Acq92OFWBSzTZYQntVDsUAwXGZ2d/bHdoFq0QXGAcVeBQcf/lIkLH4p0FbpCVdl1P2t
	Af+f4F5+3EzIR4TNGES/K7Uj8bjfW/0MhiQV0puTs3bpXWiAqHzizl9Q6/UVCp8/sCf8tCKNynJ
	t9W7pujajRrB6jiwK4V8TfPByIICOzW9Kw2T3nWK7Z9gBYfR9YanCFGTm6RWJ04W8XodoOpwiZP
	bij423nLfrniKlEinbGWbpR7UOKu3mX0ndPQad6xHgihBsHbmnTo0lG4ET0HWHMlC2qQGJ2L7Cb
	eQSqqv+7ulSJ9H6pwzLXC/Tvz9cdGktIbGawBlKefxyFGmhUkZVvZ3QUfjM6DOyM04rrhoiHNY8
	pqGtTKb+NTdDoPVj0V4cY1Y5Vc9NX0N7tSySSUwJAde+jlh7V5lJhVGZGh6oIh0vMZxPSPKMnvH
	goP0WFIDmnlxTH3fWf6JbXIEjmfTnvpMZx4HBGoNncGscU2jT+9zpCS70M/4dNfQlZAZaSHqrL/
	f7K/7JRyA8YR2o1Zq5XbBU2Ryw=
X-Received: by 2002:a05:6820:618:b0:69d:8f47:f682 with SMTP id 006d021491bc7-69eac9f5dc2mr2867484eaf.36.1781024242591;
        Tue, 09 Jun 2026 09:57:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4620c6a3sm12509316eaf.1.2026.06.09.09.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 09:57:21 -0700
Message-Id: <DJ4OEH5KOP21.3HLMYH6CGBIMF@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>, "Linux-Arch"
 <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260609094941.56122-1-gmonaco@redhat.com>
 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
 <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
In-Reply-To: <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>

On Tue Jun 9, 2026 at 6:04 AM PDT, Gabriele Monaco wrote:
> On Tue, 2026-06-09 at 13:22 +0200, Arnd Bergmann wrote:
>> Should this be Cc:stable@vger.kernel.org=C2=A0to get backported?
>
> Not sure if the Fixes: is enough to trigger the automation, I rarely
> remember to Cc:stable@vger.kernel.org and they're usually picked.
>
> In case I guess I'd need to re-submit the patch right?

Yes. For whatever reason the patch didn't reach the patchwork.

Please resubmit with [PATCH bpf-next] subject, so that CI can test it prope=
rly.
And collect Acks.
