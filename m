Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D938E5DA
	for <linux-arch@vger.kernel.org>; Mon, 16 Mar 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656703; cv=none; b=HCbcYiqix/6n0ttACdDcHkX5d0FhW6J3SKx4yVUcUHIgxias7qMmchdFncpwj82cEb+QQH9mbxKL1WUSlF9J4uiyTSqo2oveGByLwzY0lYH+79Ul0kznhstiu+REF+bIxNoJdFiS8s5Cem9kd9OUPOHQ4MmI3QUHAeyjLpw50hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656703; c=relaxed/simple;
	bh=g7i0+Pp9mjDM23vWtwKGrmc2BsZHLrC1Qpwe0Pg4HnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdC7G4pVePZK4pbEtWBthIwK2J+/fjDBjBA5cMgolJkegh6b8Wnuj5oVZxJxgc3PryS55Zi7TrMwzBVEimaDBLR7AjRRJf5YKJPAYyzY7/DMdi8N2tkPbj69Wkei3qEU4Rf+Ug1Zh0iBBifF8lKVa/m2HQ2zrlQe3MqwEPxhg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwuFiIoJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwuFiIoJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso26552775e9.2
        for <linux-arch@vger.kernel.org>; Mon, 16 Mar 2026 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773656700; x=1774261500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76TTQfOSNM1rz7a9CKO2GjO22jbs8CcvWq2eCabFfvY=;
        b=JwuFiIoJJxGpULgpCQclsszbgrE+zMiEpg6IP3hqEL2AkRSWqDuttvEEtcerWb5fW0
         ayJRehUybKL3TjT6tXKwoT1MJZp+uVN6FQw90Vj1zXbPmBOsywnP7cBmSOUgzFhFvvrj
         YSPVs7h4tU4m+Tyy7jw4QsiV14+9xgSzSuoURpkMyin/2a0VW+zLUbaS9XMsY8NEN4T3
         77aDIHJCdpeTaiZDXHzMF9revugRYAfF4SSaWXhYv0Thx7urS4/keQ7rVX6H1O7mtG4M
         XSzd2jzrGeVRGmc/khhGRaDASXVvtX9PBnW/Di7IDAsofy4Ea8lnQd4TD+JfEzUV8fhp
         HhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773656700; x=1774261500;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76TTQfOSNM1rz7a9CKO2GjO22jbs8CcvWq2eCabFfvY=;
        b=lPkx4AI1ZhZJikPHBAZvZesOVgLvKHnwB5eLBfOX3LxyyUAw5l5/8Iq6hqMQvQagWQ
         mw4OVFt0hQtiNrtm3W4ZrGCmh0wHYhd4Kqu3B4TRa/R1FCJS548HL6r6eS7E17L05Ihp
         JtIp3ywAeTsHWm3ZqZYbjHlaWiFS8HzAEP8JOChaAt7nxaMrtLhI7lazho+sS6I0RWXR
         TOBDtP3pYLbAUNHGf5yxfogWo8211U6P4N3e0R6UThGs1VUG6755DhQAzX+I/0UiB3Lp
         HVy3ze9GKrWLQslgDy+c2l0Tm0OXAa4VRxXlu4P8VeP0km94LEZpOIJnSdj7apuTauJl
         88zg==
X-Forwarded-Encrypted: i=1; AJvYcCWie9H8aLN+iyb80tISu98tAr1gVaLzN4JunigZxRrMGvvl4HzvBl9NA6k3xE616iDyRrqHdLevpwYO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xZuHIyCosTRfr9N/bk+P1Cbgq8cn1GBpsgOCeBeWH3hYNI9z
	/ah9v/+nzuVwJwkivLsd9D7sUfBFZS0+4c+83IuJm0co3Tvkj5INzZyDoGKfVBpNvcw=
X-Gm-Gg: ATEYQzyRHsOb+UrAVBOn8qiXEZSELvDSupEpHiMYk6XjQbgIAiEb7wJMveIjSP5cjKF
	msHSThX/rnyaO9NXorRi8wK6L/kkv8RWEno2zH/CizR3U/PFngGpu3RhKqL+ovnAXHJFjXmS9H+
	znjWNEQnRm0X2rFo0pfUJ+sdWatF9pLUQWhrsY31uSK+ukcyNvCUHOURUFPQKt5RIwH0zgv7A0V
	UlB2ZE6AO48WBs3uDfNGzMhx0Q0duTwx4Q4PQkThWIgAWRlvNwopDna5WkEVHNbWYGivCu0flTx
	ep0Ig2cap1pu1njjXh9w1atqtI2ydDtONTYYjj8VMgr/3Cd2nXPa4p/EeC2JnNXYLdeWTkIlJcb
	wQRXqntQ1Gkx0UQCcVAGhT5DvN/1HKV8MjMoCrolO11PDMBj4aDT8gWFxZWZXkMdNpzJjoejofy
	7+8hNkHWphk5AuyJxqSvflA032zpsL1Kc=
X-Received: by 2002:a05:600c:4e4a:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-4855649360amr208565725e9.0.1773656699914;
        Mon, 16 Mar 2026 03:24:59 -0700 (PDT)
Received: from [192.168.0.34] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557777105sm149727875e9.4.2026.03.16.03.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:24:59 -0700 (PDT)
Message-ID: <3af521bd-e03b-4e8c-a972-6b0b1c54e2d9@linaro.org>
Date: Mon, 16 Mar 2026 12:24:55 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] printk: Register information into meminspect
To: John Ogness <john.ogness@linutronix.de>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
References: <20260311-minidump-v2-v2-0-f91cedc6f99e@oss.qualcomm.com>
 <20260311-minidump-v2-v2-20-f91cedc6f99e@oss.qualcomm.com>
 <87pl54f70l.fsf@jogness.linutronix.de>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <87pl54f70l.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 11:39, John Ogness wrote:
> On 2026-03-11, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> wrote:
>> Annotate vital static, dynamic information into meminspect for debugging
>>
>> Static:
>>  - prb_descs
>>  - prb_infos
>>  - prb
>>  - prb_data
>>  - printk_rb_static
>>  - printk_rb_dynamic
> 
> FYI: vmcore also exports the symbol "clear_seq". It is not required if
> you are interested in reading _everything_ in the buffer. But it may be
> interesting if you want to mirror vmcore tool features.

Thank you for your review and suggestion. One of the key points of
meminspect is to be easy to use by the kernel developer. E.g. to be easy
to add another symbol, like `clear_seq` for a particular use case.
So, someone wanting to make use of it, can easily add it.
The purpose of the initial submission would be to have a basic use case
working, and show it as an example for everyone.
If you would like to detail about the features you mention, it could be
interesting to try them and see if it would work with a meminspect dump.

Eugen
> 
>> Dynamic:
>>  - new_descs
>>  - new_infos
>>  - new_log_buf
>>
>> meminspect uses a different API to annotate variables for inspection,
>> and information about these variables is stored in the inspection table.
>>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>> Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

