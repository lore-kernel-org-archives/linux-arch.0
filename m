Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304783;
	b=4Y2dcvShDPBqP0a5e1USdQ+pJ/E0pqVoD3oIadxVmNQEswiNjb+fQ/voDtTweVHw4Irn
	 z2PK/icVJlf2W4LTtMsvSsY9HId3KUxOIz0AzHORgNaJa8wPuLtujDxzz7bjqUphfvDUA
	 kdrj1x3CGsNJ+jm04buWvKKhv2DOfo+h0QvMiNfCHwK55EeqpT7k4jE+5u1ZJbFa4gPyW
	 zj4RJz9QM1GslNPlj0fAdNujCRD++5rpPUXsTfMbALLUkadBBW2E/10sZZD/l9NDWz91U
	 ZRqF+7eHjd+Rf7qKo6qmsebvlBDzQc2fzmvKyS/JAsbMsy9qwduQ1L9ao5HW8Q9sbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304783;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
	b=YWuwp20gqOVFA11SZtOApY9zEy2Wwgz6haghJ8KNW+/BKQgX85uvaYAI6tQnc7S3n39A
	 Q6rARglVguahouCGoUMzf3gyTyLtWlzqTnoUCyppIoiEs0mG1KD+PhHoOGgtTanEk/hj8
	 uP6X5hGKzj2wnHuil3z37G2pfv8tukP4ASv9bnM0TsYx2a3mmdvnrzumMe7xtjcYwG6IV
	 h5aP0by6yLRv9WgljMhaFngzWcwVB75rr87ra8TLVjGGz4oz/w+zRQA02ES6fp+uiDXN5
	 v6hlBzUVJrJ7YRDx3nJjGo9oiyRQ/s5hzTA9B+DW+pV41VU0HrH4BoI8OGhrk3ozCdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sr8AcXcQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sPqnSeoi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BBD606A337
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 09:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BBD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sr8AcXcQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sPqnSeoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794304782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
	b=Sr8AcXcQs/idA572AS4kHK5mkBfqbzDUhsVXooXETEkLQUhNdhAjrrhn1qTbuC+1RLV99Y
	3t9yLwAtfBq1GB52cSdNh84FMArl5mXWzx0Qsvx8gDze9t56Fu08T5o0AUqJnET7cvToqF
	KOJIb4WneTE/JXNiB/eY8Nt9kDXrIBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-BU459HMiNrq2y-6oqvez-Q-1; Tue, 10 Nov 2026 04:59:41 -0500
X-MC-Unique: BU459HMiNrq2y-6oqvez-Q-1
X-Mimecast-MFC-AGG-ID: BU459HMiNrq2y-6oqvez-Q_1794304780
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so17729645e9.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794304780; x=1794909580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
        b=sPqnSeoi4vhi9k/Qk8upVc9av02O7XT2MLDS0rt0xhyMHyAOJTROqdLihjJ+H2zx6n
         frm0rtCZ2oIBy/C6ZHHpV2ob4KNI+PdWmcdWFh82/mVEmIN3CPH8Q+HhXpLubBaC4oBt
         oGJ0Ur1aYmxQqQpLEJGwhdWDUj/iJ0tP6tYm0BglzC+ZKE5E3qnCOP5O6zxLAIRdmmkG
         HN75xD4GDthIjKj6G45ZFnBSqwTeabEWIumblhGmjUKx8YhN7a73AxdkDrxW2XrP/ZZ3
         fGc6IR5e8EIgEe+03M1/3pUnLm2t/25VcRxYCteAYP1w1vIESf+zMfBEeEOHgzMLAp6v
         3gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304780; x=1794909580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
        b=WD1uk4iQeYZ+TELnAEoRs+I7xOYG+6zYF7E8ria5qAdJ1KORnaVT5krvHppwyxagFj
         msPdbinmUgyzbX+H/0lk6BygD4JmHMC1q97eUWP+rbauuy9ssirJHgWyvB/+JXaGX3kd
         0hEGPIiCDRvKCgtug5Z2W+S1lHniEbDwqiS1AS2X3KFb1bZUorll++6gFNEHAX25EmfP
         5DYVhNSVG/TfTZxx0v/lnI3C2xgrb/b1TUlYw/p15eEB0Iwxla2be4WJ+dxWs6QaH7nA
         +x9vGoQAD0hh/HKR5mGgGwjHshEhAom3QdU2y4YGnlElFjhA05BqlJHPn0JqcwhLmuIp
         JBTQ==
