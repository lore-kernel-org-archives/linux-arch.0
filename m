Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245626;
	b=nS6r8nd6gMm0K9d6jG2t2TEdNVMgeijdsxW6itWYmEZ2PvMPqsCGIcFpbzcjkCsIoszL
	 EZ3pCJnnPQp56i8qCn+3ofhrEDMB/fk2Tk6pwh7JmePOhprKPp0KFF/1C0sKAqQiFWySE
	 IEEz4Bx90bWs9eZxI8O/devR5hS5a66MC/pzWR70sp90nOXw8nQgeVhJWSHSWCDuq05xS
	 XBjK9x7kufOW90q9TaQaQ5IwxQchvWE2yOsPK1cOwGQcree1jL0H2j7voTQQsUh9svqc1
	 Xwrn7nQLd9zqA3Ksa86yAhHhVGgplFUaSFSQWxzHjEK7K/fC5EqWBO+J+TMii26O8VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h8kq6Pl9NTWK4dw0Rh3Cdb4b4qd62zLH0TTeqwKDwHY=;
	b=SYUaHesAfdXDf/EW3DQVtaQiHzd84kuzf+pslWOb4x11wdwBPLisHO2NCBFc5EekKXWp
	 loTeN6WmtncwCjAXtrrgZMI+GWgKbhKErhOYhLoJduA5Ztp2/AgUaa4ei+bbTjgUku7My
	 aHABIoCl/sM3raM/jPMi/M3GRX08vAA0yvlsriImEWT//3XuWI4GGOcrW9IejINvmYLEE
	 JUm8sSO68J2wvGTM3x/6KDz98uak+onn71Mq0gdsF6GFJQjbtOCi+GIfyR/gCDr5OXOXf
	 uuZ3EfIcsl06rjKp00td+IKIToYswXN5m7TXyoIWBkX5JSFy353ke+o+byQEKbbInww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rdevqk10;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A6606A31A
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 03:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rdevqk10
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9f6a16aedso10780685ad.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793245625; x=1793850425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8kq6Pl9NTWK4dw0Rh3Cdb4b4qd62zLH0TTeqwKDwHY=;
        b=Rdevqk101cr+v9xciAZsil4BqLgOOYPJCQQU9UwUBlzdc78kr+WTAffXPya3G+p+Ra
         +dIw97dMpGxDRnaRgGttsVtThIKggdWJFJhkU0PfGEUEBSEE7JMoXNpZoU/uGn6AAkMQ
         RgAFeU/1qrGEav+3t+wxhuVVlRniLqpBA1Kg7nMLIpwYnZpMlYTwTqPDCshZKGmQ5LA0
         I/S1nZLdYhgeTsDCqR5qP/gixcwfhmB86L8hG9bqty+Clp136EgDpmYfDoMqcAmPwALF
         qmGNMpbeks1sSR+QQIyrPP18qTE3uF5X14cRzD6ZWMnkWS/WGvF6pqeughyFfalIFudR
         lVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793245625; x=1793850425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h8kq6Pl9NTWK4dw0Rh3Cdb4b4qd62zLH0TTeqwKDwHY=;
        b=jTbmzgpG6sFydgGicrjosKoD6jmkx8i7BZQMYdCCl5TAlXnk/WVrt5dKWDBojjDxe2
         vE+2TnOHYKu7r1bVN3wysqvEyeYD7pR9yeyDeqEETwrFJd9lafU6F7UMSPN31xePuq9s
         TZvg1aUpw8FYso86rjuMtRuCF9LNSPq4KIZDpEGr20etfiFB6LWaLjTKdizLj61hLhUz
         PB2h5kffsGeNEqR7O2y59tybOou11hoo6IlDiddjA7TBerHQleYOYeQ7I2CmmOD+g2l9
         qLxwnco/Pgl05Z68pm+f9FqSZO5WEQWtLfDjYrUFjkd++9Ptoub8efDbUwEd8bFcQ60/
         OpfQ==
