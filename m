Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164C357D11;
	Sun,  6 Sep 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788688597; cv=none; b=G2zMNYDDGSZa0Z+vht+9ICd+MgTtMwuYIqmX3sKzy6Kvc+RF9pO+yHnM57/j8NXeMg/E+FmAWxCm50+VeJx3Hn385MiwQPuju0f7K0BVrhNc3jq7Zfam86SiDb9WgUNTDGE6xNClfa91nS6g6s74tDss4tlA9sT5wwVOHXHDdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788688597; c=relaxed/simple;
	bh=nmLnH2FO22URT+zqx+3wQI0OkgcG32DGI4IEzKkKJJ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HJJ68EVt6qRhZoS+VVRSPtj6MVfhOfSdrY/Fz0OB1K+oz1EKY9xuxbhYR7I7RTB5RE/ffMuDMgqWFIQf5nrKPp2gvojyIWShVa5CJSxJNYC9EDNaZ2b9SFZW5RuEggzMYE3eg27naH0A+6AAMTu8SsOFs8VZl0m8vXBCHl33Z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZdRR2cSt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLRfvAU6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZdRR2cSt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLRfvAU6"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id A63A81D00073;
	Sun,  6 Sep 2026 05:56:32 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 06 Sep 2026 05:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788688591;
	 x=1788774991; bh=Pr7P/bQe4OD/y9tPGao5y3yLVyT3OMv99kp5yzNiVs0=; b=
	ZdRR2cStxXzs41LdAL9O5M2pY/KNZcCCtj6cLOwxD5k44HeoqlOeyaXSQjGPkvu0
	maMMJSEVf9MiAgV6gXR6dHycpszhVq1p221ysZiQst3YwryImIFndr3eel670bG5
	AefEY22Yj2gJ58XhHbaQjm/Jgs8rB50vkiBBgvYhwnTtiAi8m1Mfajg5yk1dxvAN
	Uy2ZaKH3AJzPlp4e+JAEXfsumPD+qfTXT9wcS7pU3s8CmodssRgwq9jL1CiyJ/b4
	wbu51lkzIVT9hay0qSGwmjOQdMAKSJ0Ei1ykKgLbu0uvwD/TzUF0JHvzoJi/JMy9
	xLtzBb1jhNhn1qI7hT0wJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788688591; x=
	1788774991; bh=Pr7P/bQe4OD/y9tPGao5y3yLVyT3OMv99kp5yzNiVs0=; b=H
	LRfvAU6wqai3iv3BrtgRH7M1B+Cruw7QVKZdUevyASL9tzjmiWAMwp9U69xSW2dI
	eBMw9ehTFNgkizomsfQ6noIC7knUv5mmiv82qQ+DDHRM3AN7vQyX/ZL1aetR8tMX
	04o31zHjXPL0XUD3uOr+3d+uP+yA8+LB0ZE1fjZuJ3yeitxtxHf3sk1FSx8HMQKo
	J/Mgvl7R0HUC3Flcpzt7Cron7sq33xqty0MBVnbz0a0zkNo1bsf8L0dio0KPMRrp
	zwLXEZCH6j4eJ7dfZh3FY8UhrohGwLqPQ+I/qo7DeZSk7KTXuFVbzHwCrC4ph0Ud
	N/edXRsrjmmxV3+7pVaQg==
X-ME-Sender: <xms:yDidagoJmvzu8cxFKf7-VtLUhlEqdW216nKkdhfVv8UoTFbsltLbjA>
    <xme:yDidahepe84fN5cRZesgCRqcJ_K5HAke5xVdTt5dVDu3ddQMAAlby4e0EKqdTX_M0
    tklWKWMxZN3kPay7w_0MsHfvDS-fvElhm0JIl6DCfiylbawMkvCQKWk>
