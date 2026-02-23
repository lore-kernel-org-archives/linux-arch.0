Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF786334;
	Mon, 23 Feb 2026 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807647; cv=none; b=AN2kq2+tJpd6GF7qQ8/CoHZlLVa68UUcmfcTFZaCYHluIesGTHIK1Fh3Oo+PVzqZ3XGPm77itLHTlYPAdpFadux57H2F4VRo8qukXdVCopbg5/rWCcIHajmTFt4vJr4Ghl6u6VKpZYBlzLTBxXW8gWWCnKEE4PFswCB3CV1dryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807647; c=relaxed/simple;
	bh=9Rg2ovzdHFVJcpJOm3vuScJXDsF1IsJTiaRKGC5EjjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEkdeH+hEWY2qM23Rftg622dmemVJ9M1Q/C1CJJ1nfKZKo3BI54AbErL8BSSUDaceevSykTJwIJJkqKAxDX1Ay2eZQaASNieXyhFNQIIwVcat9OIdrd34uvd9yBbEEZI6YfxQCnTLc/4vZLsPxj69Yi/ZJwYvTfcUqK6+fwXjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-c1-699ba00d3559
Date: Mon, 23 Feb 2026 09:32:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dirk Behme <dirk.behme@gmx.de>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
	gustavo@padovan.org, christian.koenig@amd.com,
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net,
	bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v18 31/42] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
Message-ID: <20260223003207.GA44876@system.software.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-32-byungchul@sk.com>
 <ab0b9f9c-3a05-42f3-b4a7-ddb6ab0d37a4@gmx.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0b9f9c-3a05-42f3-b4a7-ddb6ab0d37a4@gmx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89x7n3svHXXXzrFnkmxL57KNBNiMS06cM25Zlhs/mezDsi3T
	NetFmlJwLfKiMRZiK+JWsUwWWxwdYqeAQEpEXjRxNMDIRC1M2hHegqSsk0ICbWHtiusNMfPb
	P79/zu+cD4enVS52O68rLJaMhZoCNatgFOH0xmyly6l7J3IuG6osJ6G+vZWFKs9FDL/5Kxl4
	0NaCYC3hpMHS84SBpH2QgzqfnYYfQxUMLLu/Q+AIOjkIz/RheDK1QIE/tojAPb9BQbJODw2N
	nSwMXzjLQthXT4Hv7mMEPbO9HMy4gww4R8ZSU64iGGxZ4KAtfB/D8PQ4hpkhK4ab5lkOPH8O
	IKjqjTLgeZQqfrY2MTDWW8+C2bmGoX0hQMGw4xoD93uvY+gcuUtDzJYJ7ugyB8GHVgqu3R5h
	YdCVAStNMQasqxsYrkSWaDj9Vx8Lk7a/GWgPemnwRhcpqB11sRCf6sYwbm9gYc4W5sBZYUNw
	1lLHwI2BNQ5OTb4HifXU+vWORxiuJ8cRLNVE8L4PxebOLkq0jCZZsfWnViQm4nYkWmpS6crv
	i6wYjz5kxaYzcUrscUxxostzVOy8miVevhWixInHH4ie5jOsWB3+gxKX7t3jDrz2hWKPVirQ
	lUjG3L1fK/J7fvCyR2rTy/yn9GZUqahGaTwRdhF3m596mr2Vbq4a8TwjvEFmfIdlzApvkkDg
	H1rG2wQ1uTG5T8a00PIKGQuXyfkFQU8GupKsnJUCkMb5EK5GCl4l2BHxeWupzWIrGb44z2wO
	Z5HARoiSnbSQSX7Z4GWcJuwm3psWLOcXhdfJna4hSvYQYSKNTLsb6M0zXya/Xg0wNUhwPKN1
	PKN1/K91IboZqXSFJQaNrmBXTn55oa4s55sigwel/tZ94t8vu9HKg0/7kcAjdbryzrJDp8Ka
	ElO5oR8RnlZvUyYSKaTUasqPScaiQ8ajBZKpH2XyjPol5c5YqVYlHNYUS3pJOiIZn7YUn7bd
	jNq762PfZ8TXO2qaRr4d/zg08dHKwJrWMKu3VQw1bP0qf9V8wHL+hI3LwZ+sLn72dmlex44o
	JTx3ekvEcCFjB96CsLTH83nf5OVQ3lvnSj239aHnb+V15b7q3xnR1pWAYzrn/MHc41aNP3np
	pDW4Pzh6aW6uu/i4abdhv+X97GN71YwpX/NuFm00af4DM937xrMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH8zzP7e1tQ821YLjo4ofqYmIibmaa4yRK9mHe7P0TOr+MRq5y
	VyimVQZOYyk065hZsK4ltMoQtVugvpXXznQjNOAcM7ZWRzPBalaRhiJMWhmtpWtjlvnl5H/+
	//M7OR8OQ5RJyWpG1B4WdFp1lYqWU/KPdjRuyutwiG8MTJeA2XQCJsIRCfzRMERBIm6m4MwV
	Fw1px4AUzO42Cfw6bqTAf7kbQThhRrCYchAweTIUpC2jUogv3ZeCtQFBxjuKwBawEAj5fyHg
	6m3AsHB1mYYZ3zME1kcRGlqjDRTMOU8isE85pBAd2Q2z4esSyEw+wTD+PIbAGVnGEBn6CkHa
	poHvO3uyuG2ehtSt2wRarX4E5x5NEngWfYigd/QBAu+PRhoet/QRsN8/AMHICribmKPhpvUb
	GmYDZzA8vUpDh9ErgcDvMwjOOiwIpv70Ymg8f4UG21k3BZ6HP0khMPMCw4TNgqHb/SGEnVMU
	jLV04uzJ2alrheBobcTZMo3Beuk6LnUiftH0LcV39fRj3nQnTfOudhfiU0kL4uMXGwlvasm2
	vtgc4Zt6vuAvjsVoPpm4R/Pe5x0U/1snx1/4Oon5U7c28R77pPSTd/bJSyqEKrFW0G3eWS6v
	9Hznow+dzqsbb9IYkFHejGQMx77F+YxOaTNiGIp9nQsHDuZsmt3AhUJLJGcXsCqub6I0ZxO2
	ey0XnK3L6XxWw430p+mcVrDAdUaikmYkZ5SsBXEB32n8MljJ3WyLUC/hjVxoOYpzOwm7hvth
	mcnZMvZtzjdgkuT0KnYdN9R/A7cghf0V2v4Kbf+f7kCkCxWI2tpqtVi1tVivqazXinXF+2uq
	3Sj7kc7jL04Nonhw9zBiGaTKU8wXOUSlRF2rr68eRhxDVAWKVMouKhUV6vqjgq7mM92RKkE/
	jNYwlKpQ8d4eoVzJHlQfFjSCcEjQ/ZdiRrbagPJJHDyfip/vCZTtcpfn9cnW73C1/82Qnr1d
	wS+Xap7mG8rOtZaGmv7SJsvmNYsFI0Xr321P/bz1yMKqf1zFK/C1bbEwGZx+PCiDxPumtfqg
	v7332F3PvnuGGydjbQuWiqLeO2Mf6Oq2vLaue0vKf+Dj6Inthl0lhRHz9kyGFWMqSl+pfnMj
	0enV/wJlLv3cjQMAAA==
