Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y2MkADK4"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD32198E;
	Mon, 11 Dec 2023 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MO8te+CcZhuqh9lyi6N+6OpnOSi5nFlWtax3fsNSytk=; b=y2MkADK4CsUrTrRfEeLVo69I26
	XGJJPYgXVKpIpPYUV+5CJE2s241GM5VyUiBDUCk17cKRUQuKsPma5DgB0ZsZRa/Ixj/507F0O34iq
	GXKpirxPm23nbHyhgtnjiU0VmzeC64y7b9uFE6auvqLAkNuYntKnzbmp+lNx3WiCyvdTuFHOVUBRd
	bWHefEf15J+Tm4W4MQjC0AE0hmFJSMeY1M1LzWMmQPxG1oCIgmMSoIwjsu1+DKFlMS3yCpRmhGZ+S
	mqVPY7PuJqBG4LFCyUYYdA9UYo01SjP5q1DHxWK2K24NTg30TuUrdS4ThieLbUPuQVCXE1GPAA7Ng
	TeoO3row==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCilh-005dP1-2k;
	Mon, 11 Dec 2023 16:04:29 +0000
Date: Mon, 11 Dec 2023 08:04:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 03/12] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXczDXH6KZWwcWLQ@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-4-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 07, 2023 at 09:54:33PM -0800, Samuel Holland wrote:
> Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
> tree, use it instead of duplicating the flags here.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
