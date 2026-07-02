Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B63859CE;
	Thu,  2 Jul 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973271; cv=none; b=Mq3Gku+vyPqFl6BQXtaflPKV/ik7GQIheb22gJmkhskOqIPcXPe+C1vDqAJHTIOc+HBaOuS57lX+RXpuwNZkY6KtObv3tf0YL1T2ZL4lzNh2/iudtDcw2iWeeNbTKFLqo04MNpkfWHjvIJtEBnDKkr6j5aWP1JW8YVne5GxiCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973271; c=relaxed/simple;
	bh=gtNJnOoM3M3WWrtb/BDrLaX2se0o79gQY7jHyTuquhs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tlQtBtaDHS4MODLlcpCDwd+pG4LQQrlTOXrvU5PLiQ7CZ2WjtVySyNOLev2aQY25rKJi3jxt5BUCzEDQF732DcOOUQMLRVCEC2la4sYSnMqHoZP1jdwElmrNK0PgFVMW2qBnzSFztceD2GCTs87YmDtJsWxVtq7XWGgDAdBWRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pHG6L5mH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nL/rU/Yw; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pHG6L5mH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nL/rU/Yw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id EFC121380BEE;
	Thu,  2 Jul 2026 02:21:05 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 02:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782973265;
	 x=1782980465; bh=b3PWSBg4KChgsJan4tuQCL8jbVLFvYUrGfeJer055uM=; b=
	pHG6L5mHwpZ3+t5ToOn88ZFsBk/C4OTZhsX4TG3c/Jn22zYlndw3yAb5k+Xi0afh
	pmgxFuvKvn2WzbHsGmYr8xpNhshaVrqt8RX/YVKMcsNY7+HhVHcAUKmJCtg0C8iJ
	pq6uQxeZKcxSHthNbdF2GgtA/DtusqRQMjNsF9VDT+ehZsXFv3K0UH/81+Z17GAW
	qmsyyAhPIYBsJFRGSDOmS8s0QjXy57JKLTBlLoy2divLD816rwL5dRpZuum7DQ+T
	2jG0Vi428hRsMde6LRDHrXKy+ohPp1d/bjF9p1bA3Q6PxLStspEz6TERmv7GyLpB
	TjjgXYDVBay3ayP5X4Sp+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1782973265; x=1782980465; bh=b
	3PWSBg4KChgsJan4tuQCL8jbVLFvYUrGfeJer055uM=; b=nL/rU/Yw5uhaXwXhi
	Pd3VAx3B2hx7wViUybdKoAQE+tVB17JWqmgJ85oRMoaLYHDoDWVbGQqP7/jPlIPU
	hzbo9kt/XdamhIBRpkOv4/lunP1reK+zNkZgOQjxx115BlKGKezHMD05psIryBAj
	5LRCN7P9/fAgRQO8SWm/ccU53eWMTgwM9u2dEhWtqDmP0bBoyNtcEzjQh3+7oJ1B
	ZjGO8+Gmq9TqtIRRgJOO3n9v6MLzQ8TSKTFNIABkPUFjxvQtCrMk6GYaK/w6YIf9
	vvIaPZTtgA5tQsOEZsbx6RUGGOSIIQXvDiI07XWpmunN5bmAAH1o1FX6lIjes+k4
	FJCQg==
X-ME-Sender: <xms:TgNGak7Ze3et09HaNnBg_7EeQDX1WpWebr4V831dQRQ0tvGSRYeivA>
    <xme:TgNGagtubviHB1QN1yH-MEOhjFwJ8OckeYJXHlsGjoKr7RueVhicU1OBsXy2_s9kp
    RsZM6FGHSlUvd4aJTwHseRgONcCnDljF7qFg43tXxjmj3ZPxkWMv4q4>
