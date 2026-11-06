Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979564;
	b=TYXENENPGkYoy55K6i+zReqQdimW9z91urX4JrMdYquXxxhOq3GM/FPOtFNywaoSeHwp
	 21mE5VyF3zbt/hub0a2qnMJiKnR+B18a+u59TfvJgTScy2/b6wgpzNLMbqDhSL7n2uR2s
	 YokVDfgqRxS6KxGUeoL2PepZcDtsDySHcDrHkRpKFhS2tv9iAy6c+2Xz51fyPrEivao3W
	 mSZ93LuJ8E9WpdFmt2kBQix4+eCJ7cNIeLgTmez4f4T1iEWQ4Tix5Wyuz6f3C7clMkuUo
	 9TFnHNCsRxu/MCx5JLRAQa5IwGFq42zlXknRucQQm0ZTJ6ntJBcYzSXCrECyi9Kd00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979564;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4tmGxuQStKCk7w+onoi1RLdqwI1kArXig6jzABebmog=;
	b=xETdhQlgjKurVCds3DhGl8AaPyaaOAXFLXFrhoPi/TDLqpMBXhCDPT+EtdJ2QjL31c2W
	 Q74eWQiLB/fiZf2I2fTkK6gis3/+t6P2YYCRbC7cYbunlPtTVxrLvCr9h+UxPD30nDHvu
	 +Kuu/EoM+B0a67u5FG877FujpE3S5coo5siWQ2xRH59wtqqfKesWPTBM1M3kTRfEKdUkT
	 iIYpHdfDBIM38HDBLxpsOuJgFr480aNF4upMg86iVtwy2evXL49cpjc9yYyh6yKwU8Xut
	 sP7MHFM+R/t6ue6CBoeA1IHxvbHDnJ65/ENMWGYUCpp9UM94qn+hAjHoOuFfC//M6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CmzgYoZC;
	arc=none smtp.remote-ip=91.218.175.115
Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E76606A32F
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E76606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CmzgYoZC
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cxp+oaexrpUE0cyElicHmhKBrNrP/fzOSAf3exqA3F4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793979561; v=1; x=1794584361;
 b=CmzgYoZCoSCoPOD8d4J2CNcL+azM+zYCz75PcmISXevWmg5vTMxyEjplZCkCK5TM1Om8yZ6V
 Zbx3Wd/Y4LxkocPiaUzZIXerQYHYqPH79yMQI8F7Y4Qt8r5e7Ub4KBDOVvOGzoyHoXX09hBsmQG
 4dbcIPuXWKdimO8uWiqmyp2U=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be0c1e5625ffc958;
	Fri, 06 Nov 2026 15:39:21 +0000
X-Mizu-Trace-ID: be0c1e5625ffc958
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	hannes@cmpxchg.org,
	songliubraving@fb.com,
	riel@surriel.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	robin.murphy@arm.com,
	steven.sistare@oracle.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] iommufd: fix cleanup when adding memfd folio pins fails
Date: Fri,  6 Nov 2026 23:39:14 +0800
Message-ID: <20261106153914.91168-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
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


On Thu, Nov 05, 2026 at 02:10:13PM +0100, David Hildenbrand (Arm) wrote:
>folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
>folio. Upcoming folio refcount limit checks will make this easier to
>trigger.
>
>Let's fix three problems in the error handling:
>
>1. pfn_reader_release_pins() uses the allocated array size instead of the
>   number of folios returned by memfd_pin_folios(). With large folios,
>   cleanup can unpin uninitialized entries. Remember the number of returned
>   folios and use that during cleanup.
>
>2. pin_memfd_pages() returns on failure without releasing the pins acquired
>   by the current call. Release the per-page pins for folios already
>   expanded into the page array, and the single pins for the remaining
>   folios.
>
>3. pfn_reader_next() returns on failure before updating batch_end_index,
>   even if the batch already contains successfully expanded folios. Update
>   it before propagating the error so cleanup releases those pins as well.
>
>Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