X-ME-Proxy-Cause: dmFkZTEGw6S2QRCJ4OZl8m5QpuOWMef4kALjhcDrEiPT6BNwXqlCG1J0/+3V4BOwdsGP8O
    Yu0qtHRf3nk7DGelxrrZfs/uYxACYd4F+F57sN7JeCzoP22Sp/dQdTT1qWTMiOX7nAVXNI
    /xOQk/g7JLFLswX1+IZjhK1TRYWuxCDXyQfTOJd90u4IZCSKGBKDp3wRdWgAuO8ktOuqgw
    k3N1qYloD4DOJd0Gx17ZLfyFqYoFFZLcrMQe5G0PoYAYnK60lFc7187ict9Lu2KA1XPeI4
    hNS7Bdlu5JDssn3j/XWy/CNmrZMpI/Xj70DWuNGWnGKvd/EgKdMuG1p+0d56rwhH6Htlp/
    UPbDs/W1jvBK35xrYlh2nNTo1Tm/bT7u9/kjiZ1vQYcwm4vviNoLF6XoWhExe2Byv1TleP
    gyXMnFJJWrU9qL72o7MC7c8aLomXRurbawvVI/WXHLcuVT4bR90AaYck+tRf6YW3qROyvG
    ISHMJlH/nz7rGcwNOJ70qDgABY7Q2V2QQiOTksJz80Nx4Lj+x7DQwmXctaBUhiqaD9tWw1
    p4brL94eydKSxjWqmgtvY7bkkKWhi4GEBUCOubpUZlUtTdBoPjoFTGDWQxkUuYGVhC+yCg
    t3/BAiE0ibzTmOjG8WSNIkbUnfiWh4tGnY45udKNVHEzoNkUvt568qDleA8Q
X-ME-Proxy: <xmx:zDidamZ-kDbBJoYIvsjFQMbacVFh4NX523mfwlc6u6mjfV6GFJ9WZQ>
    <xmx:zDidamnMVR270UdgtybfWAZQG-N7jwdtd1Lv66TNWM0FB4GoQ6_VVQ>
    <xmx:zDidalfXsQmi2MKKg3NSHDXmMzLPZFwIawKPrei5m-roH3slkG3JJg>
    <xmx:zDidak3hLfTA2XpWxTCIsU3cbdLYL56jszObYjKtzyoVJljURXG5Dw>
    <xmx:zzidan30H1w0rVYqmvBVGQmpZerrLRor3Amytml3XW-bQaxl2dMSTwn4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A882232A0078; Sun,  6 Sep 2026 05:56:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIGO_lBJxreR
Date: Sun, 06 Sep 2026 11:56:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Morton" <akpm@linux-foundation.org>,
 "Aaron Tomlin" <atomlin@atomlin.com>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, da.gomez@kernel.org,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com,
 steve@abita.co, mproche@mail.com, nick.lane@mail.com, rishil1999@outlook.com,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com>
In-Reply-To: <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
 <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
 <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to built-in
 modules
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 6, 2026, at 02:28, Andrew Morton wrote:
> On Fri, 4 Sep 2026 10:59:38 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
>>
>> In summary, this patch brings parity between modular and built-in drivers,
>> removes a pain point in boot-time disaster recovery, and provides users
>> with a predictable, consistent interface.
>
> Really helpful, thanks.  Please add this to the [0/N] and maintain it.
>
> I don't really know who are the potential audience for this change, nor
> how to attract their attention.  Greg might have some insights but he
> wasn't cc'ed.
>
> Let's leave it a week to see if there's feedback then resend with these
> adjustments?

FWIW, I previously asked the same question on this series
and still don't find the explanation lacking. Obviously,
consistency is good, but the added complexity doesn't feel
worth it here, given that this still has most of the same
problems as the existing "initcall_blacklist=" option [1].

I think patch 2/2 would be fine on its own, but for 1/2
I have yet to see a single example of a real-world problem
that could have been solved by this but not using
initcall_blacklist. In distro kernels, almost everything
is already a loadable module, while users with custom
kernels could easily turn off the drivers they don't want
or disable the initcall by name.

      Arnd

[1] https://lore.kernel.org/all/78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com/
