Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B036826F;
	Mon,  2 Feb 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039451; cv=none; b=PEATGzQ2rlZp7SlB85qXHN4cbAZbG339nOjFwFEyIuovXm/gDbG4WTNX8kqG8Y7x/WbJ3/QPxsRsiPgP81E+7A9Tms+KXZMGTEuic0GRY7pJaMYTzNWCpkCZhx36Ztg7ta2b+1e9FcjpqQgO5djnH6S7eg38vO9FzcXMrfHysWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039451; c=relaxed/simple;
	bh=QbEFKaB8SlDrYmmFsM+hp18WwEQLa60Z6bmnYCE/AQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k15GakTlt17HuiYEZZHetQH6/7JYh/TramO0haN8bBuVaAOW/y5imE7pC09d6EtUzPOowF11ahOPqQriWjZ4uwhVfnxiftUAfmshMgUPKE8HpSVqp152w8iqN5ZSM3gJadhquFzOoNIxRM9s2ZYICIYxbGadAOxUPzA7klzg8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZiKWp/m1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZiKWp/m1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t61KUNmsZghpo+fJJU80H5pumxWKhCMO8GKrlURQ4wQ=; b=ZiKWp/m1VUvheQfpZBsJlo+xqX
	MvTJAzi4Wgg4L+g/2Wqe7Zabjpx9F1XuPmiJQA4YR9Fn3U/nPUD2+16RTy6zqY739JBzsH3b/HLWI
	TSI9WIELkDa5xuTV3hdpEDssUMC/1nuE4sVpX9+pK5mkB1bDwePeeGJtEpUi16k1lWB+MyLVWAWmc
	dEMuNlE6e/CC33uCK3Gk2hWNT0Re92/ST4NKKE3wek1XG0lmFxYGKoDyZGa+sGv3vTa61jzhzsYca
	ArGL5D9+g8/U98MgGhfQ2Kh8Vuy+WPOUJCZRcVw7NZLN08Yj2iOgeMYG/IfzjSd9AFZG+dT9tHjDC
	5TjBMpbg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmu77-0000000GYC9-2S0m;
	Mon, 02 Feb 2026 13:37:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 22BE63008E2; Mon, 02 Feb 2026 14:37:13 +0100 (CET)
Date: Mon, 2 Feb 2026 14:37:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, arnd@arndb.de, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, boris.ostrovsky@oracle.com,
	bp@alien8.de, dave.hansen@intel.com, dave.hansen@linux.intel.com,
	david@kernel.org, dev.jain@arm.com, hpa@zytor.com, hughd@google.com,
	ioworker0@gmail.com, jannh@google.com, jgross@suse.com,
	kvm@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mingo@redhat.com, npache@redhat.com,
	npiggin@gmail.com, pbonzini@redhat.com, riel@surriel.com,
	ryan.roberts@arm.com, seanjc@google.com, shy828301@gmail.com,
	tglx@linutronix.de, virtualization@lists.linux.dev, will@kernel.org,
	x86@kernel.org, ypodemsk@redhat.com, ziy@nvidia.com
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Message-ID: <20260202133713.GF1395266@noisy.programming.kicks-ass.net>
References: <20260202095414.GE2995752@noisy.programming.kicks-ass.net>
 <20260202110329.74397-1-lance.yang@linux.dev>
 <20260202125030.GB1395266@noisy.programming.kicks-ass.net>
 <c6fda7c2-ad54-416a-a869-1499c97c7bd7@linux.dev>
 <4700e7ba-8456-4a93-9e28-7e5a3ca2a1be@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4700e7ba-8456-4a93-9e28-7e5a3ca2a1be@linux.dev>

On Mon, Feb 02, 2026 at 09:07:10PM +0800, Lance Yang wrote:

> > > Right, but if we can use full RCU for PT_RECLAIM, why can't we do so
> > > unconditionally and not add overhead?
> > 
> > The sync (IPI) is mainly needed for unshare (e.g. hugetlb) and collapse
> > (khugepaged) paths, regardless of whether table free uses RCU, IIUC.
> 
> In addition: We need the sync when we modify page tables (e.g. unshare,
> collapse), not only when we free them. RCU can defer freeing but does
> not prevent lockless walkers from seeing concurrent in-place
> modifications, so we need the IPI to synchronize with those walkers
> first.

Currently PT_RECLAIM=y has no IPI; are you saying that is broken? If
not, then why do we need this at all?
