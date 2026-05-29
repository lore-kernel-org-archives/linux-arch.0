Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7C3CA4AD;
	Fri, 29 May 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053047; cv=none; b=E+Niyw6j6fSWmiLxXzEfeqUB6qX3Y2/A3LJVSOvUXBvQQr5a7vG+p7c1c1uplB+ADiiuEngUANVKW5iKP/SgGd87NiOBMZ07qzV+sbxCRFjgkZo+z7Je93iCFwDMSD8swcpvqXOQpAPDFNWVntnbkRrvzuSfCbICRlKaWYbz1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053047; c=relaxed/simple;
	bh=fJayk0vMTMoSBTWxfwn6ztHUTYZZzQABYav/VKCvz2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRR6Vs0E81W7X4XQq9K+pDCM4kfqq7iBVZp5xRrsYqUGIhSGt0zMJFAd96XuHznXuP7j2gosMj5aZzBxCdo2UUrn5XZMl/lCybDpiXHsSsXtKJ/QBaB2j2oEsEpE5gKcwCHreNnpwqpnriIcBNQFrguKC6Qqtv0ds2Vv0+4bb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jD0ZTL7V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jD0ZTL7V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nRkEGXP11hFVJhyK9fz69KbA7K+xdDcBYB3fNOZPNoc=; b=jD0ZTL7VZL3PdRN8lqnvI7EMm/
	cwIN41nkcKFCkXuhq9JMAaNjzoF5EmP/5hSA05BsKqCwFXKlPpqQ3u5dKlnO99GUuV8jyO/fBaCCB
	Z0Zwa2NDhkxXBQYRoGqPjbM7LC47WJhSdvG3dKwaq7/KYnyZGmGCvZAMOKGQ8A26r1pfNONyyvwon
	BsJuSJfYSNH+AGaBXjF2Ei01nwJmWB36T8VzStOmpSdRy6iK2xTXjFsRIqCr+oiIoUyBpbHvtX2U/
	e9OfFFdrv44Dl78xJDJ48IN6BEynEF9gXrR75FToAdOYZyF/e2EQRuSseX39PW3HzEDSJ/tATWsdn
	VCnlsYlQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSv6S-000000060Uo-2N4R;
	Fri, 29 May 2026 11:10:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 06D5E30036F; Fri, 29 May 2026 13:10:12 +0200 (CEST)
Date: Fri, 29 May 2026 13:10:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Yosry Ahmed <yosry@kernel.org>,
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
	linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <20260529111011.GH3493090@noisy.programming.kicks-ass.net>
References: <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <20260424190141.GA3783056@noisy.programming.kicks-ass.net>
 <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
 <20260424192250.GC3783056@noisy.programming.kicks-ass.net>
 <20260424193529.GA3853824@noisy.programming.kicks-ass.net>
 <7ia45x5gktx9.fsf@castle.c.googlers.com>
 <20260424201159.GD3783056@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424201159.GD3783056@noisy.programming.kicks-ass.net>

On Fri, Apr 24, 2026 at 10:11:59PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 24, 2026 at 08:03:14PM +0000, Roman Gushchin wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > On Fri, Apr 24, 2026 at 09:22:51PM +0200, Peter Zijlstra wrote:
> > >
> > >>     mdir = mailbox.Maildir('~/Maildir/');
> > >> 
> > >>     for i, r in enumerate(reviews):
> > >>         inline = r.get('inline_review', '') or ''
> > >>         if not inline:
> > >>             continue
> > >> 
> > >>         author_name = r.get('author_name', 'Sashiko Reviewer')
> > >>         author_email = r.get('author_email', 'noreply@sashiko.dev')
> > >> 
> > >>         msgid = msgids[r['patch_id']]
> > >>         subject = subjects[r['patch_id']]
> > >> 
> > >>         # Create the Email object
> > >>         msg = EmailMessage()
> > >>         msg['Subject'] = f"Re: {subject}"
> > >>         msg['From'] = f"{author_name} <{author_email}>"
> > >>         msg['To'] = "peterz@infradead.org"
> > >>         msg['Date'] = formatdate(localtime=True)
> > >> 
> > >>         # The critical threading headers
> > >>         msg['Message-ID'] = f"<review-{i}-{msgid}>"
> > >>         msg['References'] = f"<{msgid}>"
> > >>         msg['In-Reply-To'] = f"<{msgid}>"
> > >> 
> > >>         msg.set_content(inline)
> > >> 
> > >>         mdir.add(msg)
> > >> 
> > >>     mdir.flush()
> > >
> > > So Ideally I would have 'Reply-to' header set to the original sender and
> > > added 'Cc' like the original email. However, AFAICT the JSON does not
> > > contain this information, and while I could use the mdir object to find
> > > the original message in my Inbox, this is incredibly slow.
> > >
> > > I have a TODO to use python-notmuch to do this, but haven't gotten
> > > around to doing this yet.
> > >
> > > With that 'fixed' I could actually reply to these messages and it would
> > > all 'just' work. For now I copy/paste when needed.
> > 
> > I can add an api to return a json with the review and all
> > meta-information by the original msgid, will it be useful?
> 
> Oh yes, that would be more convenient. Thanks!

Roman, did you find time to do this? If not, I'll patiently wait :-)

