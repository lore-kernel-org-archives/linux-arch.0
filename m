Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794574147;
	b=JhFnqv/LXmM054VFExWG4N7OpbX9IlZq7MIaJciryt3pDHJYseCkRJRLuAPMwmHHHuI+
	 ftQ5gpRv4+vp8u7PI/GC4CZzcAxKvHw3Wx2uNbs5yQbOWHW7X+U28csw4VH/AOVLEAcBx
	 TIJHwVH8wCP65wB8xxR0S71Ync7CeVY5cMRpmwnTGiPOaJceJz7WncFY0r02h5gEjboZv
	 9b2jl1Q+9eLBV9RSHIaa0/+/ndQQlzLi6iPgnECqO/378q3BuAWsTTf86eVQQmwCSY2Ud
	 lTr9DQtkAZhCrbAtB83oM4kbA/UjhL1Ikp7C+1HxyrdL3gX+hhtqy04htaZnhKv1MiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=NwQ8D1EwnOoAfIOU4uGhmCxYyPdinhr/Vhvd57u6TsE=;
	b=DdrWDZdv0Xbbwh43DnnCOm78y0U8oL1xZtBXMjetBNtv/Ttrh2huu5ElmoxIAzxmnhxA
	 IYb9LpLChLLMv+obio8E07GstseOlgRjBmYbmHBl+7kzDvf0j2iR4FfL82J68Xe1KCHbf
	 d44TdQdcrco+3ip4dJUunO992okwXkGMT0Mm3IanjzSYa51kEloLVhBnZqMNUNx3Us/B2
	 bPlCOORJU201+dAxLt4q29lCKwp6U3VWNakTB6Jj7ocLgABia2RJiOexq9/+CmpGStWNq
	 a7xgBJecWNOrLJHtXMoCX5fC/zEJd48BfFLmrlfw74DKwaBpz+DPN7e3X+H/at7jT6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zl9miNAg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B0606A32E
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 12:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 104B0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zl9miNAg
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f269e335eso240182885a.3
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 04:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794574146; cv=none;
        d=google.com; s=arc-20260327;
        b=h/RZneFu0rLirjP/PXAfaWL16TdpL11ta6ftOiCY0b2BLwrU3LK8OQsgaUKB3kaw2U
         6RjPksEBrYlsUnxzbKCm2cWKjsD+wfDnxSeSI9lYp+w+TlxiT0GvDk8Wr2EoLxBSjBr0
         x92nnAGXn4r/w/TGOLhCnOt3n+sF+sZ+KnYxQkANq2uB2EjTYfjLMu4N1hkU7qT2uZrg
         JCMOboQDDzp/NSKSLExaII6m578ikSocIrRVke6wvZ46jxbpT/Na2WAOdq/m33+aYWpD
         CLRx/LppMZrIH7oZ8mpS8lP1FN7rSosU3EiKlEwoy0P71CxnZYXrru0I6VVD68/R2zC4
         Dhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=NwQ8D1EwnOoAfIOU4uGhmCxYyPdinhr/Vhvd57u6TsE=;
        fh=EeVWsAorUQA187hIS6P++o4rjixAmIaibENNl2uaKH8=;
        b=TX5SWUfXT38eyBd1Snv9EOajxQrn1hFWOUbESA8NJiLKBKWyPNN5THlTavyYDXHCqH
         tnrHhkgtMw3hMLGj4JBhCnmiMfzXRdlJNZpNICySYKQ9AQSx3qXfFfnHV0+gKiuXPJ94
         i1YgONmg9B/6V8CaWaouGLB4CAZ8vdO3oVkrIxs1HLJj45mLGpMc/DQpgIGAM9Nnnm+i
         8iF2IDIKcA8My4a/k5uuUobFZvjYKE6vRmCXb6kfo3Wfm5bP/pIifl0B5cLCpVVi5KYk
         ZM2SS9mVUb+qWCSy6LcDyl9W6gCz6apcyeHp2M/EIlFQ1y3sMNUhBBKUlX+VYHBOkjuH
         BF7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574146; x=1795178946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwQ8D1EwnOoAfIOU4uGhmCxYyPdinhr/Vhvd57u6TsE=;
        b=zl9miNAguVxeSGslXYnOwG9yKtPUn6UkC08k9dDoReOHppSFLVUuQ2R7BoOrZEe6LX
         1sfFTFsmV7USlMh3A4D6o4SXifjUhqILOQox/EqdxckMlRbaHQusTShidTUMc1vNpXBR
         +VKrRxyki30nYQGpY/a/eO8YOmOd3+cZyOiLsUSH/7zho2tr3VhVCLkr5AqdU7mDcMeh
         xN+nrZUMNF8s3ByGYjknW5MYxDnozo53lXj3jfD5I6HiTO0sX5PYaCqFWEAIFfEEM/41
         1fErdm7qmL5YsB6L+G5jyrpaJKOyqtPDIXDr6b7HADJBSTMOfHFgDzGw8i0iVVWJxlSt
         YoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574146; x=1795178946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NwQ8D1EwnOoAfIOU4uGhmCxYyPdinhr/Vhvd57u6TsE=;
        b=Q+R8YPOHnBSaQQN+ln7TMOjczKaQ40D9EbIywPVDu930w9Dros3agignOA0DsMJudG
         QepfxExSLwtcMJGFs/eYK3xtecPClKPfZhRt/2d+avj9nGzEeCLCrwGXyt8CGNQ8d88G
         JGWPBHICqDOyiHE0BqZmvJaGWS5cjhovvb45GrHI9SpT27URP1WNJVcR8KETWqkHhyCu
         +CV0CEitXza6n3tSMs2NvbLLZc/LRN39r5uaQJlsb9VYBVsmJ+UBLaZ5dxhNsZfJF+eQ
         25qr4Hp++S0hHjFBqFzpHFy2DsBEgHdHNRg9MRPoLc7hrdy5ebQOLko1G/0sYHONJPkl
         26VQ==