X-CFilter-Loop: Reflected

On Sun, Feb 15, 2026 at 07:42:05AM +0100, Dirk Behme wrote:
> On 05.12.25 08:18, Byungchul Park wrote:
> > wait_for_completion() can be used at various points in the code and it's
> > very hard to distinguish wait_for_completion()s between different usages.
> > Using a single dept_key for all the wait_for_completion()s could trigger
> > false positive reports.
> >
> > Assign unique dept_key to each distinct wait_for_completion() caller to
> > avoid false positive reports.
> >
> > While at it, add a rust helper for wait_for_completion() to avoid build
> > errors.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
> >  kernel/sched/completion.c  |  60 +++++++++++-----------
> >  rust/helpers/completion.c  |   5 ++
> >  3 files changed, 120 insertions(+), 45 deletions(-)
> >
> ...
> > diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> > index b2443262a2ae..5bae5e749def 100644
> > --- a/rust/helpers/completion.c
> > +++ b/rust/helpers/completion.c
> > @@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
> >  {
> >       init_completion(x);
> >  }
> > +
> > +void rust_helper_wait_for_completion(struct completion *x)
> 
> Please add `__rust_helper`:

I will.  Thanks.

	Byungchul
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/rust/helpers/completion.c?h=next-20260213&id=1c7a6f48f7eeb3014584d2fc55fc67f0cbaeef69
> 
> Best regards
> 
> Dirk
