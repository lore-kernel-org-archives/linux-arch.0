Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3651917CD;
	Thu, 25 Jun 2026 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431413; cv=none; b=KAbsf/obhXqYjDxkckM/jqNMcD1eVnQ6vAd2amFWqxMkYordl9UdUJfGnxXd0VK9TgEpJloZlqxjU+SHTeWxQwS9jeyCF+HPD8s6GukFnhL9IwrJHceuyS7Ea8fFg99z9pELuuuuKrqTLm7JR6aIC9fGs0f2uuii3wtWwnpJ9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431413; c=relaxed/simple;
	bh=b/uzxwEipj/Efz4MXpWRmScHzZ/r1bhdcMgpZhRcZRA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cgBn1rZko/4+Opg9dBglQAOYZVah1+SOZ+JAF9dr2yrkYtFR3JCdLbV32KYr+8vyKvIO+NeJJEo4s+t5iUvp19aY2d4jam4eTIidBnGTs2BZWaa2Qn1Epmeu2AiZlFaYlGQW01i4bIrEeshicBWy/XD0EwRWWsnB5Bc8jcBPb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V+A7P8ux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V+A7P8ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEEB1F000E9;
	Thu, 25 Jun 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782431412;
	bh=R1YH/25jH8EUpnUYE4yYe3IAuRxDTUoa/BzAPS6Us+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V+A7P8uxAtf89viHayjsoJigHhanmOpAi9FfKGACSN9DGz5jlM6pdO8WDxGk2SvpW
	 FOATRzor8tbMA246cNjmKDqGuPC51MxrTIAR6cQWrNjP21f4QLSl8FRAmMwsPlskEa
	 hZftnM+m3orh6hScXPTr3VBYtNpa1dul2/P9W3cM=
Date: Thu, 25 Jun 2026 16:50:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, neelx@suse.com, sean@ashe.io,
 chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
Message-Id: <20260625165011.63b47ca601b6f871797d98ac@linux-foundation.org>
In-Reply-To: <20260510061301.41341-1-atomlin@atomlin.com>
References: <20260510061301.41341-1-atomlin@atomlin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 02:13:01 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:

> At present, identifying the correct function name to supply to the
> "initcall_blacklist=" kernel command-line parameter requires manual
> inspection of the source code or kernel symbol tables. Furthermore,
> administrators lack a reliable runtime mechanism to verify whether a
> specified built-in module has been successfully blacklisted.

I expect nobody has felt a need for this in their day-to-day work, so
the interest is low.

A detailed description of the use-cases would be of benefit - help
people better understand the value of this to our users.  I suggest you
add this info and send a v2, if motivated.

> To resolve this, introduce a new debugfs interface at
> /sys/kernel/debug/modules/builtin_initcalls. This file enumerates all
> built-in modules alongside their corresponding initialisation callbacks
> (e.g., those specified by module_init()) in a simple format:
> "module_name init_callback".

Isn't this information all available at build time?

Can we extract it and put it in some file somewhere which becomes part
of the distributed kernel package?

Or is it possible to write some userspace application which processes
the files which are typically in the kernel package and which extracts
this info?

> If a built-in module has been actively
> blacklisted, the entry is explicitly appended with a " [blacklisted]"
> suffix.

Can this be added to the /proc/modules output in some fashion?  Perhaps
just add TAINT_BLACKLISTED and we get this info almost for free?
