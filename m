Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F5374E74
	for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2026 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292658; cv=none; b=qxC6IwkGtLXS/L7IIZp40eszGRZX73a5psoZt5Rno8OcQy5DlVYVmnO2i0tFENIhkUp87Q+IQLkJ+qbkRdI/KFrTDyuRU582vkwI59q0BjfHrZOmMe+ohuGLTUl3i/LNBbvR862KI8bXHfKBRe7c/+sQ20SM8NVz8IgRUY+ZdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292658; c=relaxed/simple;
	bh=Bejh2jagMXk07J4vN4q2aCTB4moMnQx6GKX/VG2wuG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1F9Qt9g2Dbe7mt9qP0pJth6UOo35tDwyxw3rD956BTVG9Fditr2yyRvJ1EA2XTTJsHd9N2jxwf63ZOOsM6WPUrDKZh7sBd0MTqyKh6iIZNNZMV8nSzV2Jv3mA1qegjfa9p6ujDcAgkIfFnSl+eR06cDgNp/nbVCvA5AiwPykq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YPb+kCzh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YPb+kCzh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so7958945e9.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2026 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782292655; x=1782897455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMXKleFLZJBIvs4jrEU9E5muXUV27zhjMd5mE+UdPj8=;
        b=YPb+kCzhvInwP5YN7rsvzQBBNoG40zAZnVr++ZpH0ij+Hr29H8mIyOxLyKtouyHHIk
         P32gMty1X6uxpPiDvYzJfEgsAa8pznFeBZEkHCpnexlREolBL/feec97BBD5pjJQq5jT
         Plkiwow7xpSNXDhKRQxtBe5XnTB8ISMSZJg5DoJC6iAnccgnl/iBEGLYstsbzqH1+I3S
         QaaL8KaYFgofONcqdbh6y538zW7Vq2Fyw5Q3DjfxKAp1hlzV55ooJ93cd5yZ+hoefil2
         ssJVgccj0KyxzFK4O1yVb8R3Q3KRmmqiVFs92d9qt6adEZ1jCw9LOWHLqXw7JaXugndU
         LSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292655; x=1782897455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMXKleFLZJBIvs4jrEU9E5muXUV27zhjMd5mE+UdPj8=;
        b=mvMPIAxv86v+gkvaG1sIClckJXTyiWmhcpbuzZlU3jrkDuOtuupJsCHhID0/goD1+c
         V0lwP3P4RmCHFtBJggUQ31FzMsIDpeJpXW3TNTy7K66V56N7MEgLAoO07lMzVGtL6afV
         UcFl5PRPq0Q9Tt7PFN6rN/ojuRyWGQMCmuJicLSZd2Dgqlkh9c0ERIvYn4r/DjN8mKB/
         7kJYu4ADq1QlN0yIjx7fetbhFMkXimkunj8bxOagUMXXAKkZG0YhC57x7yGVPTKQBbDX
         cvyyQ0JSOGS5Qa58YEbcguCbDn7K3zPdp9/PwQ5drq3mY8+syU91+eL6pD8Ezv0qY6iN
         VR1A==
X-Forwarded-Encrypted: i=1; AFNElJ/pPjjtAvBqkgzL1ephR7/t1XpTY7Fej1Nk/vyaJDAH/UR6Es3mXhdaEx/bKeRghfL0l2k2ojns0yUG@vger.kernel.org
X-Gm-Message-State: AOJu0YzIksmc9HErEK7bthGWgIbg9X/RL2iz/nGl73sBtmV0kD+TQLC4
	MyKuuyLrSn2k+rkidzNAc87vule5QFaHmgdKJ5ivMhBYo1/CKqk4y2o/A23bKjmUBNYu9yyUJHr
	46ABo
X-Gm-Gg: AfdE7ckEsen8z1hCudUifqtAnqb7j0Zot4k6F61oIjigkQUZ9RwZ9eKjgEhFkxHwPca
	P6Jm4M7zCU0WXKmmiSPkLplHbSYAjupeTXiYD2fZmSLh4OJ9BqsRnjFXQo3JySag0AtWd9zRj8q
	ndiYPB+6h7FqkqcpHBhPlkJtYiF8rajBO6M2EtPr/PhL/rviluIlVvI6nj9YsM6989l4hDkxJq5
	xCVvhcuu52tgZn3JMJYH6k12xEJPAtkq8FHFS7Fleb1XPqN+iRS5uMbqQGizl+t/UKSuCPdK48P
	ozU5SulyBf42LcV96cfLoa1WoBdB/xwnMFblVCm4MKcKjvVAIsnGWCIr8kl5GsJuJjNhJqYlmzT
	KSLcaAnfc/7CF6223Nqg829AZQeZ9lBRt2SfaGu3pvHtkzIf325b4azlL6oWFuNZzXJt2B8kSFV
	TzkymuTfIWpEfN0rk=
X-Received: by 2002:a05:600c:1d16:b0:492:5855:1548 with SMTP id 5b1f17b1804b1-4926087830amr31471525e9.27.1782292655197;
        Wed, 24 Jun 2026 02:17:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm412331495e9.4.2026.06.24.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:17:34 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:17:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <ajugq8VAciqtMx9F@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624062642.5DER6vrP@linutronix.de>

On Wed 2026-06-24 08:26:42, Sebastian Andrzej Siewior wrote:
> On 2026-06-23 20:24:02 [+0530], K Prateek Nayak wrote:
> > Hello Sebastian,
> Hi Prateek,
> 
> > nit.
> > 
> > Instead of replicating these bits, can we replace that return with a
> > "goto out" ...
> 
> sure
> 
> …
> > ... and replace this return with a:
> > 
> >     return (warning) ? BUG_TRAP_TYPE_WARN : BUG_TRAP_TYPE_BUG;
> > 
> > Looks a tab bit cleaner to my eyes. Thoughts?
> 
> It sure does.
> I wait for PeterZ' executive order to either do this and sprinkle sched/
> _or_ make legacy consoles deferred as it is done on RT.
> 
> Petr, was there a big push back doing it unconditionally?

For Linus, it was a no-go, definitely.

The problem are situations where the system gets stuck and panic()
is not called. This is why nbcon consoles switch to the atomic
mode in some emergency situations, see nbcon_cpu_emergency_enter(),
for example, into __warn(), oops_enter(), rcu stall, and lockdep
calls.

Moving legacy consoles to a kthread would prevent stall in situations
where printk() is called from the scheduler code. But it would cause
that some other stalls become silent.

In my opinion, we should not move the legacy consoles to a kthread
by default. I believe that the rest of the kernel is a bigger
source of possible stalls than the scheduler. So, the overall
experience will be better if we keep the status quo.

I would vote for adding the WARN_*DEFERRED() into the scheduler code
at least until majority of console drivers are converted to nbcon API.

Best Regards,
Petr
