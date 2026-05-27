Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7D2571C7
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843148; cv=none; b=aWA126zOe5475sKbOJvLjd9Lxg8nymlgKbQJpg+9SqeVGztTlr3aDvOEtRpZHPb0PiHo6c4RIbtb1ffX2hF3mH09ANCxF1JFxKfCTf1KJUHvRBcPv9p1NUqIGHT1C1SYOL8BsBLvk6UAUT7IF+iIEHNsv0XpwIuOPiaME9dxqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843148; c=relaxed/simple;
	bh=zc8JK8kY0FzANOG92YOs1rUkawQNgVa2cqbZvNxKKco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MI6iDsw1TurYnBIrhmCsmy4yJ8ObxFyXGse2qtjgrCEKdFt2YzTfLpIH7fNsO1xo/hJQZ//kmyoJQ+ItcvFlVUn5HNhY4NscGBTOa7rjD8IN99M2sWBxbr6uujba8QdDL4TX04SyXOpjAV5sU89XJAFycU+Hf4hI6o8+mfhv5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1UDz/q2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1UDz/q2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779843144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a42vrjuDLZ1rTnqCliOlI2rREOenUYXLtGEdqs5FFfg=;
	b=K1UDz/q2opREK1HlZDPjkL3Z+XwcjT9zXmPk/jOvnGBOINKQdRYU8LJc8hmTCWPQCZWDEp
	yyFblRLIofGAA1J5IT+h4lyXxYJjx8Pm7ci/ElJkMb12fKMYOPtGYxyn3Q4xDf60eFZlvH
	R/xl6MWTdm7jXn7/q14COGr+3GaI6UI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-GJclz02VP2ejMngd1-N2Eg-1; Tue,
 26 May 2026 20:52:20 -0400
X-MC-Unique: GJclz02VP2ejMngd1-N2Eg-1
X-Mimecast-MFC-AGG-ID: GJclz02VP2ejMngd1-N2Eg_1779843139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15F6C1800614;
	Wed, 27 May 2026 00:52:19 +0000 (UTC)
Received: from [10.22.65.22] (unknown [10.22.65.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67DFA180034E;
	Wed, 27 May 2026 00:52:17 +0000 (UTC)
Message-ID: <4b505d21-7a03-47d2-9188-027aab354439@redhat.com>
Date: Tue, 26 May 2026 20:52:16 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/qspinlock: Clarify pending field layout
To: "WEI-HONG, YE" <1234567weewee457@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cheng-Han Wu <hank20010209@gmail.com>
References: <20260525130450.723937-1-1234567weewee457@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260525130450.723937-1-1234567weewee457@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 5/25/26 9:04 AM, WEI-HONG, YE wrote:
> For CONFIG_NR_CPUS < 16K, _Q_PENDING_BITS is 8 and the pending
> field occupies bits 8-15 of the lock word. The current comment
> documents bit 8 as pending and bits 9-15 as unused, which describes
> the pending flag value rather than the field layout.
>
> Describe bits 8-15 as the pending byte so the layout description
> is consistent with the lock byte.
>
> Signed-off-by: WEI-HONG, YE <1234567weewee457@gmail.com>
> ---
>   include/asm-generic/qspinlock_types.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
> index 2fd1fb89ec36..7d17b9bb069c 100644
> --- a/include/asm-generic/qspinlock_types.h
> +++ b/include/asm-generic/qspinlock_types.h
> @@ -53,8 +53,7 @@ typedef struct qspinlock {
>    *
>    * When NR_CPUS < 16K
>    *  0- 7: locked byte
> - *     8: pending
> - *  9-15: not used
> + *  8-15: pending byte
>    * 16-17: tail index
>    * 18-31: tail cpu (+1)
>    *

Yes, we forgot to update the comment accordingly.

Acked-by: Waiman Long <longman@redhat.com>

