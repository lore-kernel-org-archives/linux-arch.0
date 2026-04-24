Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4636D9F5;
	Fri, 24 Apr 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059345; cv=none; b=T30t2TzkeElZfMf6m0LrdGLXrGGAeTSJTGQMt1Qyd+yXr9jpAUDMiDJRJYRfiLketptuA0cPVmwfSL5fP/KK3J/UUTxK3xzYIMKhmo4qYvtMwF3zC2quw6FoSatLI2yYer4bn0XTogm3XABobUMb/wwrJmYc8k4c3ZMLoXPLjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059345; c=relaxed/simple;
	bh=qTBZ+eIMF2wJiZVzdNzeHLi3B8j+sp9MfsXdYYNqeys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adq0MlcmcToHI7ZChvOB/ExG2jYdNTB9eElSFuynAraxM7xWN6uCToEaTRHMUC5CvtivOChYmnKUzb6HSEo2dtndlYj/zd6RU/U9nEASKaTpSD/7Y62X2wWnx3xGD9dmI89hNElsPmTOp31O4lxmVVgSmozjPNtTLQzQJsjEkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dLRk3Exc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLRk3Exc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XdkH1kke8xKNHhewDP/J3YySwRvCbjXWp0T4uztq+es=; b=dLRk3ExcR3bJdP3rx8RDX2VDn+
	XXZVHvWmgCd7fo/OIGaJC63rzZiZIz2LpR47O5RLmEJzgdJs7Bo/5H1POeKA7czocmGPzuTyuI26v
	6g3xKivFhtkRJJJnZb3SBZ3k0jTcevV+iuI+a66hVCa8UphNH/U2PpNiRSKWONOMvFurwnOcZR/F+
	1KCteXs6F5aLAQZFcodjh5JGIh3uoaNNfiYci4x02r6w/pg+dBuMNZoewQyvAorQ+puyBEuFT33Fl
	W9qQ8PjQEVS6lQ1ng7yqkVdECou37wa5YEtpbc9+ovZvy11plaEo3qbSSvg9nqqUxLm0tRfv+/SVt
	b0IJTefQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGMJG-0000000FhuN-2hyR;
	Fri, 24 Apr 2026 19:35:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 47CCF301142; Fri, 24 Apr 2026 21:35:29 +0200 (CEST)
Date: Fri, 24 Apr 2026 21:35:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Yosry Ahmed <yosry@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lance Yang <lance.yang@linux.dev>, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
	jannh@google.com, jgross@suse.com, seanjc@google.com,
	pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <20260424193529.GA3853824@noisy.programming.kicks-ass.net>
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
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424192250.GC3783056@noisy.programming.kicks-ass.net>

On Fri, Apr 24, 2026 at 09:22:51PM +0200, Peter Zijlstra wrote:

>     mdir = mailbox.Maildir('~/Maildir/');
> 
>     for i, r in enumerate(reviews):
>         inline = r.get('inline_review', '') or ''
>         if not inline:
>             continue
> 
>         author_name = r.get('author_name', 'Sashiko Reviewer')
>         author_email = r.get('author_email', 'noreply@sashiko.dev')
> 
>         msgid = msgids[r['patch_id']]
>         subject = subjects[r['patch_id']]
> 
>         # Create the Email object
>         msg = EmailMessage()
>         msg['Subject'] = f"Re: {subject}"
>         msg['From'] = f"{author_name} <{author_email}>"
>         msg['To'] = "peterz@infradead.org"
>         msg['Date'] = formatdate(localtime=True)
> 
>         # The critical threading headers
>         msg['Message-ID'] = f"<review-{i}-{msgid}>"
>         msg['References'] = f"<{msgid}>"
>         msg['In-Reply-To'] = f"<{msgid}>"
> 
>         msg.set_content(inline)
> 
>         mdir.add(msg)
> 
>     mdir.flush()

So Ideally I would have 'Reply-to' header set to the original sender and
added 'Cc' like the original email. However, AFAICT the JSON does not
contain this information, and while I could use the mdir object to find
the original message in my Inbox, this is incredibly slow.

I have a TODO to use python-notmuch to do this, but haven't gotten
around to doing this yet.

With that 'fixed' I could actually reply to these messages and it would
all 'just' work. For now I copy/paste when needed.