X-Gm-Message-State: APuU4Z9N9t0D5DNsipAxQrcIwmtVFjf4OlZYL00CcOBtIVuRdv698uyE
	MhIJ2+JVSbodmn/2XFob56F09Mcs3YDdvo5Ftz79NYqwTlSDZDEuZZmdAQvvccZKg756uESpKDi
	zy9BPgcLa8PtS2taoSnL8QQAjK8dolsk=
X-Gm-Gg: AYBFou1Pk+SQT0MPwb/spM+PwsgDqRhJnuTobBYq6hkDsfCr2ak57vbF0DIoNM/+8yT
	dfeR+8ZeUo/suewHR4f19y55o+QGKmqHsv3EGn7Usj06gbUOCnifX4UiaY1BRHX/ao9M77qn3jW
	gz0FBvjR1ULqbaIq+K+ILOQZhIAIkL3QcXfosYbucrkJ32S6zEOrGhiC4hXBiKEXXnhNNO7itoq
	u+B/jxtY2ObWscejn7iehamN12G8uo2OmqRXqScUHrAvlQvgRF7Mdo0+18mJNK3s7e5L1lgis1y
	0GO8HqxDE1WHi0Gd1RJ1U9vwftOHZtjPTsYxUPGJh/aroIFvhksccZefliIq/PicBcGKeMEIB/H
	ynzZh0wO4JP79m8dLILv/zaxDTsgjvDix3J9S+UjDIwHoM9wJVj96Bubd7Kq/FPx5HAyJ3evfkh
	kUyBwsoL7uP/1LTwHFZfM=
X-Received: by 2002:a05:620a:439b:b0:93f:35a7:cd4 with SMTP id
 af79cd13be357-9494bc708femr325677985a.67.1794574145807; Fri, 13 Nov 2026
 04:49:05 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Safocl <safocl88@gmail.com>
Date: Fri, 13 Nov 2026 16:48:54 +0400
X-Gm-Features: AclHuK9I0pUXMCZetGIbK0irNjyBy0wsv0ljGeBHbPzBy02IfH-vabpLrKs2rdo
Message-ID: <CAJtzy8+jMbr8nPbehMGRVHa4fQWJ3ma3MeZBHDM6Cm86g2B8tA@mail.gmail.com>
Subject: Re: [PATCH 09/10] sched/preempt: fix duplicate extern declarations
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Safocl <safocl88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Perhaps it=E2=80=99s worth making a change now to ensure some consistency? =
At
your discretion, you could remove such `extern` specifiers for
functions entirely (along with `asmlinkage`), as they are redundant =E2=80=
=94
or, alternatively, remove just one of them.
