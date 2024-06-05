Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B47D9145340
	for <linux-arch@vger.kernel.org>; Wed,  5 Jun 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602836; cv=none; b=ZiRV1M3SFJbcA6bV8U2M9CwWW7slO7fSrpFtxr7E3Z1Biz8bU24HSMf6z8L5xJAb0OPPa1b123citznZVAiUgoEijSsTiTezMMRl0Brg6/Jm7zgzTVjgIdFA21fExKKZGeujCZ3veaOpuViqCSlWNsrmXmnHJWCIRw9OIbstbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602836; c=relaxed/simple;
	bh=NJlto6miWk1aqP3OLO7cxJUaMXDrn7DMrp+Ob7yWlAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X340ub39hQtCvEClmJ7L/TjnVwkiYpvmw2sL8HOkVz3GIcjs8c7rtsqlmn3LpIQpruUVfLXM45mjyPcs4DqSORGJZT/KozoiXa43oeu1ml6f1ulBMLcTNbYuPehXHfxmr4f334ajz6LlkOK6+FyjW2oAJPyXQ9qehnawruUH69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 200889 invoked by uid 1000); 5 Jun 2024 11:53:52 -0400
Date: Wed, 5 Jun 2024 11:53:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v2] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <037bc316-3e8c-4748-bade-ffdad4239646@rowland.harvard.edu>
References: <20240605134918.365579-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605134918.365579-1-parri.andrea@gmail.com>

On Wed, Jun 05, 2024 at 03:49:18PM +0200, Andrea Parri wrote:
> tools/memory-model/ and herdtool7 are closely linked: the latter is
> responsible for (pre)processing each C-like macro of a litmus test,
> and for providing the LKMM with a set of events, or "representation",
> corresponding to the given macro.  Provide herd-representation.txt
> to document the representations of the concurrency macros, following
> their "classification" in Documentation/atomic_t.txt.
> 
> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

> --- /dev/null
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -0,0 +1,107 @@
> +#
> +# Legenda:
> +#	R,	a Load event
> +#	W,	a Store event
> +#	F,	a Fence event
> +#	LKR,	a Lock-Read event
> +#	LKW,	a Lock-Write event
> +#	UL,	an Unlock event
> +#	LF,	a Lock-Fail event
> +#	RL,	a Read-Locked event
> +#	RU,	a Read-Unlocked event
> +#	R*,	a Load event included in RMW
> +#	W*,	a Store event included in RMW
> +#	SRCU,	a Sleepable-Read-Copy-Update event
> +#
> +#	po,	a Program-Order link
> +#	rmw,	a Read-Modify-Write link
> +#	lk-rmw,	a Lock-Read-Modify-Write link

I wonder if we really need a special notation for lk-rmw.  Is anything 
wrong with using the normal rmw notation for these links?

Alan
