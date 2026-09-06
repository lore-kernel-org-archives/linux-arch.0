Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DA23D7DC;
	Sun,  6 Sep 2026 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788654500; cv=none; b=DEURmnuR5ZzXT9eEfx+wsMi6mdKrr4G455jrfyh7G1tq7m+aVLsE3r3xtByPIjB0psY5Rxc0793jAqcum2YS/DBtYkFA4Htzg+hU9aKX1xZJA4FyXEhjhRyoHS5Z7PfD3Ry0J1gpTm3GNjekT99KXyEdbY5+2PZs9jjv2KlZzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788654500; c=relaxed/simple;
	bh=ELRPOdat/A9yAN4dJvU5OOVGkHDWZDdYiCShAdbADyo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FkQMREYtU3yaq4ZLSgwIldPpgxPDjDzLuOAr6HPbNaeFhmj1qQlHkP34t7B8I4v4b3A/CT9Hq8rCXROr3A5aA+VadUnIKcwMJDo+vGgQYzK8oHu4Os/g9EpKAdtemEdofPGwwWIUJB6W/zrVrp6adXYPBZ+1UdzXaXpotrXXMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1dVLNfBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1dVLNfBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A3A1F00A3A;
	Sun,  6 Sep 2026 00:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788654498;
	bh=z9A4Dxzfg1oo/Is64gEjEJpedBNhIepfiTCWGidRRgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1dVLNfBTnQpu0MZul4OKc3anMkAgfQjsjH9sax576+bpVej6aaA1OxSDEfYdtxg8j
	 +9LhopCycuLGQ/uIuanMv7Av74aCof5rxBjud1yTdF81PkSvfYRmiwPeZriDv5GAI0
	 e7UpJoqkIpf9uUaDyul33pjZdHAiQx+/l0QEjirs=
Date: Sat, 5 Sep 2026 17:28:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org,
 ojeda@kernel.org, mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com,
 da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co,
 mproche@mail.com, nick.lane@mail.com, rishil1999@outlook.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-Id: <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
In-Reply-To: <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
References: <20260903185557.183224-1-atomlin@atomlin.com>
	<20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
	<ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 10:59:38 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:

> On Thu, Sep 03, 2026 at 01:29:24PM -0700, Andrew Morton wrote:
> > On Thu,  3 Sep 2026 14:55:55 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
> > 
> > > Currently, the "module_blacklist=" command-line parameter only applies to
> > > loadable modules. If a module is built-in, the parameter is silently
> > > ignored. This patch series extends the blacklisting functionality to
> > > built-in modules by intercepting their initialisation routines during early
> > > boot.
> > 
> > Why?  What are the use-cases and what is the value of this change
> > to our users?
> > 
> > Important, so please don't skimp on the details.
> 
> Hi Andrew,
> 
> Thanks for asking.
> 
> Here is the rationale, concrete use cases, and the value this hopefully
> brings to users and administrators.
>
> ...
>
> In summary, this patch brings parity between modular and built-in drivers,
> removes a pain point in boot-time disaster recovery, and provides users
> with a predictable, consistent interface.

Really helpful, thanks.  Please add this to the [0/N] and maintain it.

I don't really know who are the potential audience for this change, nor
how to attract their attention.  Greg might have some insights but he
wasn't cc'ed.

Let's leave it a week to see if there's feedback then resend with these
adjustments?

