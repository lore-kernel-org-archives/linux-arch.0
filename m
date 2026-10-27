Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124245;
	b=veDCx8thY7n9MIomOa8SXIt0uf4n5CYAhCrEcDOF/57PIl3JGE6n3r93IxQKV5WOKIun
	 D9ehYEME+xDSdYA98BBEh+VRutFVXRDX0rfBW59UEdVTLRkke+VkyQxW+wmHXdfi8ze74
	 9KGUq6+dGG/fF2Xf3WaJ2z9t64q3p7CcMCbylWU4T5pwMM2Mp1bN8vJOR7ba/CgMoVnVD
	 TJ999E8vHLUlbihhPRedCwc+ovStPnhaFnpclxwY+1+RwlrJHGzYaua0gDcAttQ/W6gQt
	 0eMsr6alVjWylbYiYu1N4UcV+lg56emBGCTDiFrCm77T6QvFffpR0X2Ble/FldT62Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124245;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
	b=dutsMBf6fAAjshM+yVSe1S9ajXhKQ0Ajmm9vnaGZocs1A0ECwtQgOVws4qzGmEWl9eUY
	 zNmadIwkvKW5yU/SVYEOlPTDGfBhIrQt3h6zOvKcrxotCADJoalRHY/LENK82IqkSlx2p
	 AEx0aeECsTUoVYhL9EHG5mtsa67orn0sKgqLZH3NUQ5wbFHuYmnklpZu4CKCufBQHpbXb
	 V2s4/ROVCa2ov1VXfCh2vXhpzZF+FraLHC6Lvm0AzWkK4o5HDTRQsGk3/fBIYxXQvXVEy
	 sIWifS7Zg04i+NlUjXLCl0EElOFDBvT6OInRTDQezli/zZcKSyyNaALhoVFirfA6vOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F7606A321
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 18:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHhCVQ273755
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CbwQ
	ln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=; b=HWMW+LuCz6utW8S/VyIJ
	rHuo4CHhRhfcBnkgT2it5oCdt4YIlLKc6jaoFTG6NBRm9OQx8/Gj8cgBC4Do0iWk
	mAEHeGX4ZEQrgjmx5BHUqwprw2uw/fxZQF3p+JzRElcb76yXcKt4GQvOnFFzOajv
	msygurYhvvDfEXZY1Y1OFRcS/MQ3DzxL1Zn7WjVKu/boL2iCknUIbvotLMEHVOFn
	8z9EcTAubn7A/+OQElkqnT0CU8euYHGKsuMyJovfBE9MpfZ4akkMjYw62aGpHRD7
	9NYu/mzCxLPH6caGTchbWrsAFJNSQvq09+77FlRkr73QTb2lnAcZCq5a3XUaooGA
	UQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hjqr9ckwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c7bf2d734so1594006d6.3
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793124242; x=1793729042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=MkOva+DPKFBicQaIHSSly2JfoMAicHAbd7jFFZ2jAPfMZSSAxwOfcC3CPShO84ijPq
         ZECGGl73Kz7/09FPj4HtrAatZ8+T45RQt+M4cGZiieC2QJbgruC3B154GGVXb7OAzN+0
         2UhtrH2K//SHtIBzgQwch7+1xSTuSdd3XBXrSOFftUuUdhA49+eAWmetIwHQ/lmQkNU1
         eDgkpiPJIa7m+mdnAJUQCGKhtaBLbGtQoh5/+RjGZf2sev+2X2y5UVI9n1Ip2H0WcVvt
         DLiMDqjdZzodxrWp70M2mYAtjmKnXIkOjZKPebpETepX3BO/HR7B5Mv3SiADMWH9paOp
         KEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124242; x=1793729042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=epJ16DNTDOakXLWiF5l6H048nPghHa9DT+AYuo7zArw4TQWRd2xzZD0g2VZyftisiu
         ciLYt01Pmc/cZQaQ0L57MCq5hl8GIE6V8ZtbXYH43gyTmJBrKhI5d5uiVj2rFqzC3Qi4
         0WRfarYqh+PeplWqh2Vm5wWo/I/eDaDqOpbkOSuVGSSjVfdq+tGajHAguuEwTMks2iSb
         Ya4VhMRIXAdefoqqO8mMWmt3JQg5TfvuN257Fp2ZkpELgHw8RyNmKVgftlLFMnHj4hZN
         5TMC007w57OzcrxEfcW6x9ZELYF6gYtxfnaRO5CFH3WNQNzPpLI0VUG37JKz5tx3WqGY
         ciUg==
X-Forwarded-Encrypted: i=1; AKwUvBy0Wmwip0GwdPn6W/hBIkvIoimR5+jzh4rd/DDE0QbU8Or3sgy/5lm4L+xbjNnEx9aDBo15t6rQBnOz@vger.kernel.org
X-Gm-Message-State: AFq9FYJou+gEarcxF/MVrebSQOVd5T6AgP0ovPjDL2YIaaPniufigVAK
	1Q9AlJWKRmz2cULFwIn0bHeHEeUzeIsvRxePFYVkrf5y4dXF+HZ2rQeQibK+SfuznLI8oh7NV2G
	U6xEEoASXCg2EvfrOQnhPRm1z/dbceLenFPOxMj85yTER3vK9PSykc+qrapA=