X-Forwarded-Encrypted: i=1; AL+hErFisnlpHIErRr/xm2cFkrg58tU20GxiohJbvF8ONI2Gkij1qleiibEdjeqlW/R0vAAEe5HcDrlw2fcs@vger.kernel.org
X-Gm-Message-State: APuU4Z/3LY0LdZLV94fsriBEvnVZoZbsR5RaORITZK1lP0chwqwoJSav
	+GZxy3dFsufUYenwTBKhhFwmfqTQQ1Z9635wh2MvJJ2XJ5QdbZwZe6TNIyBOj3diEd2wcMk07HC
	KYO7eGwEdm7v6rimksQ1e4n8Sc3k07ORwB1Fuoq/iIwjcXsF0IJBd6jLqdky/LFM=
X-Gm-Gg: AYBFou2lrW3FEZgfvD/FC9U6/G7C9RccWs9SgXlrv0jQ4pJu3s/q7BkYv3NFzbgzwiA
	6sPGWQCRorsy6eRA0N3rClS7L+PhqpDorFnEYdn/R6VoJwesxLzIbCgcUSvN8WZ50u43XBFS/DG
	HB51OtYWZ7ZRqm+vuv0LKwwNPZRxu9O5rW0UW7U19sDwv8/7JdtQ0MMaxRt8HrsUa4DgbbdJUQN
	jPsC708S54arQMK0e3fuv4pkFjaAh/91ZKwMIOEnQK/Z3s8SYKSBWoJ9GbrLPyr1qudkbiyyp36
	SpYRg9IOMdtcS6xOBTHX4Mt7y48PZ0tqvanJWF9/0CG3hKxxp7y7pg+rcJKk3g2pEbDATKgoep7
	jbC2bZM7ZVpCcVtE1obenx+MFQGZ0HQv6Yu3jOHf7fls1LOD/BCIJQFYC4xvptYhq5SKbPysTVZ
	ZECVUdFFYcSJglGdvTr2sW2b4X/S94YSLy2/fFb5jQZiSw
X-Received: by 2002:a05:600c:4e0d:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba0234ee12mr34932645e9.14.1794304779703;
        Tue, 10 Nov 2026 01:59:39 -0800 (PST)
X-Received: by 2002:a05:600c:4e0d:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba0234ee12mr34932105e9.14.1794304779321;
        Tue, 10 Nov 2026 01:59:39 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022fbf75sm44329265e9.0.2026.11.10.01.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:59:38 -0800 (PST)
Message-ID: <c3e7afde-65ac-48e2-a89b-9fc1ad42aa87@redhat.com>
Date: Tue, 10 Nov 2026 10:59:36 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: add SO_PASSCRED_THREAD to get a
 thread-specific SCM_CREDENTIALS
To: Andrew Halaney <andrew@amutable.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
 <20261102-halaney-scm-creds-thread-v1-2-0b4d75dbf35f@amutable.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102-halaney-scm-creds-thread-v1-2-0b4d75dbf35f@amutable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 00:12, Andrew Halaney wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7405be8941f..6b443bd44581 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1586,6 +1586,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>   			ret = -EOPNOTSUPP;
>   		break;
>   
> +	case SO_PASSCRED_THREAD:
> +		if (sk_is_unix(sk))
> +			sk->sk_scm_credentials_thread = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;

AF_UNIX supports custom setsockopt since commit
de1c489b57c11fabc766aeb6777ed5b0038fa3bb

I think it would be better to move add the af unix specific ones
into net/unix/af_unix.c.

But that is IMHO more suited for a follow-up; the series LGTM,
thanks.

Paolo

