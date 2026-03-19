Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE03A0EAB
	for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905642; cv=none; b=kYY4vSm7INI1we1rSP7RSYbpG7U8ME29VTV+Dy1w2dmteKNuqfedQiZv/pjm7xpxr+m7QrA3LQbhEPOL4SgOWw9yFnsPXp6q8liGnZ+dyTRSaTgiNH7Em2a7SaF9J1yLtcMIMlLmprYKfNryxFdpo1/XtM+qPNtzzuMAC9QILi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905642; c=relaxed/simple;
	bh=AhNDDZecnmD2xFm+TNWATlQbxsUvN8KlFepA01COIwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j251cJEAbPnRRIdctZSplN8NkcEIplWdlxmDwL2qkg9yMrHWWFt5jqZgIw5pktRPoRO+kAT3NrkhsuEYC4eJeWcIpKR8dryFEnnBzKs/MNkihrd9N+GOcmB0me7GeXGcPycoWLADsvMSn1UmcGMvTFEeWCCNvKnuqQviPi6cK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IvOkIInU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvOkIInU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4915161fso516895f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773905637; x=1774510437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfnoZII81lwHDQG+q8k3CqLmv9bwI5/ooG/r2BOJypo=;
        b=IvOkIInU/YzZLqaHZgSxaRamre1CKdkvdI70PFUfeH49IfziLVMMlBx8JBwXExRU+I
         gVRhh17h9JfspgTMMC/rrvpb6csmLx8UMmMITDH5bpFdSylsCAMhN1Lb8AzT8GzNRKmr
         N+tZrhu9OWY5JmnPNsVUJjwjoIu07UIG/l/+kGr0XiojwstpSLa9eE3RBkwl3qeFJmxu
         t0lzdAmp1R867dvF3FnUE6WLp2dQXwUnWLam6WCwjp8wJ6DKtsj1brcR/9puwlQMk37V
         sffUCzBXmHbcM6FgB8e0rvmV9AhfAia6M6odtwKzHbGlQfiiTnQpney5fyj3ZKr3Mj/L
         UTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773905637; x=1774510437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfnoZII81lwHDQG+q8k3CqLmv9bwI5/ooG/r2BOJypo=;
        b=QboIrFmgw3P4F56dY++lQNUxZ8I4pFP8zmhj7DS+jxoPYodsjt/r7UD9mR5K6ZVS4t
         M2J+UdP97WTdGPuTZWcWrvY2VAcp9eGHK/5iQcCZQspJ9PSan10ts75QvQ0fHXDoK6sF
         yOOSWfJbb4znEjM5DwtWKSOwYWhaIUoj6MzLFGOceMegLQnxSnaa5ijDMM/R/90yBbwd
         /EQBqxb32qSv/woRLMZPXmACp3/q8GCry0d9wOwm/GgvGsTk1CrkbKpPWOMwKDkaNiVl
         mGxbLut2S8AZoay+KmqyDDc7XjvP4tHESsYMHrrC8EzvptqLyMdFn3SMmy1y8eoAj1DY
         LYKw==
X-Forwarded-Encrypted: i=1; AJvYcCWGjoZJsK43+LNLMXJ04nfk3VMH7/TULb9UdVjZJFuV6xJLOUmgBIxFf1FB2W9Pd/VULvAl+uyWgLsq@vger.kernel.org
X-Gm-Message-State: AOJu0YxjiZikm8pqFC6tKvJ+8UgB9pZEqv8u2ikXIcJt0jl3l/9RJGwf
	HPysoNuWuGIWV82LlQ6ZO6BMio1ftl55Qv3R9jYVd/bARs7hUNd66d4yxG7olmBqfZw=
X-Gm-Gg: ATEYQzwLQY3E4UpHEZsuurUTd2f4r0cCNQga6DlaP4Q58AI0++IMHeV0Ttj6eWOEavZ
	VhqW2SuXBQoezzeOBmroDwSAIkr1X8D41WRACYSsnQFwyTzn8ICRtaSm6SDcJIqJuizZOwwPuRI
	A7SfX5xlzUZWipg19yTpv+Q3PMeBpcvIwPHgfPlLPsIkbsdst9Iqk7N4PFvzZWn5+cSvId4ciE3
	/bQL1EzO6mHMNXFanONO7pUDvPINotU2AfbIw2xbUj/G6iaMnIRibWBPBvlRUKhhsZNlCqjNMAN
	ynNzoRBGp2OR25o+b3e4Wr0hmnmsk8KqpORDFoOMCq8StguszDLEmXPq8GDCopTM23WbSBbrRR8
	MfzuU6vB273qfIJauH/1LGFz4otre2GlJgHnWnR5eZrBvCfHCCHXFuy5j64wyjJEIA4o16ryEte
	aO5SJQASyve8z1ZskGIHaqQttHknmf+qA=
X-Received: by 2002:a05:6000:25c6:b0:43b:4ae5:d7c8 with SMTP id ffacd0b85a97d-43b527a50cfmr10368836f8f.2.1773905636943;
        Thu, 19 Mar 2026 00:33:56 -0700 (PDT)
Received: from [192.168.0.34] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51899622sm15875212f8f.28.2026.03.19.00.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 00:33:56 -0700 (PDT)
Message-ID: <46c47101-2672-4970-a212-71e2c8555d80@linaro.org>
Date: Thu, 19 Mar 2026 09:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] Introduce meminspect
To: Bjorn Andersson <andersson@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
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
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
References: <20260311-minidump-v2-v2-0-f91cedc6f99e@oss.qualcomm.com>
 <abdnp90cC5PI9wyz@baldur>
 <20260316181647.m7x4ncmwdjho6yvr@hu-mojha-hyd.qualcomm.com>
 <abtlUQqMOxj5PwGB@baldur>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <abtlUQqMOxj5PwGB@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/19/26 04:55, Bjorn Andersson wrote:
> On Mon, Mar 16, 2026 at 11:46:47PM +0530, Mukesh Ojha wrote:
>> On Sun, Mar 15, 2026 at 09:24:39PM -0500, Bjorn Andersson wrote:
>>> On Wed, Mar 11, 2026 at 01:45:44AM +0530, Mukesh Ojha wrote:
> [..]
>>>> , to get all the regions as
>>>> separate files.  The tool from the host computer will list the regions
>>>> in the order they were downloaded.
>>>>
>>>> Once you have all the files simply use `cat` to put them all together,
>>>> in the order of the indexes.  For my kernel config and setup, here is my
>>>> cat command : (you can use a script or something, I haven't done that so
>>>> far):
>>>
>>> So these need to be sorted in numerical order, by that number at the end
>>> of the file name?
>>>
>>> Do you manually punch these in? How do we make this user friendly?
>>
>> Yes, manually.. but I think we can do better. We could make
>> this more user‑friendly by using the section header and string table in
>> the md_KELF binary both of which existed in the earlier implementation.
>> Then, we can write an upstream‑friendly script that reads this KELF
>> metadata file, checks whether a binary with the registered name is
>> present, and stitches everything together to form a complete ELF that
>> the crash tool can consume.  Let me know if you have any suggestion..
>>
> 
> Can we somehow identify that these regions belong to the minidump and
> teach QDL to build the ELF for us?

We could integrate the feature that Mukesh suggests directly into QDL as
a separate command
e.g. qdl download-and-build-minidump

The first region (the ELF header) is mandatory, because all the regions
themselves contain only data. To be able to use any of the regions, one
needs to know at least the physical and virtual address of that memory.
And this information is saved in the ELF header.
So QDL could join together all the regions into a single crashdump-like
file.

> 
> Regards,
> Bjorn

