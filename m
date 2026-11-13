Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571347;
	b=TaDibK0XtJkNGYAZUJTPHU89cur+dr+4y+CT5KNJNJ+m52jLFeaHzoyluye04RfZ1SXZ
	 lmaMSs7QLzBAMPTD2NCUqr9iYGLeCNDe1oNO8qeubxBzR2sXPwvjj/JRESlM6Xjeb/UYZ
	 ru6T2CsWkmSHFK6nkv20o8UhHev94WqAIsI3KbA5XUKoIdIlmumkCuoTmdDcrZjlkw3Z4
	 gpuLkqwLi3kdNSy1qJNQNlLIOXNunUj6EC90XCyCjLqWh0HGqgcF66ecjqWy5tXJYE2vK
	 kigiuW5KB0Tl7xBAHEdQqQNrmVjV6bmBjKHNrWqYJSiXnNB3EsAMDZEDzfCi43snWSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=ReROmEjIvTuMEmhI0W/IQ2tdzlBhDNd/N1GjYK420G8=;
	b=JoF5vN7Sufi5TYN0boaOr3cX3GuEcCZAa0hUA0T8Fy55ROzgByAFPZuIq/KoVrItcaYF
	 AusxrsFPJ1dHc6Jcqs++Db8CT0AXON+dxDQQjQBk1yOuwljXAMmwufcfU7Q/EPaEw8bVq
	 MfS3CvHMJOXDBUKzt3EjevOOH/3bGJIaB8Lt4XPGkSgDVffHGa6ba5t84VLcySgyof0nm
	 g4fzL4CXgsZt52OlyyYZuwvrfxu/kCWuV3Kbs10yU42dLQ54OpqI2XJSE6IMTH5iTC4y5
	 WSp+fMUqde9BSh1+sNnKDbnlxOzw6AeXOpmN7Ewp3tQU7lgDjvmiLcybmBUtoHIV46A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmswyKOO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B0606B598
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 12:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 672B0606B598
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmswyKOO
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1084645eec.0
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 04:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794571346; cv=none;
        d=google.com; s=arc-20260327;
        b=njjIrE/yx0ebaore7dFpYHOKaMc6A/UesLQ87kjV2oxBNb2yFRHwy35d2wGQZa04pP
         zhVIah83MMW49Htm/wqt2jobvxJKfmDzN7dJK1kfQ0ztyNRC7fboea84ndMeHyoFyK5B
         UB0NdCMmghsHRgrbtHNYiXoGnZtCHHHoqkB0kj5Pe8kM9me565Dmeo834lN9/dfI8PgT
         hgIaaBNsXvqu1IMDRKfVs9Tszc8l2wHDpo7C+10eWTgw4U+lN7zQSoj0xp9+XReCN6mc
         0+Rvvin6/VWoEM9wnfJK+QbzOPJHWdLge8MFYck0iq0UeYB6qcHgaZKfj1JkqFZO06m1
         zSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ReROmEjIvTuMEmhI0W/IQ2tdzlBhDNd/N1GjYK420G8=;
        fh=EeVWsAorUQA187hIS6P++o4rjixAmIaibENNl2uaKH8=;
        b=FZwsx1t0mRBCt6TMokvOzfbGy6z2RScSwklfOuXcrWs7JzgmaNMqFAupB1s6xLKkOZ
         BCtvbkTm+VO6Q/nnfSOyCO9/AoM9DQJucuXgvPZFk8oZm3aeWg1hu5sSXESWmIZjrYZG
         T47+3mnelHdTY+t+pD8OF7fXJ+770zwKjPf7BujFrlh5NgJXRDvjYrAfW6hbTz8nv47g
         feAtgrj852EKOZXWXuXLXe+P8pmUMo66lhSb6SEL3xfYWKh4MQGm56uR+P8gQ6yVRv4y
         e/HW4V+C9CLFfcov2qRoqQ7mQ9GqbUT4ayDwWkq/4jcIoLKBHOdXwOowlgKz7D0dB1/6
         omvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571346; x=1795176146; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ReROmEjIvTuMEmhI0W/IQ2tdzlBhDNd/N1GjYK420G8=;
        b=qmswyKOOSyVkPm7ulMyjrIO0wE1TmCpoFgKLKN2O0NhJHoE1e0jDNQJ0pxf3UeEu59
         XSof9QwGnN92ViafqXF5b2B30azf6CnmT6Z3jSi6mdJ/WgPu+BIM2XPG5uAopwXPRw4p
         0qyNTl3gE28Z6dMzOxZfbYanoUOZyFicv2bZr+iWkf8OYcWfH6ZDoU/JzKZHuS4rKDtM
         s8s9k3Xp7VxFB4l3VLavulBTYBf/sUCRFVlpLnxp0rBcQkxBlniktrSlz2V7gXSZ0YWC
         X640KuFrecW2oJF8fWfHICRW1AbXQGps9gPm1lRlOyTtCNMMZYf3MXvkbipRqeKQN0NO
         ad5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571346; x=1795176146;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ReROmEjIvTuMEmhI0W/IQ2tdzlBhDNd/N1GjYK420G8=;
        b=ddsgOj6Vfrv3A6uGMe1iE6rz0rjr/72bKtogm9GP/ccgLJiiyN6reZt9ymoHlatJpU
         6CCfFf9/tgR65hFCzeG9rxUuy7IzUCWF6CVCQwYdt4XVTrOmw2HHgJ30+T+HlRVZUWAu
         C5RcIkSeD4EUAYDOgschiFX6JCYElbG6kaCJdM1oBQHgRadSYz9nTI5MIVrgCFG6ZtOh
         ZuwlgjJkst5qnCjz+raCM5a/d2JGYIIAeG6Tj0UBV99gsW71+DJEMeuIQNDO8TGkfPZX
         8xMNqStrbgkS9nGdDqC+x/GcK9hZUS6CQQydn2WL4uafXvOx4CAVklwqwiVzjpTNEjps
         BOIg==
