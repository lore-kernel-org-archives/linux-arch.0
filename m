Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681442459DC;
	Fri, 17 Apr 2026 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776396563; cv=none; b=D0Uk1dCxgnqc3Tr3fnqdFjh3tk9Z18bsabbb1RSH+AbgRIBy2NyTalME2xehzSKD8XiQf8EYyU469KuhzYxys7C9CMF66qw+jpx9IpJobRjxhqJiFJYoD1yWjwoIMq8mCn7zOMFZgl1C5gr2Cs2i5yvrwcemDM93aEqSYadmu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776396563; c=relaxed/simple;
	bh=QMIbPVDPg3r2vcf7x8TXu0U64Ddj9Tpjm4r1WvLJOUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTKwCNUbdqZTb20oOsXwjdOyWcamIPvB4ilYkRKhzvaIbnrVp3SMpCF3K01lnADFd6iHDVzZyVlmiFqAYen1wi4Up4FuqjL7tEZj+5fNByehKIitpG9XnGqTZWoSrMQMryecwmXLpDzIUKHlWdcWc7StiQoT7bnuCHDDQTQ158c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+cisOJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+cisOJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D1EC19425;
	Fri, 17 Apr 2026 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776396563;
	bh=QMIbPVDPg3r2vcf7x8TXu0U64Ddj9Tpjm4r1WvLJOUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+cisOJLq4EVy4e9aPrA2hrNaCSo8yN93X1E+jMkUPpmo8yNnNTNQW+eMjnKdTNTi
	 odAd1gL31IJvstLBxC8NpelrX633Um5QuPcyMLgcXPz5CaN+3nq/Kih0UqdydXAJeg
	 Qxr6SOKtNegkXXZmuD0thp7UBK8a+BMcpLA3WQVNmeZ331h8oZpEuAKyzVbVe5j0LQ
	 Skh0qr7qYW2l/wNI5IWpoXf7avrHGSNomiLAxDlCVafVvVyExS/6Lr4Z/dgQBZCVqA
	 2JGlTTIBHnSEcBwE7nUk+iPle+O23k/F1LGFpOqW5rW5NsU14KT/dfypS/cq4+SdtF
	 3TvaVi5dH3r5w==
Date: Thu, 16 Apr 2026 20:29:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, yury.norov@gmail.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux@rasmusvillemoes.dk, arnd@arndb.de,
	cp0613@linux.alibaba.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
Message-ID: <20260417032917.GA4041922@ax162>
References: <20260415093827.2776328-1-ruanjinjie@huawei.com>
 <20260415093827.2776328-3-ruanjinjie@huawei.com>
 <20260416231441.GA12905@ax162>
 <aeF5Q2XauRKBDssy@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeF5Q2XauRKBDssy@yury>

On Thu, Apr 16, 2026 at 08:34:28PM -0400, Yury Norov wrote:
> On Thu, Apr 16, 2026 at 04:14:41PM -0700, Nathan Chancellor wrote:
> > Yury, are you intending to send this series to Linus in the 7.1 merge
> > window?
> 
> No, I'm already done with this merge window. This is the material for
> the next one, if ever.
> 
> Just as said, I added this one for testing. I am so far have no feedback
> from robots. But your report is enough to drop it.

The lore.kernel.org link came from KernelCI but it does not look like
they do bisecting to identify the commit and notify the authors. It was
just sent to the linux-next mailing list.

> > If not, it shouldn't be in -next at this point.
> 
> What for do we need -next, if not for early testing?

It is just for the two weeks of the merge window to ensure the tree
actually stabilizes. This is how it has always been.

  https://lore.kernel.org/linux-next/aeDrt2FkMD6ZWaVS@sirena.org.uk/
  https://lore.kernel.org/linux-next/ad9r3jEtJJNv0IiA@sirena.org.uk/

I think Mark meant to say 7.2 but still. Not trying to sound like a cop
or anything but the more problems there are in the tree, the harder it
is to triage new failures and perform additional testing.

Cheers,
Nathan