X-Gm-Gg: AYBFou39gBNm78a68lQb/W4kGZbosL32fFOHjQoyGd/bMFkkoA1I6rl3yS0ocfcGycX
	UFdCJIbUbPIWZB5YiAiTUm1VjmWrbyMdgt3g+FnTmnVXW/fpHrMW2cSwuhMHBXTKfo01RuHZtUB
	uuj0pnMrTV5CXbBGhKWcCbM7rwuqBVutZptotZsJKdo6B/W8qDatxmeLRtsgPCpmnOUk5tAeixt
	suTKc/84GZ3ISSv8zEHc/HJeRGbR3k01wk+LoO0Xs0xsFjKkiv4XdHvnVYvo7HX/JdBTB+xQm7x
	iJ5QRG8K/etHA+B6OFCjn/WwA95f0xXXZAil93GRgSJUkoKN0eqEydrujk0UMy2S6F09slwE5d9
	kqCr6L5O4d2+8rUjPfXNmz2kN/XvJNgc8vofuzmg/A2UCrqSEHtqDEAThdN8TZ33RJe4NNORDtD
	3ZnXMa3Dp04sTKQFtoSRt6OC17E7SjjVBbE7dwMrrJa9zrxc3+xHy5MDqGt7dqLEbdrljhgEeXR
	A7lUnKr1THaD0A=
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547500985a.82.1793124242423;
        Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547486985a.82.1793124241704;
        Tue, 27 Oct 2026 11:04:01 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a94a5csm1037624685a.41.2026.10.27.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:04:00 -0700 (PDT)
Message-ID: <208738b1-35df-458c-9955-e2e5318fd2c7@columbia.edu>
Date: Tue, 27 Oct 2026 14:03:58 -0400
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
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-cxl@vger.kernel.org, stable@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
 <auCw2-_yjh1_RjiO@cmpxchg.org>
 <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GmQmq4Nt3g_prZ44UQtKNRWO-LNWZbGz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfXxCLG1il0RUSf
 QiNS7vguMT1j3G4QvlBHijOZfsohwzBZh3o7VJKH942f9HHXq7dPCgiuQ0dY95TEfQ3U/glQb2e
 1zBnKP35xCxG/RiJWZFgHC/n44kPTPGQ77l8LlXtVLL0fi3ORk94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX4yyE0UxOs53c
 HWkVGblEBbAnFqY9T2E1xtxNtUpGh/wXsLfmHoqNXszT9RuMgz/PAxUXFj8wPoCcSouDTo+K3i+
 YjFkHfX+yimT8CZ4x6qD9GMx7m5uTomu/Qwex/gFOw6nkDVv2qf3tX/GbBM6Gp1bg0EVFS1goCO
 Q7Y6his7LtXZGQ5PIAwuazjA/Sa9UODihbti/qn5Hpgq39r2YhgOz6xne8P3L4YZU+CNB/Wl820
 iecjuXqPg0cX990dMCRcdtXbmbQ592bEBxja9PHY6smBUUYDfeGMhm7EysDf7Ov+XOpY47dtDzU
 FMJE0nUztDoYsECYtxBKCD4NoMLVr+B62ODLU2Ml1qkcgrpQy+YDrDGdgaUBSUY7pZfPoy4kdFl
 +m2uS3zzWmsPREfs2AQkBdAbWY3OWh/LHPEP73gZKvQUmAkJ4tUYy4r7VhRWoV89MaaeypVJ0+5
 ybA/sCqLp14NVuOnT6Q==
X-Authority-Analysis: v=2.4 cv=PKSaavqC c=1 sm=1 tr=0 ts=6ae0e793 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=pJWPUViXIfCbsMganCcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: GmQmq4Nt3g_prZ44UQtKNRWO-LNWZbGz
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=10 adultscore=0
 bulkscore=10 impostorscore=10 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270071



On 10/27/26 11:15 AM, David Hildenbrand (Arm) wrote:
> While I have your attention: This variant works, a different proposal used
> 
> list_del_init_careful()
> 
> instead. However, that is documented to require list_empty_careful().
> 
> Do you think it's worth looking into?
> 
> 
> https://lore.kernel.org/all/20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu/

In this case the careful variant is fine without
list_empty_careful() since it writes ->prev first
and then ->next with smp_store_release(), and
__list_lru_add() only writes to the entry after it
sees -> next == entry so it can't race with the ->prev
write anymore.

But your version also covers the PG_partially_mapped
race your comment mentions, which mine doesn't, so
it's the more complete fix anyway.

Thanks,
Mani

