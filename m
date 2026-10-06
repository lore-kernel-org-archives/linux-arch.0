Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DB49C4DE
	for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303062; cv=pass; b=i+rBD9fzNvbqh1crcWowOeixNf32lT7/I7VKKWG9+Q2ojvtBkeH26lbb02urRnOFSqFiiNuKPQOIf3Vtwi31p5G3WWieo6WfHcIKz/1/NnZq6EpHvqHVE7FUnb5kFVp1EUqkMHFFKJjGYCYPu/MDj9WA9iFRvVOmM6ZZu9XO/ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303062; c=relaxed/simple;
	bh=9WCkiE19cbtAuYYQ4uqsh1anpnBBbEDR9fWCfux10TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRjXCNhVF9ziAGjG+QWlCrkFGE/9rAGuYEZZ3YwlW+4NDwlk8l7YS7/HIVJ50pyM0+hGzVKIRBVKRKAhGOyB/RHgNdqwkhAs5K2a1+YiZdjmG0EQf/0HLATWFCLh29w1SYjcUIm724jDGEJBDjqRoCU5leiCJ4SBLkjsDsOZCks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAol/EVW; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAol/EVW"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab38a051aaso8455427b3.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2026 09:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791303056; cv=none;
        d=google.com; s=arc-20260327;
        b=QbRr57xggzkIeXQeQPkwi+Ec93wIxG0OwSUyS/ezq05sKejrZlLjoxk7QqfSR9VbG+
         zbMZNEnhWP1LOlL7osjWpKCH9creTiiA/MJxQKulgNZdpupS/aHLCC8mXjBLAx5tsQDu
         rSTEKyykw6Ck7xbkvviI6EdPYJml91aHiW7zPefvDSS2HHBs4M4x8MYpZu2+gJGreE7z
         ACgkqIAzRvB1bk9aIiSFFC3YUYG0oTX2jzWboKszNWCKqAvhvvLCEGUUSbH4MQA09Vp8
         FzYJ1fQAqJPOPBF3gCV57DfEYqyqQd6XZGVWY98OoHIyZgHz4GmmTzUyEA1xcnNdVUfr
         wxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        fh=1XsI5cq/DlZZwf6GVp2AIg7ux+fRUm+qMnEHnQ3P6TI=;
        b=TmxG6FZnHqXddo+N23FySBEapPn3W3A06LVgdkVJjLm3JsJqEZRVaHHGThent7PiVR
         2SsPOmhm0Q3ZavT17XuS1zgdYNxQyHZmdvNyxmZFkQim1shJcYutEZ2PJvLaKTlFpre/
         QaaEsMwp9BFsBViVSI7Ioq2eLjQTL7OU6XimDROX4u/NYyj5OiSb2HAXJeppmGv2Pswy
         klzCqRelSGuV1KDt/kfz2u5wHrxgr1IH6ry+UBXWT/pFhu5xdwlAdkdvPPhRZykToEmw
         hRooAZ7hrZMNHe95w8HJiJTH6JhnQkVXiHuPPZMePj5v3RXrrTwKjXKVpWgIA22V3qLz
         R/Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791303056; x=1791907856; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        b=KAol/EVWndwCAAefTkH6Xt23lTKfF8bg89lV6Q/YwYVIALOx+VT+A3ReJEZd7mhVHY
         u5uAwWXDtUNCGzoumqWqKUFMxCuWAqWc8E48Bs4q8GQJ5DV/MYyK5FkbCaVdzSvlgJAj
         WpVwnmuRWxclQi+qIP4Q+Q8r08cIMnguge2IESogruJD5JBKihZ7itYtdLHX42G+43CT
         9v30tzlxMY8Uz6u7pbHeR+g580BmjbeMFh+TLSDfjduVagvTeg3hroCyqU1v5CFFmeXh
         hlI6dVwjfm6h1J5fH+akAR/gBAnRkbR9KhvIjbt91Gqw4uC9O8uVloodiFrKHYVwC7xk
         cjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303056; x=1791907856;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        b=h2nOMzh+4pNSm541uKO+T8HKz8ogS826IXuml0WoqIrHaJGbdi9oADWdvKcMS7GpNf
         jyLHME4tPpm6DWp4KQAllasjpNCJmKkmZCQ07GlC9uTlAvyOcgIFsPHxOo7X0O1xaZLw
         ZPoNZY6bK/X/RQqS82Ej4/26tTqrWJy/0oHY78L2DyRK8ELuk1BRTHSSEcaP10EbSJnS
         fzqiOzxVb4NCRGLQ6kOiZzU3qyiu+Uw9o6xkknGN+jNQF91kI7pImbxMRbAv9Kpmyxxo
         iqb6OIhhNsTObMigZd2CScK3iHMTWUXyZITdvnatY35afFERpkcvBcWIr+JzNLe8kQpN
         fkCw==
X-Forwarded-Encrypted: i=1; AKwUvBxZMXmMTiDtzRe4D9qJ4rGu/HFV+sFFtRU3cvRamRghJAZEifx5yVyBQNEUYWMEQGfzYpCoQJLM+6vl@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8L5EErioNBB8Ap0B2Q6OU2xp0Lk0SewH5GHFSVm+MqBlcHjxC
	iQPLq7pxUE8jt4rTz9/9UhTsNEl6LTLzBcm2whF7UXoA6fb49TSMKGTTlKAQixF0ya94IssfL/g
	xaxwL+6xmAKxVJjWPT/4qBd0K3VcM4ZLUJfM96cGt
