Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DD3E3150;
	Fri, 24 Apr 2026 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061543; cv=none; b=VO6ZPh75xLMt3HhSGRYXw5N5P6Z5wJleIDWMOxjn2Ud0FBkMdBexiLgDx76IUQ6OUCxV7i8nFUGoO0sdmZZURTaz+1x5Sj7Vbkm5R6QKi41+KjEqqIMQV+h4hLLF81odYocR64DlOvoMKGE5TYhyImFD7yiNaTakI7wwNkS8tMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061543; c=relaxed/simple;
	bh=RNMi8j69E6SyZYSTyxa4Rgeppp5kOvW/DVxpzRjMv8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5bqFaoGFVaAi2AkWmwXwYBt/k5CdPpDTetqLh4UfYG91n00UxgQ+UQvbvtqRVfZxYlcHHu4mwfPNeUMS6FcpU+x6HPt2Y80HhE0yCYNt+CSzEbIGvM6u0RRKrmj4G2jS7kuPphtMycF/ogQ1y4HIPkQ5zWq68QMdZsQNEnzST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ffWhi37p; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffWhi37p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R2gaRjg/CIye/6fA05gchsWC8RdbQ511C4bcMcmE3UY=; b=ffWhi37pPSombHmnM7V2siTel6
	XhOcC9uho2ip4uKGHzUY6KCWyA25VVTTIu+jmD6PKyw7uzEPPidXyBdTKpBF3db7hQ2CXEirPYM7d
	mbOuK3/bq1/NWyyf7j4gAtJ1dikM9FQ4urbzO4xcmkGKMjK19qdLVoy75SILKV6DKjQOZ7IxoBCRw
	rNusdzBNhnsOrlUg3KPcYHo++EPYC918x1pjSWji81mw1OCWux+8lta2a/0fBTFCp+0rmyJMk+gYJ
	LmthHCuq/1mMFIcTpOpWJ1LoYXpqHHM/ov0DGrQ8OFeuJl/s4tVY3n3GMvDgz81Lb4EvvDnwfjifb
	07TEMcGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGMsb-0000000FR5i-1WST;
	Fri, 24 Apr 2026 20:12:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D3EA7301142; Fri, 24 Apr 2026 22:11:59 +0200 (CEST)
Date: Fri, 24 Apr 2026 22:11:59 +0200
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
Message-ID: <20260424201159.GD3783056@noisy.programming.kicks-ass.net>
References: <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <20260424190141.GA3783056@noisy.programming.kicks-ass.net>
 <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
 <20260424192250.GC3783056@noisy.programming.kicks-ass.net>
 <20260424193529.GA3853824@noisy.programming.kicks-ass.net>
 <7ia45x5gktx9.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia45x5gktx9.fsf@castle.c.googlers.com>

On Fri, Apr 24, 2026 at 08:03:14PM +0000, Roman Gushchin wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Fri, Apr 24, 2026 at 09:22:51PM +0200, Peter Zijlstra wrote:
> >
> >>     mdir = mailbox.Maildir('~/Maildir/');
> >> 
> >>     for i, r in enumerate(reviews):
> >>         inline = r.get('inline_review', '') or ''
> >>         if not inline:
> >>             continue
> >> 
> >>         author_name = r.get('author_name', 'Sashiko Reviewer')
> >>         author_email = r.get('author_email', 'noreply@sashiko.dev')
> >> 
> >>         msgid = msgids[r['patch_id']]
> >>         subject = subjects[r['patch_id']]
> >> 
> >>         # Create the Email object
> >>         msg = EmailMessage()
> >>         msg['Subject'] = f"Re: {subject}"
> >>         msg['From'] = f"{author_name} <{author_email}>"
> >>         msg['To'] = "peterz@infradead.org"
> >>         msg['Date'] = formatdate(localtime=True)
> >> 
> >>         # The critical threading headers
> >>         msg['Message-ID'] = f"<review-{i}-{msgid}>"
> >>         msg['References'] = f"<{msgid}>"
> >>         msg['In-Reply-To'] = f"<{msgid}>"
> >> 
> >>         msg.set_content(inline)
> >> 
> >>         mdir.add(msg)
> >> 
> >>     mdir.flush()
> >
> > So Ideally I would have 'Reply-to' header set to the original sender and
> > added 'Cc' like the original email. However, AFAICT the JSON does not
> > contain this information, and while I could use the mdir object to find
> > the original message in my Inbox, this is incredibly slow.
> >
> > I have a TODO to use python-notmuch to do this, but haven't gotten
> > around to doing this yet.
> >
> > With that 'fixed' I could actually reply to these messages and it would
> > all 'just' work. For now I copy/paste when needed.
> 
> I can add an api to return a json with the review and all
> meta-information by the original msgid, will it be useful?

Oh yes, that would be more convenient. Thanks!
