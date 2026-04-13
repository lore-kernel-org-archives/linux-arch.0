Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111540DFD5;
	Mon, 13 Apr 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776061096; cv=none; b=hxBQR3+zD0JobPsyIz1teLUoI0CpIa3pSx+cmITuJ4tJ8Nkah/51ebNTkKwT6Z/Fme2ZMQ6kzP93YiX/rn49SFu/3Wxr5e2nss0XQwLUm9yVVcrOf76vPtzfidg2XDJjiHbdQK8L9e4gSsgMP1xhG2yQu2Q9E4v5acjmDdU9k5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776061096; c=relaxed/simple;
	bh=H0p5N+a06m5oRbOxY5GEzilVIWJX9idPSsQgOlAZRYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L5V1viAIP36UGgymABRz616APh5b4JD1+6yPU17PjgXwqe7Qwnl9NNnRAc1In4HQpHsbR8kX+5JBFArLxxhRJWuPgkdVetrVhuudk2KHIkzT16mx2POosqD3OLbDYFw1lItygElsWCgKMN2R7lqp9AI83MnDKxBVRHe3+XjJgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UyCwc8Zn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoXWxZ3B; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UyCwc8Zn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoXWxZ3B"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 90107EC0227;
	Mon, 13 Apr 2026 02:18:13 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 02:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776061093;
	 x=1776147493; bh=1JbLBiViInaPoZEqWHr6KF0nrLtgKFZ06ed/mYm+y+E=; b=
	UyCwc8ZnSYq/1n0XDeHjn/iH/9V7TFv90I8BrWRAzfh2mGFKofkWs97pzitqvEpw
	Ro/MU/YYSTNmMw0naw8hLcGOZSJGL6xZlSBpJfbUJjenz9LeSaCp+kGGDnYQwrL3
	HpnGZZ6L7MTJc1UoD36wjsjtSqPoibn1UZQ9tjB36lgwqkKG9hhOjmgKS1qan81/
	d4HGQFCMTrynHjctIjDfqMBFAqHSIASSSJ+MK58e4XHwWFCTHAsBJzJ0mOEuIV4B
	QjCUgcG+GpzlxTwlTKKEUrxvXA3/0fe7T5ncWwzb4BeS+IHE9wroJTehl9LITuae
	qHF6hlUYUy2OEY6bFa295Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776061093; x=
	1776147493; bh=1JbLBiViInaPoZEqWHr6KF0nrLtgKFZ06ed/mYm+y+E=; b=K
	oXWxZ3BGscu4eL4gGU8sqPv3jy29uDPamh5WAH3CIcjoZ7P6Xv7m+3DHjWvLAvnR
	4WZp0PEtr9rZ6wjBgzqYE6dyg1aKUb/wmbLQm+NUU3L0vjUdMCJtKVbv98dZXeYG
	Mmfn8TyFhlTyNPUzp6saOdqRIxdq1qaMhI0NMgeDs27hdSJI1P6eOfq5R4YDRe8F
	hlqx8h+T8jyCJQGFQcASzFzS8/IObxfUAADYPLppw3efmFVb8+AwcjMQ1p3n5QUN
	AorcRYKfDR173mdGvP8BcPMpXWMA3JLaOnta2cffyvstIRUcGA30QlJKmgYdqUSk
	DfHvx93T7qnTNbElKkUCQ==
X-ME-Sender: <xms:o4rcaZYlu7XDLy2tYo7KpZa-Zx_GWmvgPjA13_7p6nQWGs_QfBMrwQ>
    <xme:o4rcabOYShrHE8pVCy3zDUKaa73mJnARc-Kb-f9jss_kMzarc_2m0ziq8M56PCcTP
    onZCylkw8mh4IZNH2PlzamuhHmK6Pkp5r_tb5mUTOzoTd1zDyN8iOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprg
    hlvgigsehghhhithhirdhfrhdprhgtphhtthhopehinhhotghhihgrmhgrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprhgrsggvnhgurgdrtghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghlvghkshgrrdhprghunhhovhhitgeshhhtvggtghhrohhuphdrtghomhdp
    rhgtphhtthhopegujhhorhgujhgvrdhtohguohhrohhvihgtsehhthgvtghgrhhouhhprd
    gtohhmpdhrtghpthhtohepghgrohhhrghnsehishgtrghsrdgrtgdrtghnpdhrtghpthht
    ohepghhuohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpjhifsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:o4rcadvBo7DsoZ9p3_HCcfblIYi1VIIvURKft5mkK7-8CL73WjgFmQ>
    <xmx:o4rcaX3j4ldSl1DsgEyj_apBL572VMgn23ZTVZkXwE_VVKvIev_ouw>
    <xmx:o4rcaaDp7_wz-9VkY7Nx2Luuwoyz6gnmpmGfe9eC4WoECo99Pu5-Bw>
    <xmx:o4rcacfvgmHfChfW-NMwlKI-we3O66XPnsr-ftUv0ZUe4RZOATywDA>
    <xmx:pYrcaTvmoH9fKKuJP1g1L6ZcHX9ZzBiDPaDabyiuFAHum2LnWF2ePDrI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C538D700065; Mon, 13 Apr 2026 02:18:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ab9VcpOYxc8o
Date: Mon, 13 Apr 2026 08:17:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: guoren <guoren@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Leonardo Bras" <leobras@redhat.com>, djordje.todorovic@htecgroup.com,
 aleksa.paunovic@htecgroup.com, "Han Gao" <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>, "Han Gao" <gaohan@iscas.ac.cn>,
 "Yao Zi" <me@ziyao.cc>, "Chen Wang" <unicorn_wang@outlook.com>,
 "Inochi Amaoto" <inochiama@gmail.com>,
 "Xiaoguang Xing" <xiaoguang.xing@sophgo.com>,
 "Paul Walmsley" <pjw@kernel.org>
Message-Id: <535f3eaa-ff93-4de4-86c7-8a6e46bcca63@app.fastmail.com>
In-Reply-To: <20260412143116.1445893-1-guoren@kernel.org>
References: <20260412143116.1445893-1-guoren@kernel.org>
Subject: Re: [PATCH V4] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Apr 12, 2026, at 16:31, guoren@kernel.org wrote:
>  arch/riscv/Kconfig.errata                    | 17 ++++++++++
>  arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
>  arch/riscv/include/asm/errata_list_vendors.h |  3 +-
>  arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
>  include/asm-generic/rwonce.h                 |  2 ++

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +static bool errata_probe_write_once(unsigned int stage,
> +				    unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> +		return false;
> +
> +	/* target-c9xx cores report arch_id and impid as 0 */
> +	if (arch_id != 0 || impid != 0)
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_BOOT ||
> +	    stage == RISCV_ALTERNATIVES_MODULE)
> +		return true;

Question: Are the affected cores the only ones that report
arch_id==impid==0? If there are other known implementations
that get the extra barrier but don't need it here, that
should probably be mentioned in the Kconfig text and
the code comment.

      Arnd