X-Gm-Gg: AYBFou3tj1LAxBlL+WqbaQuWV6VUGzgoRPR2WSkm/dIu+6JMgHDIO0mBcpHnRqX8Qlm
	tg58+vWpZ32BkuSNTINAw0vCnSxwxOLiA4qd1JtUrBhBaFgdycyyVt/9V+3feK53gxECgUaE9lz
	en07YHZtlL0hHECXnwvGTEjQD01uuq2jH+wTyBnoLqeVwbr0AtuGJjnrDat+FYy1j1+EHYJ919r
	jzXiNJhYdshY99U3/VvLmxRNCSHYGCPcgpcz5743CmTpSNW7344Vz96QW3EVZQ3MGzJFcX0iRl3
	xe5c8e9g266ql8cHgOvQIF3CnC0Ii0sUW7usjdmiiu+OaqbeWXZqJA==
X-Received: by 2002:a05:690c:5302:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b04f40f097mr9171807b3.12.1791303054779; Tue, 06 Oct 2026
 09:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
In-Reply-To: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 6 Oct 2026 18:10:17 +0200
X-Gm-Features: AclHuK_OeB6Z7-eCIUVq_1RabrgIKOGeEVPLb2q2UdMqE46rpsfhYWgMuA5UU2w
Message-ID: <CANpmjNOaykC4McAj=gZghqPSQc9aGBP_CjgKmp3n2yjeJTxDSA@mail.gmail.com>
Subject: Re: [PROPOSAL] Replace gcov and kcov with llvm-cov
To: chuck@wolber.net
Cc: kasan-dev@googlegroups.com, nathan@kernel.org, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, oberpar@linux.ibm.com, ardb@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu, 
	johannes@sipsolutions.net, jpoimboe@kernel.org, justinstitt@google.com, 
	kees@kernel.org, kent.overstreet@linux.dev, linux-arch@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, luto@kernel.org, 
	marinov@illinois.edu, masahiroy@kernel.org, maskray@google.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	morbo@google.com, ndesaulniers@google.com, paulmck@kernel.org, richard@nod.at, 
	rostedt@goodmis.org, samitolvanen@google.com, tglx@linutronix.de, 
	tingxur@illinois.edu, tyxu@illinois.edu, wentaoz5@illinois.edu, 
	x86@kernel.org, peterz@infradead.org, sashal@kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>, Taras Madan <tarasmadan@google.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 17:14, Chuck Wolber <chuck@wolber.net> wrote:
>
> Stemming from some hallway track conversations with maintainers at LPC
> 2026, I propose replacing gcov and kcov in the kernel with llvm-cov.

I know the origin of the discussion, and wanted to chat, but I guess
that didn't happen and instead we get this proposal. It would have
been good to understand the requirements of users of gcov and kcov
(more below).

> llvm-cov instruments at the AST which enables precise mapping back to
> source code regardless of optimization level.
>
> We have a set of patches [1] that implements kernel based llvm-cov. They
> need to be updated and some additional patches are required to address
> some stubs that are missing noinstr annotation. But otherwise I should
> be able to send a full set of patches (including taking on the
> maintainer role) to remove gcov and kcov and replace it with llvm-cov in
> fairly short order.

The hallway chat was supposed to figure out if there's a way to bridge
some of the gaps, but jumping the gun like this without having
addressed the requirements of kcov users does not make any sense at
all.  As for gcov, llvm-cov was designed as a better replacement for
gcov, so that makes more sense.

Ok, well you made me untangle the most important differences between
kcov vs. gcov/llvm-cov below so we have it for the record.

> If there is a desire to take this in pieces or implement other
> intermediate steps, let me know. Otherwise I can generate a monolithic
> set all at once.
>
> [1] https://lore.kernel.org/lkml/20240905043245.1389509-1-wentaoz5@illinois.edu/

llvm-cov is generally useful to have; llvm-cov is closest to gcov, so
that might make sense to replace.

KCOV, however, cannot be replaced by llvm-cov. KCOV isn't a coverage
reporting tool for users, it's a low-overhead interface for fuzzers
(syzkaller/syzbot and many others). llvm-cov has no equivalent of:

- per-task and remote (kthread/softirq/USB/vhost) coverage collection
(to avoid polluting coverage with concurrent tasks);
llvm-cov counters are global and polluted by everything else running;

- ordered PC traces (edge signal) and comparison operands (TRACE_CMP);

- performance: a per-task mmap'd buffer reset with one store, vs.
reading/resetting
megabytes of global counters after every program;

- GCC support (we may want to keep at least one GCC-supported coverage tool).

It's also UAPI (include/uapi/linux/kcov.h), with existing users.
syzkaller heavily relies on KCOV's features above to achieve good
performance and coverage; there's no reasonable way today to migrate
to anything else.

As-is, NAK on removing KCOV. Consider replacing gcov with it.

Thanks,
-- Marco
