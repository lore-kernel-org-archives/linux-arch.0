Received: from outbound.st.icloud.com (p-east2-cluster1-host12-snip4-10.eps.apple.com [57.103.76.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8393CD8CD
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647689; cv=none; b=M3eE76U2IWlQlJ9U11XuTR437lFEJwSBRWjJ+1WOhHDCAgxZJabULBG326U2IHaEIVgsIcOMUVimV6LeMsMMLlGAsHBT8q+lkjn3yX+zQCMF1nsm2e3bHBbkTjcR0kPlSY6lpbPOqZmUVI2YC8KTLxvnzgOEB5AIk5WqILbUlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647689; c=relaxed/simple;
	bh=rIlMn8/Rxj7iD6WRx2pdfycUNkmkiai8j7XEAMOPmL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkhabDkX6/QvP1UW89pvUy2L64A6+lgFG5DkdmhfCsKsgwlIsk2EJ0r54ngApyx67HIrCt/GVTJ3NIdpu4jGkXBebcqz1HAgjRdro6QsyrPzKXYjdNxyNOKMtrQwOS0HoVEwt1KOKN0c6zwje9Nv6LAt8XE6fQ8TYyuFTiwPm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fhfPhsOM; arc=none smtp.client-ip=57.103.76.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fhfPhsOM"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id 9803D18002F9;
	Fri, 01 May 2026 15:01:26 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPDFE/cyFjFgoABl0HKQ1JQy17Pnkxezl6QHooA04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777647687; x=1780239687; bh=Nlmz68aV/PBSCqBcK2jC8RwR5m/cZwD40n4u1XMmqfk=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=fhfPhsOMnm5AiPYlmMHq0kQXrghFmhwPK0qhVAbsmF+mGAZDykiYSiekQbqYbqk3rcPk5SKT1dqGwSuLAbToa09580tuj9xGKw1/JqTJqKWubNcncQ4zvOiV6FJuEu3nuswcadLflNkJH5pcxoOg2NNLpZLknMAF1U7jKJdbkoyOXcUaMjoLxejbmlpnabTGQsGJZGDUV95MTAUkUm2q1ma1pXROD9kJoOvBdTSMXvj2MSTVWcFte29Sf1RuFhu9xgsrP4yj052d8VlP++KqFF8EZNJBj05QA8EsNaTuYLJj3atwT+BStKHJ0JvE2kUDCVffmDAdaFvL33aHAcDcbw==
Received: from localhost (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id 5CDD21800299;
	Fri, 01 May 2026 15:01:25 +0000 (UTC)
Date: Fri, 1 May 2026 23:01:21 +0800
From: Luka Bai <lukafocus@icloud.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Kairui Song <kasong@tencent.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, Luka Bai <lukabai@tencent.com>
Subject: Re: [PATCH 5/5] mm: support choosing to do THP COW for anonymous pmd
 entry.
Message-ID: <afTAQZn9m165Y41p@LUKABAI-MC1>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
 <20260501-thp_cow-v1-5-005377483738@tencent.com>
 <c580340a-48c3-4cfa-92bd-593a95d0090f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c580340a-48c3-4cfa-92bd-593a95d0090f@kernel.org>
X-Authority-Info-Out: v=2.4 cv=UfxciaSN c=1 sm=1 tr=0 ts=69f4c047
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=292iOHRO3ARvOjuV3UUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: sr5x0X2KYkUyqD5j_4TciEAxaooc4_F8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE0NiBTYWx0ZWRfX+WW7lkscOdYB
 JRF6gAgqna3aLhnH6+mV5AiOZKSeyayBJCl3a1roR/0V0//vba5klvw6uiNf/Zfw+tpdBUrxw8e
 3je6nzqNWImfzT8RF7UdRauzSloLIvHHaCaQUpGLwdXdvcnMjO9eO5xf48beeDUMD21/d6fJtap
 xY2nIR/01GsVU+nE7OhRQqxDNxl/1YbLeUi1to2hN6Wz4WhndQmO4Z4ipHgstQ2C5RJqrr4fpjs
 RDemQ+/vQxc/0MMWggebofrCF7EKSw9B/OdtJKZaiSDM7BMS/AMNsJ3//K9+h6aQR5oEmp5n2el
 0Ck9gGal0ANQzbT2cfIWvXIx37hxs+N5lOsFqM5h8u0X1PL+CSDIS4g21rGgkI=
X-Proofpoint-GUID: sr5x0X2KYkUyqD5j_4TciEAxaooc4_F8

在 Fri, May 01, 2026 at 09:11:42AM +0200，David Hildenbrand (Arm) 写道：
> 
> > -	/*
> > -	 * See do_wp_page(): we can only reuse the folio exclusively if
> > -	 * there are no additional references. Note that we always drain
> > -	 * the LRU cache immediately after adding a THP.
> > -	 */
> > -	if (folio_ref_count(folio) >
> > -			1 + folio_test_swapcache(folio) * folio_nr_pages(folio))
> > -		goto unlock_fallback;
> >  	if (folio_test_swapcache(folio))
> 
> I don't see why you would want to remove this check, really. Instead of
> "fallback", you might want to try copying the PMD.
> 
> -- 
> Cheers,
> 
> David

Sorry I didn't notice this thread earlier. That is a great suggestion! I can keep
this branch and do the folio copying instead of fallback, that actually helps
to avoid the extra checking about swapcache when the refs is definitely not
suitable for exclusive use. Thanks! :)

Best,
Luka