X-Forwarded-Encrypted: i=1; AKwUvByjlo7/lph6x3WX58gMnDXxuCy8n/ona7CMDz4yyR4tgX2nOZ0FaaBzMiqsOQyRwX0sj8BwRr7G90Bl@vger.kernel.org
X-Gm-Message-State: AFq9FYIntLNnFCQ9i+5pjHVP7+L77D8iF5eY2gnKH/Ov/nHSN3kuDW7X
	MqxCxI//bsq5eirN9YQlwDbURejqFBV71E+lYf07ev+lJI5sfIeaBVm5
X-Gm-Gg: AYBFou0Q61Sca27TScUXLfDSpvwMeZZeYf72Vxy3L/hkuj0ZwnCjqE2mSAPzHyAPFNK
	SOIagDImdulKFLo0SBsV3ryH/PG27V8BvpNFKWkB3bZ5ECn9ktDQ3QI02BE3MYAi42daJsrJcwX
	OuP9s2GowGLpI+eK253KdkvvQ1EsEqOn9ZSViz6TMc51UjEsAAqFPHgtEsHfU9jSp4QaiCua3pe
	UHjS3IKBqdSAHSfv3thmu3kS9jlaKAuslOtXBfHd1Cz2Vsy4qlXLspnsGNFHZogjuUglBkgoEx7
	VrjZ3i1beTgqUBtOwVY9pj6ny58G+mPYFzUdOutWy/mdbXTAuaLRvFATPOqoY0f37/XMIqb915y
	5klYTsw2Iqx3fc7NtI5sB/+oAUnyBKIEvDlKhrQlEdXzGCki9YdZeNMNRcwzI87UqKWcoKKBfXc
	rovChNA7QokWfE+YfskM3XaVtyjGM+XGCZU9ICcpnfR8RUdnMFAj5SyvGVJzrVG4jheOH1Lme2l
	glmSph5pInTowO13YkcAfjTMvsyiThaaTZ7BqQD1Iuem0HExG4GXu9fFnd6sCZFMoDdhFJW9xYD
	ElF4+muGy2R0DnS7nRiLDji5Jl2Ut9xQgB69eeMndHmBdkbh+8CdMvY=
X-Received: by 2002:a17:903:144f:b0:2ea:4c42:573c with SMTP id d9443c01a7336-2eb0054f6aemr38499215ad.51.1793245625415;
        Wed, 28 Oct 2026 20:47:05 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b76df7sm28619815ad.14.2026.10.28.20.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:47:04 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <ynorov@nvidia.com>,
	Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Date: Thu, 29 Oct 2026 11:46:58 +0800
Message-Id: <20261029034658.3137810-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <auIQ2RI89C374je2@yury>
References: <20261022115922.1210342-1-shingekinocore@gmail.com> <atpm00m6KYhXo6Wi@yury> <20261023140806.1367050-1-shingekinocore@gmail.com> <atuBH6-LHueXYbFy@yury> <20261027062319.1700461-1-shingekinocore@gmail.com> <auIQ2RI89C374je2@yury>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 28, 2026 at 11:12:45AM -0400, Yury Norov wrote:
> I wonder why the older GCC works better... Can you make sure its the
> same kernel version and the config?

Same tree and config: both tables compare csky/linux-next at
abb81e5ce7d9 before and after the patch, with csky defconfig (CK807),
built with kernel.org GCC 12.5 for one table and GCC 16.2 for the other.
The .config files are identical except for the toolchain-derived symbols
(CONFIG_CC_VERSION_TEXT, CONFIG_GCC_VERSION, CONFIG_AS_VERSION,
CONFIG_LD_VERSION and CONFIG_CC_HAS_*).

The Before totals differ because GCC 16 emits more code than GCC 12 for
this config, with or without the patch. __fls() itself compiles to the
same 4 instructions (8 bytes) with GCC 9 to 16, before and after.

> Anyways the numbers show that the switch to the generic implementation
> is worth to try. I've added the numbers to the commit message and
> pushed in bitmap-for-next for testing.
> 
> Conditionally on the (so far, missing) csky engineers feedback.

Thanks for picking it up.

Tzu-Ching