X-ME-Proxy-Cause: dmFkZTFLXnvGPrjS72UE2Cqoo5k3ZB5gW2fmq0+H7vA6q9/xqCZId+5ccMWvDzoGXPw/0n
    bjmGiO0C5Lo3nj4814huzfyegsEBWSnqZoUE37P6yUUBXeBynDaNZOtEBZabAT6pGBLEgU
    TEXwWHPQDy4swa2ntT+PIpDMucMVt6OvaMl5lrlzMeK7PZwOzrwQDo9+/Gzz/Ie0GPu+Tm
    kbTjJ/ulLLG9DyncXMFNYmwJcjO6WDGqMUTanigqlUey17X5CJkl0f5gb2UEykQU+/4Cjo
    mfffcyLiE7gORaIWIJTK/7sCi1c8oo/WWzgxdhxPbFkX7CHDV/F+fGNobcmZI3WILujIku
    kiedAWW3wRu29mXJiSRShIxXoXZ5aZqgbsuWLiW6ge3WV8Hb+V3JwhBVZWtnluFGL+P1Ns
    4Z5fVXr51VV6UZILO2z+SSwiFlEu7tZlvb5FQn7yigxfSJGrT4rMcV3J/B+VlYDYX5gEDU
    V6u8xf8P2wj9O9ZpESK00kmIyUHTVbXQlq6l7G4dzuHWpBQG8cvL7+wxEaBV6d8AzjoyNB
    5/rkY8Z2KYSOkqZoV39s+5tQtJs9f64Or/qTG1GQcjMVv0vUkB43dqvpcEeDCp2r5ZAyW1
    Anmp3iBPSl4IC2zBhhx5W5jKsXeXS7eXQveoueb2CZRFXBR0D+w/2xtPZQlg
X-ME-Proxy: <xmx:TgNGaqCgZyrr9Xnr787Z91vrIHBNiHjg43elOA4_XUWAhfKmGuwMdw>
    <xmx:TgNGagSOcRYgdkPiRpDyOyP4_XAjmTow4SSXpP2BodR0JaFbxyJeqQ>
    <xmx:TgNGamKPz_fqI_hnI52rvFsBrZFhzD9m9HQVojzO4Mmyabb9IIP9fg>
    <xmx:TgNGap5OGCVE8hEKbrsOGNvpaduUNlxToEz72V_Qp4afO3lJIy6hRg>
    <xmx:UQNGalg_WH4O8rD15jW7viiZk_F5cGP2IcPo9TPcvYnUn-YFbaXQEXfz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0D98182007E; Thu,  2 Jul 2026 02:21:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGRLTTzEx-Mw
Date: Thu, 02 Jul 2026 08:20:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, pulehui@huawei.com,
 puranjay@kernel.org, "Thomas Huth" <thuth@redhat.com>,
 "Andrew Jones" <ajones@ventanamicro.com>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>,
 =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Zong Li" <zong.li@sifive.com>,
 "Conor.Dooley" <conor.dooley@microchip.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Deepak Gupta" <debug@rivosinc.com>,
 seanwascoding@gmail.com, "Andy Chiu" <andybnac@gmail.com>,
 menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
 "Vivian Wang" <wangruikang@iscas.ac.cn>,
 "Atish Patra" <atishp@rivosinc.com>,
 "Anup Patel" <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, qingfang.deng@siflower.com.cn,
 Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Message-Id: <c190a4ea-8c87-4b4a-9146-20e06d0250b0@app.fastmail.com>
In-Reply-To: <20260702025443.83389-2-cuiyunhui@bytedance.com>
References: <20260702025443.83389-1-cuiyunhui@bytedance.com>
 <20260702025443.83389-2-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v7 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 2, 2026, at 04:54, Yunhui Cui wrote:
> When port I/O is not supported, exposing the port-string helpers is both
> unnecessary and can make clang diagnose null-pointer arithmetic from the
> PCI_IOBASE based address expression.  Keep the MMIO string helpers
> available as before, but only provide the port I/O variants when
> CONFIG_HAS_IOPORT is enabled.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