X-Gm-Message-State: APuU4Z/wNedLTfRLkFkeFMQDY7vzaa9lo8xJDhSsyAcT34Pira2vzh61
	SHk/p04cFW8bxlP0Nj2p5Eh2/HVrA69ygNWRKGPL7qWeSTFZ5pmN0BZAcMapYEq9tYY95o4WlZC
	c5vdQS+xUzGpNKqPwF9y/A5XEFQsX4Jw=
X-Gm-Gg: AYBFou1323x0hlR2EvY/g3DbRyFXLklf0DN0QjWtQMVdoCOX2k1zhBVtx1WNu3ar9sZ
	gyNSyyO+I1ciTvD420zXxRog0ZMDYC0EiBHVN+fDSdI4V2ayAMttiHrBSv7dYfX7O+6IhWQiKfj
	lejX+VKwEc5S3jhtAQFCqejJXIAocotQiqHhxNnRO9YsSdkNLTwrK/y1LATFVQWMuPS0r1DPjBO
	WkEbLjKgqVuzMlN1k5nx3JQLKXFav/1U1m+SbOczFKBdfJ2ebkJ2BmAh6DRmBlNL3br4lOzn+xz
	C/Hv9A4ChwDKd88ZYIHcf58nljqQe8r0HeitwjuheOEhbgbuDBlXs8cnzyno2lYy8WaQGgRDkGZ
	lYW4fZqTIFbqYd/543uwEO5cAFpEenLUOhN5ODxYWNTc838yKeBIBVWwtxMS1vK+dP8J16SJ37k
	O1si3BI+EJSqDl6oVcquE=
X-Received: by 2002:a05:7301:1506:b0:36d:394d:e690 with SMTP id
 5a478bee46e88-37969089a16mr1901966eec.40.1794571346295; Fri, 13 Nov 2026
 04:02:26 -0800 (PST)
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
Date: Fri, 13 Nov 2026 16:02:13 +0400
X-Gm-Features: AclHuK-I3S_uNRs6XkqtY-AyfnOFIwCa91E2Yj05R8GXzOcZ2SotNe0TIhL9TjA
Message-ID: <CAJtzy8Lj3pZLZUha=5SS4QfLJ-_NzX_BiVM=JS-xAx3XEejVVw@mail.gmail.com>
Subject: Re: [PATCH 09/10] sched/preempt: fix duplicate extern declarations
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Safocl <safocl88@gmail.com>
Content-Type: text/plain; charset="UTF-8"

but it contains `asmlinkage`, which includes `extern "C"` when
`__cplusplus` is defined...
