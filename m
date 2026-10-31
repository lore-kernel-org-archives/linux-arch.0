Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793426349;
	b=5U5uyUoZz6mBMIl/g3lhy8V3HeKaeQJzRh/UMDYATrJ0IFEjSr3E3C5COu1FbcZ5rBdC
	 rGEcJTWTG98r+T+96s828flzNdVhGBf16qrAZbVb5fI/JEYUkJa17G9I3Lrr8jvTj/u7q
	 V8nO6S5KON/Z+49SWI0zdp9cMxfrjYp19OTB++HgBaNy2VIM15suYqUmyGo3EhrBjpyV8
	 PUqk6GI6qW2yl6RkB0Pf4lrCGE6X9PDuPmq3ZEw3r/6TTLhVZ19nF3QAOU2jvZVmcAcAB
	 fZzzQ72+8KjTPpu9orNqDgthvFl1OydW4+FGnh2mBrq+dO2Io3tS1I2XBXvnYfoR/XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426349;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wHHnuTTmSOXbH6E8lHg0GEvp+GQz96PM/IlXLU1wjgs=;
	b=kQRHprRCD9FrfWExSwAOtaSHpm6dMJKmVIdJ0OhV3l4QtOuv7x2XoDwzYburJEXdsGic
	 rA1ZfqjtQdNREGzT/yi5Xp0IbxCQkoFdmnNX2pbYQo8lFjzan1qfzOjKeNEDASA3AezZX
	 Cv9Hb/Wxa9eJHkcjwjvoUK5rzySqumwCVnbxZ7VnGrY7Ngj9k8Sk4tdayORUf7S9ZdU2F
	 m2JW8IaSVh2pPGMugHD0/MwedeMiD6TgM9TmJs72VN+q/veMhtwBeuK8UOgrnnsXMWlN1
	 lj9Hnh4Svq5HVsqACPV/jvTlNsm8jfxj2EU0hLssu2AEqgVBdBmLBzRRtZHtTQYsRiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E174606A31D
	for <linux-arch@vger.kernel.org>; Sat, 31 Oct 2026 05:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E174606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r3xzYw939vN9vzH8UsK6AomPfxJthDwVeWo/3xRQ2Fo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793426343; v=1; x=1794031143;
 b=WvaC4FsDcAHQ2NQ2JuiHYy56AQRK9rpDlaBUPZSd+xgQihu0+x11PWIm4iqwRFyZyy1U2XAd
 No3BIBUDoNW7w/V5YVqDdoRSxK0L8ZNvB0OPSou2EJq8Y5jatu2VQdepv+5F4j7PiwSI/BjV5Zc
 4e5m+WqcgzPmPI8SJmGlTm5c=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 14fc0ff97d323868;
	Sat, 31 Oct 2026 05:59:02 +0000
X-Mizu-Trace-ID: 14fc0ff97d323868
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: muchun.song@linux.dev,
	david@kernel.org,
	kasong@tencent.com,
	ridong.chen@linux.dev,
	baohua@kernel.org,
	sj@kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking PUD and PMD tables
Date: Sat, 31 Oct 2026 13:58:38 +0800
Message-ID: <20261031055838.60138-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
>
>
>> On Oct 31, 2026, at 09:41, Ridong Chen <ridong.chen@linux.dev> wrote:
>> 
>> 
>> 
>> On 10/30/2026 6:21 PM, David Hildenbrand (Arm) wrote:
>>> On 10/30/26 01:20, SJ Park wrote:
>>>> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
>>>> But I can show there are already quite a number of recipients, so I'm just
>>>> noting here.
>>>> 
>>>> - Brian Geffon <bgeffon@google.com>
>>>> - Oleksandr Natalenko <oleksandr@natalenko.name>
>>>> - Steven Barrett <steven@liquorix.net>
>>>> - Yu Zhao <yuzhao@google.com>
>>> The CC list was so long that I limited it to people that area either a reviewer
>>> or a maintainer of code.
>>> MGLRU not having any real maintainer is a big problem; because that maintainer
>>> would know whom to CC.
>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
>> for the maintainer role.
>
>+1
>
>It would be great if they could take this over.

+1 from me too ;)

They both have been really active on MGLRU and doing great work for quite
a while. No doubt they'll continue to do so :D

Cheers, Lance

>Thanks,
>Muchun
>
>> 
>> Both of them have been contributing to MGLRU consistently and
>> substantially. Barry is currently working on improving aging and fixing
>> the swappiness-related issues, and Kairui is driving the MGLRU-FG
>> optimization work.
>> 
>> They have also been active in reviewing MGLRU patches, and their review
>> comments are usually to the point and helpful. They have been looking
>> after this code well, so I think they would be a good fit as
>> maintainers.
>> 
>> -- 
>> Best regards
>> Ridong
>> 
>
>
