Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107037F01F
	for <linux-arch@vger.kernel.org>; Thu,  9 Apr 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720669; cv=none; b=ggLKkDg2nJLyC20WFecjqXzy35/4A/UKXDME6t1e2w4fty6HFtLBMozjzZ+96VFeE6VnfIJkIJPpVXAu1IEk3b5j0ziVAc3Ul3TzqSloppiosQ+ZVdvvRNOK4wT8gEb2BSqCqtA0T5C9oorz+MOzvzjeHyCm+sSbhAhk9b4Jewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720669; c=relaxed/simple;
	bh=JHc0rpT0VXACQqLal9pb1BOk7zluaiOXSCKc5SYV09c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6B8vEpWLchAGafScxVFHm0Tj3apUN3UNYDcZwHoe7oBNS0zmXalz6JB7y/VmoiwDLVvcrRzIHnFjrKDVlUfLYigXquxcNyMqZwT/f+SGNRLRy8V+vSwDjNZkA7bR2MGsvnuJ1LgzeArk4+jRvrUzTxXlI4QEJEE2P7e3pcYX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO+NcJvH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO+NcJvH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so6542225e9.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Apr 2026 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775720667; x=1776325467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zM/QUh5nNxcZ3yr09S8to3CJRO3tIlUiWsJb2TzILo=;
        b=SO+NcJvHFD/9qe5Egn3P6W48F9CZYzAPtrX4GdPVGj6g81/E7eZhu2lVIvZxQfA118
         G5PONf+ut98XxNhHFDxd8IR/kHOMMgXsvkfBd/T/Pxy1MdGs5R5bz3l4+XjhJtGN16wq
         bc5nQ0YyAldvDNkDM++3VlkHs3oEt3dxlCVePCwOBYBpe+8MUIXzoFWdXcQFpZkwLc/N
         d8Lxf8uss1M+AkpgRWnHIdL+G8b6bNVN3MZninzXxN8cSoV6F6ISO1qrOB4a9EYiTJ0Z
         IUczTDc2hIDx2Z86juPoCMQGvDV6hYARmUak2ZPTM2wj9tneB7YoO5LOd97QpepX52tp
         1/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720667; x=1776325467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zM/QUh5nNxcZ3yr09S8to3CJRO3tIlUiWsJb2TzILo=;
        b=mwdoC78RAUrUoh0IWd0WM9QQ4Z3C8bPAgYDPrhCXlOpTw4xhsXDSytRra69d2Hr6Th
         bvFMI9oAqv0YQ2aBQxmLMc4FaDhqX3bs+k1W+fR2DyqQtAb8PeUjkJo5lBbKEUgxh/Ik
         xdwu454Y5lnqSixWQavFzJ36AvP+rduhdqhttuGGz9duuQS4WFuIF1ToQOnAGA0ZJlak
         ngOr9oryUW1pPqnOn+GHC0Ye+5ouULI6meUcCpzwlJ0EOat86TY1dfaNeNVxwJGbUxCc
         20TDR369wyA/QjvjqW20+5M0VcG010PGnK4hKtAg20llkjVbr+dtT0jyRE6CCFm7TQIa
         oDuw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/XgwKyDFSRqiZYweMQgbH7BaAIP0M/qY8InjagpvXvAEgTemZT5ziN6TiUccXS/MAhVMcVkoQVud@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVyEI7J62tmCnXJk32ulD7q27UFRn/RJWnUsbHFitE0aa6Osc
	1TxgMoucsWVtbK2ZrWkfUPT+21MmCl7dQINQDE7MhBwzRBGw2nUsTXxh
X-Gm-Gg: AeBDies1YaQmO2UY39U9LwMV4RjHwzf5ZW3zyjEXicgDSCckMwgOuQI0Hw3TQcr2fni
	bTNu9gymDyNV3U1f9z6dfQ7/vDDUExC2NdVAlTNrzhu358tEr6DmBhFbo9nroEdTXFr7Qo6uz//
	KWjEDH9eJxCvcXuIXy7yh+qb8AtW5L8OpYhJ1yegEvhfCc00WifZc7ztretmziCWIesRZAkMTnQ
	/hZknftWScS8cUh36ZogdaOMhkTPZQeHKS6WRZ5t+1G+mlrIuEi0aytiHi5HdJA7tUyPOd/R+Xe
	1SspU0IFLeUokc+8CQPBZ1AMdEW1qaOJMtTyWBw2WPNRNgFbepjfTpN5eVL7DoZQI/FPfzsN//O
	qzR8Z9XC+kmCPfTByxcVEj9Zx4e8flCjuFi5sRkAPXNMFLzBRiVEpTCFWeflomc4s5c+5h+DdKa
	ZG4XJSlaHrqhu+IiuWD1T2DCyQiH8/BGFN1VGjSZLpkSKX3IAgZo90hLrrLAZ4ux/I
X-Received: by 2002:a05:600c:5292:b0:488:8c89:cfaa with SMTP id 5b1f17b1804b1-488996b021fmr370012665e9.3.1775720666526;
        Thu, 09 Apr 2026 00:44:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cfa759bdsm33438345e9.12.2026.04.09.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 00:44:26 -0700 (PDT)
Date: Thu, 9 Apr 2026 08:44:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan
 <shuah@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Alexander Aring
 <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Oleg
 Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, Jiri
 Olsa <jolsa@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai
 <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <20260409084424.6030eea2@pumpkin>
In-Reply-To: <1333067272.1649333.1775682991132@kpc.webmail.kpnmail.nl>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
	<20260331172011.3512876-2-jkoolstra@xs4all.nl>
	<pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
	<1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
	<CAGudoHE-zSfiL2aVf41UHOtMsE53gCqLpVoy-NxoB8HeXtdgEA@mail.gmail.com>
	<1333067272.1649333.1775682991132@kpc.webmail.kpnmail.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Apr 2026 23:16:31 +0200 (CEST)
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> > Op 07-04-2026 11:00 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
...
> > I am not saying it's impossible. I am saying mkdir was always a
> > separate codepath and in order to change that you would need to add a
> > branchfest to open. I don't see any reason to go that route.

The open code is complex enough that an extra branch won't matter. 

> That's a fair point. But there's also upsides like Aleksa has mentioned.
> I'm not very opinionated on the matter, especially since I don't know why
> those paths were ever separated.

I doubt they were ever joined.
mkdir() is more likely to have been separated from mknod() when the code
to add the "." and ".." entries was moved into the kernel filesystem code.
I'm not sure when that would have happened, mvdir() was done in userspace
with the link() and unlink() system calls until (at least) the mid 1980s.
It was probably the complexity of locking in SMP kernels that make both "."
and ".." be 'canned' names rather than just references to another directory.
(Yes, it used to be easy to make ".." refer to the 'wrong' place and get
find to loop.)
Of course, this all predates Linux.

	David

> 
> Thanks,
> Jori.
> 

