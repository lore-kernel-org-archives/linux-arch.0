Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C634B438
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061041; cv=none; b=ZFyu9uYGTwnLFgNTZbURZB/l14GFCsy9sYB/6mlNNmM7Oy+xyfBdNG0nN41lqQizDHOOVa9NUKnpEMc4U3pWLBZa3U68XgI3n1BvVymXxz2lT/nY1Bei9GbiX9sgoJkvblg0KMlb0sA2ncT9q66YNRT5mR3J1rg6SxNb+0T9iHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061041; c=relaxed/simple;
	bh=bhwojWNOT7gZ93oXwkOllBjanSFwmgfsTYSBLERvY2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+KnoCSe7Z0faFKPHOW/FWWk7yhwpKue2Y8njbACe7rz1MW1CC9rTDp0ohdu4tTIgJuTJZ10Orbbv1SkfMiC5QQZ89cM18EKufBuUK2xSvFl57FSvxSrQ07zwrUSaqFVvF5l0agZwuipKBvcr4tsgBM0YsW0+W762MJr/FCTJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PUmPo52b; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PUmPo52b"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777061037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gm9Vc9zCNOE3P/GhlVsvS6tFwN/kYtHjyT1Zy2zlkMY=;
	b=PUmPo52bP6GIdc3Tj/NyeQSPGZeASWCb676HK4WXkQSumqGrBWHkmUhZlVe5P8x4a9eNHx
	CtLEeBySRLbPG3w+MZ6QN+EHrswAmxH3Ly3l9w71PMs7OToMEATUPzY5gcEH0cbU3HX9Qv
	XKC1HNDXJguPEYb4A6ikM4nNvQYZBKM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>,  Yosry Ahmed <yosry@kernel.org>,  "David
 Hildenbrand (Arm)" <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Lance Yang <lance.yang@linux.dev>,  dave.hansen@intel.com,
  dave.hansen@linux.intel.com,  ypodemsk@redhat.com,  hughd@google.com,
  will@kernel.org,  aneesh.kumar@kernel.org,  npiggin@gmail.com,
  tglx@linutronix.de,  mingo@redhat.com,  bp@alien8.de,  x86@kernel.org,
  hpa@zytor.com,  arnd@arndb.de,  ljs@kernel.org,
  baolin.wang@linux.alibaba.com,  Liam.Howlett@oracle.com,
  npache@redhat.com,  ryan.roberts@arm.com,  dev.jain@arm.com,
  baohua@kernel.org,  shy828301@gmail.com,  riel@surriel.com,
  jannh@google.com,  jgross@suse.com,  seanjc@google.com,
  pbonzini@redhat.com,  boris.ostrovsky@oracle.com,
  virtualization@lists.linux.dev,  kvm@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush
 sent them
In-Reply-To: <20260424193529.GA3853824@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Fri, 24 Apr 2026 21:35:29 +0200")
References: <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
	<aetw4aoABYj3keMh@plex>
	<20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
	<80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
	<20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
	<644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
	<CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
	<20260424190141.GA3783056@noisy.programming.kicks-ass.net>
	<E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
	<20260424192250.GC3783056@noisy.programming.kicks-ass.net>
	<20260424193529.GA3853824@noisy.programming.kicks-ass.net>
Date: Fri, 24 Apr 2026 20:03:14 +0000
Message-ID: <7ia45x5gktx9.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Apr 24, 2026 at 09:22:51PM +0200, Peter Zijlstra wrote:
>
>>     mdir = mailbox.Maildir('~/Maildir/');
>> 
>>     for i, r in enumerate(reviews):
>>         inline = r.get('inline_review', '') or ''
>>         if not inline:
>>             continue
>> 
>>         author_name = r.get('author_name', 'Sashiko Reviewer')
>>         author_email = r.get('author_email', 'noreply@sashiko.dev')
>> 
>>         msgid = msgids[r['patch_id']]
>>         subject = subjects[r['patch_id']]
>> 
>>         # Create the Email object
>>         msg = EmailMessage()
>>         msg['Subject'] = f"Re: {subject}"
>>         msg['From'] = f"{author_name} <{author_email}>"
>>         msg['To'] = "peterz@infradead.org"
>>         msg['Date'] = formatdate(localtime=True)
>> 
>>         # The critical threading headers
>>         msg['Message-ID'] = f"<review-{i}-{msgid}>"
>>         msg['References'] = f"<{msgid}>"
>>         msg['In-Reply-To'] = f"<{msgid}>"
>> 
>>         msg.set_content(inline)
>> 
>>         mdir.add(msg)
>> 
>>     mdir.flush()
>
> So Ideally I would have 'Reply-to' header set to the original sender and
> added 'Cc' like the original email. However, AFAICT the JSON does not
> contain this information, and while I could use the mdir object to find
> the original message in my Inbox, this is incredibly slow.
>
> I have a TODO to use python-notmuch to do this, but haven't gotten
> around to doing this yet.
>
> With that 'fixed' I could actually reply to these messages and it would
> all 'just' work. For now I copy/paste when needed.

I can add an api to return a json with the review and all
meta-information by the original msgid, will it be useful?
